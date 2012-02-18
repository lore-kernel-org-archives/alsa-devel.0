From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: core: Add support for masking out
	parts of coefficient blocks
Date: Fri, 17 Feb 2012 16:49:51 -0800
Message-ID: <1329526192-6747-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120218004909.GA6712@opensource.wolfsonmicro.com>
	<1329526192-6747-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82F97103BE1
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 01:50:11 +0100 (CET)
In-Reply-To: <1329526192-6747-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Chip designers frequently include things like the enable and disable
controls for algorithms in the register blocks which also hold the
coefficients. Since it's desirable to split out the enable/disable
control from userspace the plain SND_SOC_BYTES() isn't optimal for
these devices.

Add a SND_SOC_BYTES_MASK() which allows a bitmask from the first word
of the block to be excluded from the control. This supports the needs
of devices I've looked at and lets us have a reasonably simple API.
Further controls can be added in future if that's needed.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    9 ++++++
 sound/soc/soc-core.c |   75 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3e9cae0..82bd773 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -192,6 +192,14 @@
 		((unsigned long)&(struct soc_bytes)           \
 		{.base = xbase, .num_regs = xregs }) }
 
+#define SND_SOC_BYTES_MASK(xname, xbase, xregs, xmask)	      \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
+	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get, \
+	.put = snd_soc_bytes_put, .private_value =	      \
+		((unsigned long)&(struct soc_bytes)           \
+		{.base = xbase, .num_regs = xregs,	      \
+		 .mask = xmask }) }
+
 /*
  * Simplified versions of above macros, declaring a struct and calculating
  * ARRAY_SIZE internally
@@ -904,6 +912,7 @@ struct soc_mixer_control {
 struct soc_bytes {
 	int base;
 	int num_regs;
+	u32 mask;
 };
 
 /* enumerated kcontrol */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ed9138e..bb01c02 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2757,6 +2757,25 @@ int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
 	else
 		ret = -EINVAL;
 
+	/* Hide any masked bytes to ensure consistent data reporting */
+	if (ret == 0 && params->mask) {
+		switch (codec->val_bytes) {
+		case 1:
+			ucontrol->value.bytes.data[0] &= ~params->mask;
+			break;
+		case 2:
+			((u16 *)(&ucontrol->value.bytes.data))[0]
+				&= ~params->mask;
+			break;
+		case 4:
+			((u32 *)(&ucontrol->value.bytes.data))[0]
+				&= ~params->mask;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_bytes_get);
@@ -2766,14 +2785,56 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 {
 	struct soc_bytes *params = (void *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int ret;
+	int ret, len;
+	unsigned int val;
+	void *data;
 
-	if (codec->using_regmap)
-		ret = regmap_raw_write(codec->control_data, params->base,
-				       ucontrol->value.bytes.data,
-				       params->num_regs * codec->val_bytes);
-	else
-		ret = -EINVAL;
+	if (!codec->using_regmap)
+		return -EINVAL;
+
+	len = params->num_regs * codec->val_bytes;
+
+	/*
+	 * If we've got a mask then we need to preserve the register
+	 * bits.  We shouldn't modify the incoming data so take a
+	 * copy.
+	 */
+	if (params->mask) {
+		ret = regmap_read(codec->control_data, params->base, &val);
+		if (ret != 0)
+			return ret;
+
+		val |= ~params->mask;
+
+		data = kmalloc(len, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		switch (codec->val_bytes) {
+		case 1:
+			((u8 *)data)[0] &= ~params->mask;
+			((u8 *)data)[0] |= val;
+			break;
+		case 2:
+			((u16 *)data)[0] &= ~params->mask;
+			((u16 *)data)[0] |= val;
+			break;
+		case 4:
+			((u32 *)data)[0] &= ~params->mask;
+			((u32 *)data)[0] |= val;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		data = ucontrol->value.bytes.data;
+	}
+
+	ret = regmap_raw_write(codec->control_data, params->base,
+			       data, len);
+
+	if (params->mask)
+		kfree(data);
 
 	return ret;
 }
-- 
1.7.9

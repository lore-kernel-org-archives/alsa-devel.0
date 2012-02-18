From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: core: Add SND_SOC_BYTES control for
	coefficient blocks
Date: Fri, 17 Feb 2012 16:49:50 -0800
Message-ID: <1329526192-6747-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120218004909.GA6712@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41167103BDA
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 01:50:11 +0100 (CET)
In-Reply-To: <20120218004909.GA6712@opensource.wolfsonmicro.com>
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

Allow devices to export blocks of registers to the application layer,
intended for use for reading and writing coefficient data which can't
usefully be worked with by the kernel at runtime (for example, due to
requiring complex and expensive calculations or being the results of
callibration procedures). Currently drivers are using platform data to
provide configurations for coefficient blocks which isn't at all
convenient for runtime management or configuration development.

Currently only devices using regmap are supported, an error will be
generated for any attempt to work with a byte control on a non-regmap
device. There's no fundamental block to other devices so support could
be added if required.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   18 ++++++++++++++++++
 sound/soc/soc-core.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1e16d6e..3e9cae0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -185,6 +185,12 @@
 		 .rreg = xreg_right, .shift = xshift, \
 		 .min = xmin, .max = xmax} }
 
+#define SND_SOC_BYTES(xname, xbase, xregs)		      \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
+	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get, \
+	.put = snd_soc_bytes_put, .private_value =	      \
+		((unsigned long)&(struct soc_bytes)           \
+		{.base = xbase, .num_regs = xregs }) }
 
 /*
  * Simplified versions of above macros, declaring a struct and calculating
@@ -413,6 +419,13 @@ int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_info *uinfo);
+int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol);
+int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol);
+
 
 /**
  * struct snd_soc_reg_access - Describes whether a given register is
@@ -888,6 +901,11 @@ struct soc_mixer_control {
 	unsigned int reg, rreg, shift, rshift, invert;
 };
 
+struct soc_bytes {
+	int base;
+	int num_regs;
+};
+
 /* enumerated kcontrol */
 struct soc_enum {
 	unsigned short reg;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 14bdaee..ed9138e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2730,6 +2730,55 @@ int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r_sx);
 
+int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_bytes *params = (void *)kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = params->num_regs * codec->val_bytes;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_bytes_info);
+
+int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_bytes *params = (void *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int ret;
+
+	if (codec->using_regmap)
+		ret = regmap_raw_read(codec->control_data, params->base,
+				      ucontrol->value.bytes.data,
+				      params->num_regs * codec->val_bytes);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_bytes_get);
+
+int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_bytes *params = (void *)kcontrol->private_value;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int ret;
+
+	if (codec->using_regmap)
+		ret = regmap_raw_write(codec->control_data, params->base,
+				       ucontrol->value.bytes.data,
+				       params->num_regs * codec->val_bytes);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_bytes_put);
+
 /**
  * snd_soc_dai_set_sysclk - configure DAI system or master clock.
  * @dai: DAI
-- 
1.7.9

From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Only kmemdup binary control buffer
	if masking
Date: Wed,  2 Apr 2014 15:17:05 +0100
Message-ID: <1396448225-19936-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 461F22654BA
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 16:25:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

When writing a binary control we may apply a mask to the first register,
as this requires modifying the data the buffer is duplicated, currently
this is done for all binary control writes. As most binary controls
don't use the mask facility and thus can freely use the original buffer,
avoid the kmemdup for these cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   86 ++++++++++++++++++++++++-------------------------
 1 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index caebd63..275bd71 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3229,67 +3229,65 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 
 	len = params->num_regs * codec->val_bytes;
 
-	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
-	if (!data)
-		return -ENOMEM;
+	if (!params->mask)
+		return regmap_raw_write(codec->control_data, params->base,
+					ucontrol->value.bytes.data, len);
 
 	/*
 	 * If we've got a mask then we need to preserve the register
 	 * bits.  We shouldn't modify the incoming data so take a
 	 * copy.
 	 */
-	if (params->mask) {
-		ret = regmap_read(codec->control_data, params->base, &val);
-		if (ret != 0)
-			goto out;
+	data = kmemdup(ucontrol->value.bytes.data, len,
+		       GFP_KERNEL | GFP_DMA);
+	if (!data)
+		return -ENOMEM;
 
-		val &= params->mask;
+	ret = regmap_read(codec->control_data, params->base, &val);
+	if (ret != 0)
+		goto out;
 
-		switch (codec->val_bytes) {
-		case 1:
-			((u8 *)data)[0] &= ~params->mask;
-			((u8 *)data)[0] |= val;
-			break;
-		case 2:
-			mask = ~params->mask;
-			ret = regmap_parse_val(codec->control_data,
-							&mask, &mask);
-			if (ret != 0)
-				goto out;
+	val &= params->mask;
 
-			((u16 *)data)[0] &= mask;
+	switch (codec->val_bytes) {
+	case 1:
+		((u8 *)data)[0] &= ~params->mask;
+		((u8 *)data)[0] |= val;
+		break;
+	case 2:
+		mask = ~params->mask;
+		ret = regmap_parse_val(codec->control_data, &mask, &mask);
+		if (ret != 0)
+			goto out;
 
-			ret = regmap_parse_val(codec->control_data,
-							&val, &val);
-			if (ret != 0)
-				goto out;
+		((u16 *)data)[0] &= mask;
 
-			((u16 *)data)[0] |= val;
-			break;
-		case 4:
-			mask = ~params->mask;
-			ret = regmap_parse_val(codec->control_data,
-							&mask, &mask);
-			if (ret != 0)
-				goto out;
+		ret = regmap_parse_val(codec->control_data, &val, &val);
+		if (ret != 0)
+			goto out;
 
-			((u32 *)data)[0] &= mask;
+		((u16 *)data)[0] |= val;
+		break;
+	case 4:
+		mask = ~params->mask;
+		ret = regmap_parse_val(codec->control_data, &mask, &mask);
+		if (ret != 0)
+			goto out;
 
-			ret = regmap_parse_val(codec->control_data,
-							&val, &val);
-			if (ret != 0)
-				goto out;
+		((u32 *)data)[0] &= mask;
 
-			((u32 *)data)[0] |= val;
-			break;
-		default:
-			ret = -EINVAL;
+		ret = regmap_parse_val(codec->control_data, &val, &val);
+		if (ret != 0)
 			goto out;
-		}
+
+		((u32 *)data)[0] |= val;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
 	}
 
-	ret = regmap_raw_write(codec->control_data, params->base,
-			       data, len);
+	ret = regmap_raw_write(codec->control_data, params->base, data, len);
 
 out:
 	kfree(data);
-- 
1.7.2.5

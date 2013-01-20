From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Ensure SND_SOC_BYTES writes are
	from DMA safe memory
Date: Sun, 20 Jan 2013 22:04:16 +0900
Message-ID: <1358687056-27323-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25DE0265137
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2013 14:04:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <Liam.R.Girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

With some buses the transfers may DMAed, especially for larger blocks.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 625e973..3e4e40e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3131,9 +3131,12 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	if (!codec->using_regmap)
 		return -EINVAL;
 
-	data = ucontrol->value.bytes.data;
 	len = params->num_regs * codec->val_bytes;
 
+	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
+	if (!data)
+		return -ENOMEM;
+
 	/*
 	 * If we've got a mask then we need to preserve the register
 	 * bits.  We shouldn't modify the incoming data so take a
@@ -3146,10 +3149,6 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 
 		val &= params->mask;
 
-		data = kmemdup(data, len, GFP_KERNEL);
-		if (!data)
-			return -ENOMEM;
-
 		switch (codec->val_bytes) {
 		case 1:
 			((u8 *)data)[0] &= ~params->mask;
@@ -3171,8 +3170,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 	ret = regmap_raw_write(codec->control_data, params->base,
 			       data, len);
 
-	if (params->mask)
-		kfree(data);
+	kfree(data);
 
 	return ret;
 }
-- 
1.7.10.4

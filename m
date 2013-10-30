From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/9] ASoC: ab8500: Fix invalid cast to long
	pointer
Date: Wed, 30 Oct 2013 08:35:01 +0100
Message-ID: <1383118507-21503-4-git-send-email-tiwai@suse.de>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A5192652E5
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 08:32:34 +0100 (CET)
In-Reply-To: <1383118507-21503-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Don't cast to long pointers blindly just for using find_first_bit()
and co.  This is certainly not portable at all.

Reimplement the code with ffs() and fls() instead.  This is a slight
optimization, too.

Spotted by coverity CID 1056484 and 1056485.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ab8500-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 0693faf7effb..272df538c1d5 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2301,17 +2301,17 @@ static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	case 0:
 		break;
 	case 1:
-		slot = find_first_bit((unsigned long *)&tx_mask, 32);
+		slot = ffs(tx_mask);
 		snd_soc_update_bits(codec, AB8500_DASLOTCONF1, mask, slot);
 		snd_soc_update_bits(codec, AB8500_DASLOTCONF3, mask, slot);
 		snd_soc_update_bits(codec, AB8500_DASLOTCONF2, mask, slot);
 		snd_soc_update_bits(codec, AB8500_DASLOTCONF4, mask, slot);
 		break;
 	case 2:
-		slot = find_first_bit((unsigned long *)&tx_mask, 32);
+		slot = ffs(tx_mask);
 		snd_soc_update_bits(codec, AB8500_DASLOTCONF1, mask, slot);
 		snd_soc_update_bits(codec, AB8500_DASLOTCONF3, mask, slot);
-		slot = find_next_bit((unsigned long *)&tx_mask, 32, slot + 1);
+		slot = fls(tx_mask);
 		snd_soc_update_bits(codec, AB8500_DASLOTCONF2, mask, slot);
 		snd_soc_update_bits(codec, AB8500_DASLOTCONF4, mask, slot);
 		break;
@@ -2342,18 +2342,18 @@ static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	case 0:
 		break;
 	case 1:
-		slot = find_first_bit((unsigned long *)&rx_mask, 32);
+		slot = ffs(rx_mask);
 		snd_soc_update_bits(codec, AB8500_ADSLOTSEL(slot),
 				AB8500_MASK_SLOT(slot),
 				AB8500_ADSLOTSELX_AD_OUT_TO_SLOT(AB8500_AD_OUT3, slot));
 		break;
 	case 2:
-		slot = find_first_bit((unsigned long *)&rx_mask, 32);
+		slot = ffs(rx_mask);
 		snd_soc_update_bits(codec,
 				AB8500_ADSLOTSEL(slot),
 				AB8500_MASK_SLOT(slot),
 				AB8500_ADSLOTSELX_AD_OUT_TO_SLOT(AB8500_AD_OUT3, slot));
-		slot = find_next_bit((unsigned long *)&rx_mask, 32, slot + 1);
+		slot = fls(rx_mask);
 		snd_soc_update_bits(codec,
 				AB8500_ADSLOTSEL(slot),
 				AB8500_MASK_SLOT(slot),
-- 
1.8.4.1

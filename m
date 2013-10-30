From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/9] ASoC: rt5640: Fix ignored error checks
Date: Wed, 30 Oct 2013 08:35:06 +0100
Message-ID: <1383118507-21503-9-git-send-email-tiwai@suse.de>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 746072652C1
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

The negative error value returned from get_sdp_info() is ignored
because it's assigned to unsigned variables.

Spotted by coverity CIDs 1042657, 1042658.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/rt5640.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 4d041d376f31..a3fb41179636 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1604,8 +1604,8 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val_len = 0, val_clk, mask_clk, dai_sel;
-	int pre_div, bclk_ms, frame_size;
+	unsigned int val_len = 0, val_clk, mask_clk;
+	int dai_sel, pre_div, bclk_ms, frame_size;
 
 	rt5640->lrck[dai->id] = params_rate(params);
 	pre_div = get_clk_info(rt5640->sysclk, rt5640->lrck[dai->id]);
@@ -1675,7 +1675,8 @@ static int rt5640_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
-	unsigned int reg_val = 0, dai_sel;
+	unsigned int reg_val = 0;
+	int dai_sel;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-- 
1.8.4.1

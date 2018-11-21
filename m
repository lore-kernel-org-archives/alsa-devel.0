From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sdm845: Update slot_width for
	Quaternary TDM port" to the asoc tree
Date: Wed, 21 Nov 2018 13:30:34 +0000 (GMT)
Message-ID: <20181121133034.128EC11250AE@debutante.sirena.org.uk>
References: <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 235AB26794B
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:30:35 +0100 (CET)
In-Reply-To: <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sdm845: Update slot_width for Quaternary TDM port

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a1849b7dd30a07654b53f3599cc8f028afeb5d9f Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 16 Nov 2018 13:11:57 +0530
Subject: [PATCH] ASoC: sdm845: Update slot_width for Quaternary TDM port

Change slot_width for quaternary TDM port to 16 and
update bclk rate for TDM and MI2S interfaces
accordingly.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 8d0cdff64377..84e6ee7d78d3 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -13,7 +13,8 @@
 
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
-#define DEFAULT_BCLK_RATE		12288000
+#define TDM_BCLK_RATE		6144000
+#define MI2S_BCLK_RATE		1536000
 
 struct sdm845_snd_data {
 	struct snd_soc_card *card;
@@ -33,7 +34,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		slot_width = 32;
+		slot_width = 16;
 		break;
 	default:
 		dev_err(rtd->dev, "%s: invalid param format 0x%x\n",
@@ -115,7 +116,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
-				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		break;
@@ -125,7 +126,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		if (++(data->quat_tdm_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
-				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		break;
 
-- 
2.19.0.rc2

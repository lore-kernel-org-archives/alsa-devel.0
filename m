From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sdm845: Set DAI format for dmic codec"
	to the asoc tree
Date: Wed, 16 Jan 2019 18:06:53 +0000 (GMT)
Message-ID: <20190116180653.563621126FFD@debutante.sirena.org.uk>
References: <20190115084159.135113-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 374242666B3
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 19:06:54 +0100 (CET)
In-Reply-To: <20190115084159.135113-1-cychiang@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: alsa-devel@alsa-project.org, tzungbi@chromium.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sdm845: Set DAI format for dmic codec

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

>From 9019ab102fe8d741f873e6f630fb7aa74c38818a Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Tue, 15 Jan 2019 16:41:59 +0800
Subject: [PATCH] ASoC: sdm845: Set DAI format for dmic codec

Set codec DAI format for dmic codec in startup.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 6f66a58e23ca..882f52ed8231 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -248,12 +248,14 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		break;
 
 	case SECONDARY_MI2S_TX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
 		if (++(data->sec_mi2s_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
 				MI2S_BCLK_RATE,	SNDRV_PCM_STREAM_CAPTURE);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
 	case QUATERNARY_TDM_RX_0:
-- 
2.20.1

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: Enable TDM support for
	DSP_A/B modes" to the asoc tree
Date: Thu,  2 May 2019 03:18:44 +0100 (BST)
Message-ID: <20190502021845.06AC6441D3C@finisterre.ee.mobilebroadband>
References: <20190417113140.15572-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 853F0F89727
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 04:18:49 +0200 (CEST)
In-Reply-To: <20190417113140.15572-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: Enable TDM support for DSP_A/B modes

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

>From 5011454ee34a84700e9a8c7eb1138efceea9d662 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 17 Apr 2019 14:31:40 +0300
Subject: [PATCH] ASoC: pcm3168a: Enable TDM support for DSP_A/B modes

The 24-bit TDM mode also applies to DSP_A and DSP_B modes.
Most dais on the SoC side can not interpret I2S/Left_j with other than 2
channels of audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 08d3fe192e65..e0d5839fe1a7 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -457,13 +457,16 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	if (chan > 2) {
 		switch (fmt) {
 		case PCM3168A_FMT_I2S:
+		case PCM3168A_FMT_DSP_A:
 			fmt = PCM3168A_FMT_I2S_TDM;
 			break;
 		case PCM3168A_FMT_LEFT_J:
+		case PCM3168A_FMT_DSP_B:
 			fmt = PCM3168A_FMT_LEFT_J_TDM;
 			break;
 		default:
-			dev_err(component->dev, "TDM is supported under I2S/Left_J only\n");
+			dev_err(component->dev,
+				"TDM is supported under DSP/I2S/Left_J only\n");
 			return -EINVAL;
 		}
 	}
@@ -526,6 +529,8 @@ static int pcm3168a_startup(struct snd_pcm_substream *substream,
 		break;
 	case PCM3168A_FMT_LEFT_J:
 	case PCM3168A_FMT_I2S:
+	case PCM3168A_FMT_DSP_A:
+	case PCM3168A_FMT_DSP_B:
 		sample_min  = 24;
 		channel_max = channel_maxs[tx];
 		break;
-- 
2.20.1

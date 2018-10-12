From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: add I2S/Left_J TDM support"
	to the asoc tree
Date: Fri, 12 Oct 2018 19:00:22 +0200 (CEST)
Message-ID: <20181012170022.A0DA9440078@finisterre.ee.mobilebroadband>
References: <87murjbs45.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BE303267845
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 19:00:25 +0200 (CEST)
In-Reply-To: <87murjbs45.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: add I2S/Left_J TDM support

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

>From 471a7ba89158c6d52dae69636c94c4aa1a6b7b22 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Oct 2018 06:31:49 +0000
Subject: [PATCH] ASoC: pcm3168a: add I2S/Left_J TDM support

pcm3168a is supporting TDM on I2S/Left_J, but there is no
settings for it. This patch add it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index f0e2b886323e..63aa02592bc0 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -33,6 +33,8 @@
 #define PCM3168A_FMT_RIGHT_J_16		0x3
 #define PCM3168A_FMT_DSP_A		0x4
 #define PCM3168A_FMT_DSP_B		0x5
+#define PCM3168A_FMT_I2S_TDM		0x6
+#define PCM3168A_FMT_LEFT_J_TDM		0x7
 #define PCM3168A_FMT_DSP_MASK		0x4
 
 #define PCM3168A_NUM_SUPPLIES 6
@@ -401,9 +403,11 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	bool tx, master_mode;
 	u32 val, mask, shift, reg;
 	unsigned int rate, fmt, ratio, max_ratio;
+	unsigned int chan;
 	int i, min_frame_size;
 
 	rate = params_rate(params);
+	chan = params_channels(params);
 
 	ratio = pcm3168a->sysclk / rate;
 
@@ -456,6 +460,21 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* for TDM */
+	if (chan > 2) {
+		switch (fmt) {
+		case PCM3168A_FMT_I2S:
+			fmt = PCM3168A_FMT_I2S_TDM;
+			break;
+		case PCM3168A_FMT_LEFT_J:
+			fmt = PCM3168A_FMT_LEFT_J_TDM;
+			break;
+		default:
+			dev_err(component->dev, "TDM is supported under I2S/Left_J only\n");
+			return -EINVAL;
+		}
+	}
+
 	if (master_mode)
 		val = ((i + 1) << shift);
 	else
-- 
2.19.0

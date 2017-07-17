From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ux500: Restore platform DAI assignments" to the asoc tree
Date: Mon, 17 Jul 2017 17:05:36 +0100
Message-ID: <E1dX8We-0004ql-91@debutante>
References: <20170712155530.17765-2-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170712155530.17765-2-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, stable <stable@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.orgstable <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ux500: Restore platform DAI assignments

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 651e9268fb9b9944e063d731b09c0d2ad339bedb Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 12 Jul 2017 17:55:30 +0200
Subject: [PATCH] ASoC: ux500: Restore platform DAI assignments

This reverts commit f1013cdeeeb9 ("ASoC: ux500: drop platform DAI
assignments"), which seems to have been based on a misunderstanding and
prevents the platform driver callbacks from being made (e.g. to
preallocate DMA memory).

The real culprit for the warnings about attempts to create duplicate
procfs entries was commit 99b04f4c4051 ("ASoC: add Component level
pcm_new/pcm_free" that broke PCM creation on systems that use more than
one platform component.

Fixes: f1013cdeeeb9 ("ASoC: ux500: drop platform DAI assignments")
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org>	# 4.11
---
 sound/soc/ux500/mop500.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index b50f68a439ce..ba9fc099cf67 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -33,6 +33,7 @@ static struct snd_soc_dai_link mop500_dai_links[] = {
 		.stream_name = "ab8500_0",
 		.cpu_dai_name = "ux500-msp-i2s.1",
 		.codec_dai_name = "ab8500-codec-dai.0",
+		.platform_name = "ux500-msp-i2s.1",
 		.codec_name = "ab8500-codec.0",
 		.init = mop500_ab8500_machine_init,
 		.ops = mop500_ab8500_ops,
@@ -42,6 +43,7 @@ static struct snd_soc_dai_link mop500_dai_links[] = {
 		.stream_name = "ab8500_1",
 		.cpu_dai_name = "ux500-msp-i2s.3",
 		.codec_dai_name = "ab8500-codec-dai.1",
+		.platform_name = "ux500-msp-i2s.3",
 		.codec_name = "ab8500-codec.0",
 		.init = NULL,
 		.ops = mop500_ab8500_ops,
@@ -85,6 +87,8 @@ static int mop500_of_probe(struct platform_device *pdev,
 	for (i = 0; i < 2; i++) {
 		mop500_dai_links[i].cpu_of_node = msp_np[i];
 		mop500_dai_links[i].cpu_dai_name = NULL;
+		mop500_dai_links[i].platform_of_node = msp_np[i];
+		mop500_dai_links[i].platform_name = NULL;
 		mop500_dai_links[i].codec_of_node = codec_np;
 		mop500_dai_links[i].codec_name = NULL;
 	}
-- 
2.13.2

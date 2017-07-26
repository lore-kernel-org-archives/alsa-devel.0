From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: hac: add missing "int ret"" to the asoc tree
Date: Wed, 26 Jul 2017 15:17:42 +0100
Message-ID: <E1daN8A-0003kl-SR@debutante>
References: <87379mxro6.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87379mxro6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh: hac: add missing "int ret"

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

>From 295c5ba4c0886b7d55e229218b077fe3510b0ccd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Jul 2017 06:47:59 +0000
Subject: [PATCH] ASoC: sh: hac: add missing "int ret"

commit b047e1cce8 ("ASoC: ac97: Support multi-platform AC'97")
modified hac_soc_platform_probe(), but "int ret" was missed.
This patch adds missing "int ret", otherwise, we will get

linux/sound/soc/sh/hac.c: In function 'hac_soc_platform_probe':
linux/sound/soc/sh/hac.c:318: error: 'ret' undeclared (first use in this function)
linux/sound/soc/sh/hac.c:318: error: (Each undeclared identifier is reported only once
linux/sound/soc/sh/hac.c:318: error: for each function it appears in.)

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/hac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index 84c51037a7d0..624aaf569fef 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -315,6 +315,8 @@ static const struct snd_soc_component_driver sh4_hac_component = {
 
 static int hac_soc_platform_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	ret = snd_soc_set_ac97_ops(&hac_ac97_ops);
 	if (ret != 0)
 		return ret;
-- 
2.13.2

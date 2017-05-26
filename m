From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: remove strict limitation of bit/frame master" to the asoc tree
Date: Fri, 26 May 2017 12:41:51 +0100
Message-ID: <E1dEDct-0000iw-44@debutante>
References: <8737bt1zes.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8737bt1zes.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: remove strict limitation of bit/frame master

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

>From 155b8f3aa633dbce887cded6b6b9399a3c62683e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 May 2017 01:51:31 +0000
Subject: [PATCH] ASoC: simple-card-utils: remove strict limitation of
 bit/frame master

Current asoc_simple_card_parse_daifmt is keeping backward compatibility
for bitmaster/framemaster which didn't use phandle.
The keep compatibility, it is checking prefix length, but it is
too strict. let's loosen it. Otherwise, OF-graph base sound card
which doesn't have prefix can't detect daifmt.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index fe726e83d0bd..9c7f5b91b90a 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -21,14 +21,13 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 {
 	struct device_node *bitclkmaster = NULL;
 	struct device_node *framemaster = NULL;
-	int prefix_len = prefix ? strlen(prefix) : 0;
 	unsigned int daifmt;
 
 	daifmt = snd_soc_of_parse_daifmt(node, prefix,
 					 &bitclkmaster, &framemaster);
 	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
 
-	if (prefix_len && !bitclkmaster && !framemaster) {
+	if (!bitclkmaster && !framemaster) {
 		/*
 		 * No dai-link level and master setting was not found from
 		 * sound node level, revert back to legacy DT parsing and
-- 
2.11.0

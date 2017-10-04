From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsi: Use of_device_get_match_data() helper" to the asoc tree
Date: Wed, 04 Oct 2017 15:51:30 +0100
Message-ID: <E1dzl1G-0008Qy-DO@debutante>
References: <1507120110-13336-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1507120110-13336-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsi: Use of_device_get_match_data() helper

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

>From b48cc1d9c3a93b239700198f69b1a49b23d95b83 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 4 Oct 2017 14:28:30 +0200
Subject: [PATCH] ASoC: fsi: Use of_device_get_match_data() helper

Use the of_device_get_match_data() helper instead of open coding.
Note that when used with DT, there's always a valid match.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 6d3c7706d93f..c3aaf4788557 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1932,14 +1932,9 @@ static int fsi_probe(struct platform_device *pdev)
 
 	core = NULL;
 	if (np) {
-		const struct of_device_id *of_id;
-
-		of_id = of_match_device(fsi_of_match, &pdev->dev);
-		if (of_id) {
-			core = of_id->data;
-			fsi_of_parse("fsia", np, &info.port_a, &pdev->dev);
-			fsi_of_parse("fsib", np, &info.port_b, &pdev->dev);
-		}
+		core = of_device_get_match_data(&pdev->dev);
+		fsi_of_parse("fsia", np, &info.port_a, &pdev->dev);
+		fsi_of_parse("fsib", np, &info.port_b, &pdev->dev);
 	} else {
 		const struct platform_device_id	*id_entry = pdev->id_entry;
 		if (id_entry)
-- 
2.14.1

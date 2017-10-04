From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ASoC: fsi: Use of_device_get_match_data() helper
Date: Wed,  4 Oct 2017 14:28:30 +0200
Message-ID: <1507120110-13336-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

Use the of_device_get_match_data() helper instead of open coding.
Note that when used with DT, there's always a valid match.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/sh/fsi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 6d3c7706d93fbc10..c3aaf4788557c4e1 100644
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
2.7.4

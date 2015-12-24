From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH v2] ASoC: rsnd: fix usrcnt decrementing bug
Date: Thu, 24 Dec 2015 08:02:39 +0100
Message-ID: <1450940559-16516-1-git-send-email-a.hajda@samsung.com>
References: <87k2o4fkad.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <87k2o4fkad.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
	AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Field usrcnt is unsigned so it cannot be lesser than zero.
The patch fixes the check, moves it to the beginning of the function
and changes return value to -EIO in case of usercnt error.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
v2: changed according to Kuninori Morimoto advice
---
 sound/soc/sh/rcar/ssi.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 0b91692..f23c921 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -364,29 +364,30 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
-	if (rsnd_ssi_is_parent(mod, io))
-		goto rsnd_ssi_quit_end;
+	if (!ssi->usrcnt) {
+		dev_err(dev, "%s[%d] usrcnt error\n",
+			rsnd_mod_name(mod), rsnd_mod_id(mod));
+		return -EIO;
+	}
 
-	if (ssi->err > 0)
-		dev_warn(dev, "%s[%d] under/over flow err = %d\n",
-			 rsnd_mod_name(mod), rsnd_mod_id(mod), ssi->err);
+	if (!rsnd_ssi_is_parent(mod, io)) {
+		if (ssi->err > 0)
+			dev_warn(dev, "%s[%d] under/over flow err = %d\n",
+				 rsnd_mod_name(mod), rsnd_mod_id(mod),
+				 ssi->err);
 
-	ssi->cr_own	= 0;
-	ssi->err	= 0;
+		ssi->cr_own	= 0;
+		ssi->err	= 0;
 
-	rsnd_ssi_irq_disable(mod);
+		rsnd_ssi_irq_disable(mod);
+	}
 
-rsnd_ssi_quit_end:
 	rsnd_ssi_master_clk_stop(ssi, io);
 
 	rsnd_mod_power_off(mod);
 
 	ssi->usrcnt--;
 
-	if (ssi->usrcnt < 0)
-		dev_err(dev, "%s[%d] usrcnt error\n",
-			rsnd_mod_name(mod), rsnd_mod_id(mod));
-
 	return 0;
 }
 
-- 
1.9.1

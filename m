From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/1] ASoC: rsnd: allow to register kctrl with different cfg
Date: Fri, 1 Feb 2019 12:02:25 +0900
Message-ID: <20190201030225.11391-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: jiada_wang@mentor.com, twischer@de.adit-jv.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently kctrl with same name can only be created once,
but in "MIX Playback Volume" case, same kctrl is used to
control different MIX volume for different dai-link.

this patch by check kctrl's cfg, allow to create kctrl
with same name but different cfg.

Fixes: commit 9c698e8481a1 ("ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()")

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 79659f7b32b9..909ee0948da1 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1526,14 +1526,15 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	int ret;
 
 	/*
-	 * 1) Avoid duplicate register (ex. MIXer case)
+	 * 1) Avoid duplicate register (ex. DVC case)
 	 * 2) re-register if card was rebinded
 	 */
 	list_for_each_entry(kctrl, &card->controls, list) {
 		struct rsnd_kctrl_cfg *c = kctrl->private_data;
 
 		if (strcmp(kctrl->id.name, name) == 0 &&
-		    c->mod == mod)
+		    c->mod == mod &&
+		    &c->val == &cfg->val)
 			return 0;
 	}
 
-- 
2.19.2

From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 1/1] ASoC: rsnd: ssiu: clear SSI_MODE for non TDM Extended modes
Date: Tue, 28 Nov 2017 16:05:13 +0900
Message-ID: <20171128070513.32709-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

register SSI_MODE is set when SSI works in TDM Extended,
but it isn't reset when SSI starts to work in other modes,
thus causes issues.

This patch clearss SSI_MODE register when SSI works in modes
other than TDM Extended.

Fixes: 186fadc132f0 ("ASoC: rsnd: add TDM Extend Mode support")

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssiu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 4d94875..6ff8a36 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -125,6 +125,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 {
 	int hdmi = rsnd_ssi_hdmi_port(io);
 	int ret;
+	u32 mode = 0;
 
 	ret = rsnd_ssiu_init(mod, io, priv);
 	if (ret < 0)
@@ -136,9 +137,11 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 		 * see
 		 *	rsnd_ssi_config_init()
 		 */
-		rsnd_mod_write(mod, SSI_MODE, 0x1);
+		mode = 0x1;
 	}
 
+	rsnd_mod_write(mod, SSI_MODE, mode);
+
 	if (rsnd_ssi_use_busif(io)) {
 		rsnd_mod_write(mod, SSI_BUSIF_ADINR,
 			       rsnd_get_adinr_bit(mod, io) |
-- 
2.9.3

From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: rsnd: precedence error in rsnd_ssiu_init()
Date: Wed, 6 Jan 2016 12:38:41 +0300
Message-ID: <20160106092855.GA23185@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The bitwise OR has higher precedence than ?: so the val2 was always set
to 0x2.

Fixes: b4c83b171557 ('ASoC: rsnd: add Multi channel support')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 3fe9e08..06d7282 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -73,7 +73,7 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 		switch (multi_ssi_slaves) {
 		case 0x0206: /* SSI0/1/2/9 */
 			val2 = (1 << 4) | /* SSI0129 sync */
-				rsnd_rdai_is_clk_master(rdai) ? 0x2 : 0x1;
+				(rsnd_rdai_is_clk_master(rdai) ? 0x2 : 0x1);
 			/* fall through */
 		case 0x0006: /* SSI0/1/2 */
 			val1 = rsnd_rdai_is_clk_master(rdai) ?

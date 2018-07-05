From: <jiada_wang@mentor.com>
Subject: [PATCH 1/1] ASoC: rsnd: cmd: Add missing newline to debug message
Date: Thu, 5 Jul 2018 11:20:04 +0900
Message-ID: <20180705022004.24524-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, jiada_wang@mentor.com, keescook@chromium.org, andrew_gabbasov@mentor.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Andrew Gabbasov <andrew_gabbasov@mentor.com>

To comply with the style of all kernel messages, add newline
to the end of every message.

Fixes: 70fb10529f61 ("ASoC: rsnd: add MIX (Mixer) support")
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index d8043ad33540..cc191cd5fb82 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -86,7 +86,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 			cmd_case[rsnd_mod_id(src)] << 16;
 	}
 
-	dev_dbg(dev, "ctu/mix path = 0x%08x", data);
+	dev_dbg(dev, "ctu/mix path = 0x%08x\n", data);
 
 	rsnd_mod_write(mod, CMD_ROUTE_SLCT, data);
 	rsnd_mod_write(mod, CMD_BUSIF_MODE, rsnd_get_busif_shift(io, mod) | 1);
-- 
2.17.0

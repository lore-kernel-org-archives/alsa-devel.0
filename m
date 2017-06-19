From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: rsnd: make main_rate signed to check for -ve error return codes
Date: Mon, 19 Jun 2017 17:35:23 +0100
Message-ID: <20170619163523.2208-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The comparison of main_rate < 0 has no effect because main_rate is
an unsigned int. Make it signed so that any -ve error returns from the
call to rsnd_clk_query can be detected.

Detected by CoverityScan, CID#1446152 ("Unsigned compared against 0")

Fixes: ef4cf5d6a143e0 ("ASoC: rsnd: add rsnd_ssi_clk_query()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index c8956c3484dd..d220512918f9 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -258,7 +258,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	struct rsnd_mod *ssi_parent_mod = rsnd_io_to_mod_ssip(io);
 	int chan = rsnd_runtime_channel_for_ssi(io);
 	int idx, ret;
-	unsigned int main_rate;
+	int main_rate;
 	unsigned int rate = rsnd_io_is_play(io) ?
 		rsnd_src_get_out_rate(priv, io) :
 		rsnd_src_get_in_rate(priv, io);
-- 
2.11.0

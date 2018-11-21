From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: rsnd: makes rsnd_ssi_is_dma_mode() static
Date: Wed, 21 Nov 2018 08:15:30 +0000
Message-ID: <87k1l6q2h3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400124.outbound.protection.outlook.com [40.107.140.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 55A802678F2
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 09:15:34 +0100 (CET)
Content-Language: en-US
Content-ID: <B15D0C1087DC9F49A04EC612484D4424@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ssi.c only is using rsnd_ssi_is_dma_mode().
Let's move it as static function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/rsnd.h | 1 -
 sound/soc/sh/rcar/ssi.c  | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 64c3a3b..3c57129 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -726,7 +726,6 @@ extern const char * const volume_ramp_rate[];
 int rsnd_ssi_probe(struct rsnd_priv *priv);
 void rsnd_ssi_remove(struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id);
-int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io);
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io);
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 361dc2c..6439a74 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -117,6 +117,8 @@ struct rsnd_ssi {
 	(rsnd_ssi_run_mods(io) & (1 << rsnd_mod_id(mod)))
 #define rsnd_ssi_can_output_clk(mod) (!__rsnd_ssi_is_pin_sharing(mod))
 
+static int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
+
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 {
 	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
@@ -1003,12 +1005,11 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
 	.get_status	= rsnd_ssi_get_status,
 };
 
-int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod)
+static int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod)
 {
 	return mod->ops == &rsnd_ssi_dma_ops;
 }
 
-
 /*
  *		ssi mod function
  */
-- 
2.7.4

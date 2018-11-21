From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: rsnd: tidyup
	rsnd_parse_connect_ssiu_compatible()
Date: Wed, 21 Nov 2018 01:58:30 +0000
Message-ID: <87zhu3p5d4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410122.outbound.protection.outlook.com [40.107.141.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 6429D2678F7
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 02:58:36 +0100 (CET)
Content-Language: en-US
Content-ID: <88EB3C1440A8DF4CA0732802CD693F4D@jpnprd01.prod.outlook.com>
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

rsnd_parse_connect_ssiu_compatible() is doing
 - using rsnd_ssiu_id(), but we use it via rsnd_mod_id()
 - we can break loop if rsnd_dai_connect() was called
This patch fixup these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/ssiu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 650b14e..04b1a48 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -382,9 +382,11 @@ static void rsnd_parse_connect_ssiu_compatible(struct rsnd_priv *priv,
 	for_each_rsnd_ssiu(ssiu, priv, i) {
 		mod = rsnd_mod_get(ssiu);
 
-		if ((rsnd_mod_id(ssi_mod) == rsnd_ssiu_id(mod)) &&
-		    (rsnd_mod_id_sub(mod) == 0))
+		if ((rsnd_mod_id(ssi_mod) == rsnd_mod_id(mod)) &&
+		    (rsnd_mod_id_sub(mod) == 0)) {
 			rsnd_dai_connect(mod, io, mod->type);
+			return;
+		}
 	}
 }
 
-- 
2.7.4

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup
	rsnd_parse_connect_ssiu_compatible()" to the asoc tree
Date: Wed, 21 Nov 2018 13:30:03 +0000 (GMT)
Message-ID: <20181121133003.2819F11250AE@debutante.sirena.org.uk>
References: <87zhu3p5d4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D90D6267A8C
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:30:03 +0100 (CET)
In-Reply-To: <87zhu3p5d4.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup rsnd_parse_connect_ssiu_compatible()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 331e875432ecfb651d9335a18149160c307429ab Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Nov 2018 01:58:30 +0000
Subject: [PATCH] ASoC: rsnd: tidyup rsnd_parse_connect_ssiu_compatible()

rsnd_parse_connect_ssiu_compatible() is doing
 - using rsnd_ssiu_id(), but we use it via rsnd_mod_id()
 - we can break loop if rsnd_dai_connect() was called
This patch fixup these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 650b14e99b05..04b1a4836bd3 100644
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
2.19.0.rc2

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup rsnd_ssiu_init_gen2()" to
	the asoc tree
Date: Sat, 05 Mar 2016 21:24:52 +0900
Message-ID: <E1acBGO-0003H4-3X@finisterre>
References: <8737sh733t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98537260881
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:55 +0100 (CET)
In-Reply-To: <8737sh733t.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup rsnd_ssiu_init_gen2()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 135bb7d5c7b3fa40cd0559b5500a50d4e3663f6e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Feb 2016 05:52:13 +0000
Subject: [PATCH] ASoC: rsnd: tidyup rsnd_ssiu_init_gen2()

remove unnecessary variable

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 1b8ea0e09bc2..0d964a0a3e31 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -115,13 +115,12 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	}
 
 	if (rsnd_ssi_use_busif(io)) {
-		u32 val = rsnd_get_dalign(mod, io);
-
 		rsnd_mod_write(mod, SSI_BUSIF_ADINR,
 			       rsnd_get_adinr_bit(mod, io) |
 			       rsnd_get_adinr_chan(mod, io));
 		rsnd_mod_write(mod, SSI_BUSIF_MODE,  1);
-		rsnd_mod_write(mod, SSI_BUSIF_DALIGN, val);
+		rsnd_mod_write(mod, SSI_BUSIF_DALIGN,
+			       rsnd_get_dalign(mod, io));
 	}
 
 	return 0;
-- 
2.7.0

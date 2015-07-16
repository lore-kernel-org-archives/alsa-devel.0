From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: dvc: make sure DVC soft reset" to
	the asoc tree
Date: Thu, 16 Jul 2015 22:30:09 +0100
Message-ID: <E1ZFqjJ-0004n0-P9@finisterre>
References: <87twt5vqwh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DE8126673B
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:30:15 +0200 (CEST)
In-Reply-To: <87twt5vqwh.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: dvc: make sure DVC soft reset

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

>From 636e4bad5cca947839c09d3e13ad6feeb7fa45da Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:12:00 +0000
Subject: [PATCH] ASoC: rsnd: dvc: make sure DVC soft reset

Renesas SCU (Sampling Rate Convert Unit) includes SRC/CTU/MIX/DVC,
and these have similar register. xxxRSR (Software reset Register) is one
of them. These xxxRSR need be set to 1 to 0 when software reset.
Current rsnd driver has src.c / dvc.c, and we will have mix.c.
It is readable if these have same named function.
This patch adds rsnd_dvc_soft_reset() and make sure it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 8a61aa3..24d0763 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -64,6 +64,12 @@ static const char * const dvc_ramp_rate[] = {
 	"0.125 dB/8192 steps",	 /* 10111 */
 };
 
+static void rsnd_dvc_soft_reset(struct rsnd_mod *mod)
+{
+	rsnd_mod_write(mod, DVC_SWRSR, 0);
+	rsnd_mod_write(mod, DVC_SWRSR, 1);
+}
+
 static void rsnd_dvc_volume_update(struct rsnd_dai_stream *io,
 				   struct rsnd_mod *mod)
 {
@@ -160,15 +166,14 @@ static int rsnd_dvc_init(struct rsnd_mod *dvc_mod,
 
 	rsnd_mod_hw_start(dvc_mod);
 
+	rsnd_dvc_soft_reset(dvc_mod);
+
 	/*
 	 * fixme
 	 * it doesn't support CTU/MIX
 	 */
 	rsnd_mod_write(dvc_mod, CMD_ROUTE_SLCT, route[src_id]);
 
-	rsnd_mod_write(dvc_mod, DVC_SWRSR, 0);
-	rsnd_mod_write(dvc_mod, DVC_SWRSR, 1);
-
 	rsnd_mod_write(dvc_mod, DVC_DVUIR, 1);
 
 	rsnd_mod_write(dvc_mod, DVC_ADINR, rsnd_get_adinr(dvc_mod, io));
-- 
2.1.4

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: dvc: rename rsnd_dvc_soft_reset()
	to rsnd_dvc_activation()" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:58 +0000
Message-ID: <E1a3ttu-00071U-UO@debutante>
References: <874mg3ub2r.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99A582661BF
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 00:00:03 +0100 (CET)
In-Reply-To: <874mg3ub2r.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: dvc: rename rsnd_dvc_soft_reset() to rsnd_dvc_activation()

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

>From 87a6c5a815f5da390ea74187344342df03205358 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:51:15 +0000
Subject: [PATCH] ASoC: rsnd: dvc: rename rsnd_dvc_soft_reset() to
 rsnd_dvc_activation()

Based on datasheet naming

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index c622dec24362..b69a6e5cafef 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -64,7 +64,7 @@ static const char * const dvc_ramp_rate[] = {
 	"0.125 dB/8192 steps",	 /* 10111 */
 };
 
-static void rsnd_dvc_soft_reset(struct rsnd_mod *mod)
+static void rsnd_dvc_activation(struct rsnd_mod *mod)
 {
 	rsnd_mod_write(mod, DVC_SWRSR, 0);
 	rsnd_mod_write(mod, DVC_SWRSR, 1);
@@ -206,7 +206,7 @@ static int rsnd_dvc_init(struct rsnd_mod *mod,
 {
 	rsnd_mod_power_on(mod);
 
-	rsnd_dvc_soft_reset(mod);
+	rsnd_dvc_activation(mod);
 
 	rsnd_dvc_volume_init(io, mod);
 
-- 
2.6.2

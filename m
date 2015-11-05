From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup comment position of
	rsnd_mod_xxx" to the asoc tree
Date: Thu, 05 Nov 2015 14:15:43 +0000
Message-ID: <E1ZuLKJ-0007nx-Rc@finisterre>
References: <878u6cq1h6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C73D42660C7
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 15:15:55 +0100 (CET)
In-Reply-To: <878u6cq1h6.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup comment position of rsnd_mod_xxx

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

>From f038f7f64963157a400077bf5c6568428403980a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 5 Nov 2015 08:50:10 +0000
Subject: [PATCH] ASoC: rsnd: tidyup comment position of rsnd_mod_xxx

f1df12290("ASoC: rsnd: add common mod confirm method")
added rsnd_mod_make_sure(), but rsnd_mod_xxx() comment position
was wrong. This patch tidyup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 5586b88..1363966 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -127,6 +127,9 @@ MODULE_DEVICE_TABLE(of, rsnd_of_match);
 #define rsnd_info_id(priv, io, name) \
 	((io)->info->name - priv->info->name##_info)
 
+/*
+ *	rsnd_mod functions
+ */
 void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type)
 {
 	if (mod->type != type) {
@@ -138,9 +141,6 @@ void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type)
 	}
 }
 
-/*
- *	rsnd_mod functions
- */
 char *rsnd_mod_name(struct rsnd_mod *mod)
 {
 	if (!mod || !mod->ops)
-- 
2.6.1

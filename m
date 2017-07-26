From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't use private_value on
	rsnd_kctrl_new()" to the asoc tree
Date: Wed, 26 Jul 2017 15:17:39 +0100
Message-ID: <E1daN87-0003ja-SR@debutante>
References: <8760eiy5nj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BE55267467
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:17:46 +0200 (CEST)
In-Reply-To: <8760eiy5nj.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't use private_value on rsnd_kctrl_new()

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

>From 16d4498962c7b76a76553e8dd943abe1e9facc0d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Jul 2017 01:45:59 +0000
Subject: [PATCH] ASoC: rsnd: don't use private_value on rsnd_kctrl_new()

Current rsnd kctrl is using both .private_value (for rsnd_kctrl_cfg)
and .private_data (for rsnd_mod) on snd_kcontrol.
But only 1 private data (= rsnd_kctrl_cfg) can be enough if it has
rsnd_mod pointer.
This patch doesn't use private_value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 14 ++++++--------
 sound/soc/sh/rcar/rsnd.h |  1 +
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 3f2ced26ed37..acafb838b7b7 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1169,11 +1169,10 @@ static struct snd_pcm_ops rsnd_pcm_ops = {
 /*
  *		snd_kcontrol
  */
-#define kcontrol_to_cfg(kctrl) ((struct rsnd_kctrl_cfg *)kctrl->private_value)
 static int rsnd_kctrl_info(struct snd_kcontrol *kctrl,
 			   struct snd_ctl_elem_info *uinfo)
 {
-	struct rsnd_kctrl_cfg *cfg = kcontrol_to_cfg(kctrl);
+	struct rsnd_kctrl_cfg *cfg = snd_kcontrol_chip(kctrl);
 
 	if (cfg->texts) {
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -1199,7 +1198,7 @@ static int rsnd_kctrl_info(struct snd_kcontrol *kctrl,
 static int rsnd_kctrl_get(struct snd_kcontrol *kctrl,
 			  struct snd_ctl_elem_value *uc)
 {
-	struct rsnd_kctrl_cfg *cfg = kcontrol_to_cfg(kctrl);
+	struct rsnd_kctrl_cfg *cfg = snd_kcontrol_chip(kctrl);
 	int i;
 
 	for (i = 0; i < cfg->size; i++)
@@ -1214,8 +1213,7 @@ static int rsnd_kctrl_get(struct snd_kcontrol *kctrl,
 static int rsnd_kctrl_put(struct snd_kcontrol *kctrl,
 			  struct snd_ctl_elem_value *uc)
 {
-	struct rsnd_mod *mod = snd_kcontrol_chip(kctrl);
-	struct rsnd_kctrl_cfg *cfg = kcontrol_to_cfg(kctrl);
+	struct rsnd_kctrl_cfg *cfg = snd_kcontrol_chip(kctrl);
 	int i, change = 0;
 
 	if (!cfg->accept(cfg->io))
@@ -1232,7 +1230,7 @@ static int rsnd_kctrl_put(struct snd_kcontrol *kctrl,
 	}
 
 	if (change && cfg->update)
-		cfg->update(cfg->io, mod);
+		cfg->update(cfg->io, cfg->mod);
 
 	return change;
 }
@@ -1284,14 +1282,13 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 		.index		= rtd->num,
 		.get		= rsnd_kctrl_get,
 		.put		= rsnd_kctrl_put,
-		.private_value	= (unsigned long)cfg,
 	};
 	int ret;
 
 	if (size > RSND_MAX_CHANNELS)
 		return -EINVAL;
 
-	kctrl = snd_ctl_new1(&knew, mod);
+	kctrl = snd_ctl_new1(&knew, cfg);
 	if (!kctrl)
 		return -ENOMEM;
 
@@ -1307,6 +1304,7 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	cfg->card	= card;
 	cfg->kctrl	= kctrl;
 	cfg->io		= io;
+	cfg->mod	= mod;
 
 	return 0;
 }
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 99c57611df88..c5de71f2dc8c 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -614,6 +614,7 @@ struct rsnd_kctrl_cfg {
 	struct rsnd_dai_stream *io;
 	struct snd_card *card;
 	struct snd_kcontrol *kctrl;
+	struct rsnd_mod *mod;
 };
 
 #define RSND_MAX_CHANNELS	8
-- 
2.13.2

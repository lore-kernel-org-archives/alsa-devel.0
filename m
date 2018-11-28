From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup registering method for
	rsnd_kctrl_new()" to the asoc tree
Date: Wed, 28 Nov 2018 16:05:28 +0000 (GMT)
Message-ID: <20181128160528.35923112521B@debutante.sirena.org.uk>
References: <87lg5f0yni.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 05263267B78
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 17:05:29 +0100 (CET)
In-Reply-To: <87lg5f0yni.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Mark Brown <broonie@kernel.org>, DUNG NGUYEN <dung.nguyen.aj@renesas.com>, HIROYUKI YOKOYAMA <hiroyuki.yokoyama.vx@renesas.com>, alsa-devel@alsa-project.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()

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

>From 9c698e8481a15237a5b1db5f8391dd66d59e42a4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 27 Nov 2018 07:35:34 +0000
Subject: [PATCH] ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()

Current rsnd dvc.c is using flags to avoid duplicating register for
MIXer case. OTOH, commit e894efef9ac7 ("ASoC: core: add support to card
rebind") allows to rebind sound card without rebinding all drivers.

Because of above patch and dvc.c flags, it can't re-register kctrl if
only sound card was rebinded, because dvc is keeping old flags.
(Of course it will be no problem if rsnd driver also be rebinded,
but it is not purpose of above patch).

This patch checks current card registered kctrl when registering.
In MIXer case, it can avoid duplicate register if card already has same
kctrl. In rebind case, it can re-register kctrl because card registered
kctl had been removed when unbinding.

This patch is updated version of commit b918f1bc7f1ce ("ASoC: rsnd: DVC
kctrl sets once")

Reported-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 12 ++++++++++++
 sound/soc/sh/rcar/dvc.c  |  8 --------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f930f51b686f..114f8f233764 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1339,6 +1339,18 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	};
 	int ret;
 
+	/*
+	 * 1) Avoid duplicate register (ex. MIXer case)
+	 * 2) re-register if card was rebinded
+	 */
+	list_for_each_entry(kctrl, &card->controls, list) {
+		struct rsnd_kctrl_cfg *c = kctrl->private_data;
+
+		if (strcmp(kctrl->id.name, name) == 0 &&
+		    c->mod == mod)
+			return 0;
+	}
+
 	if (size > RSND_MAX_CHANNELS)
 		return -EINVAL;
 
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 2b16e0ce6bc5..024ece46bf68 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -40,11 +40,8 @@ struct rsnd_dvc {
 	struct rsnd_kctrl_cfg_s ren;	/* Ramp Enable */
 	struct rsnd_kctrl_cfg_s rup;	/* Ramp Rate Up */
 	struct rsnd_kctrl_cfg_s rdown;	/* Ramp Rate Down */
-	u32 flags;
 };
 
-#define KCTRL_INITIALIZED	(1 << 0)
-
 #define rsnd_dvc_get(priv, id) ((struct rsnd_dvc *)(priv->dvc) + id)
 #define rsnd_dvc_nr(priv) ((priv)->dvc_nr)
 
@@ -227,9 +224,6 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	int channels = rsnd_rdai_channels_get(rdai);
 	int ret;
 
-	if (rsnd_flags_has(dvc, KCTRL_INITIALIZED))
-		return 0;
-
 	/* Volume */
 	ret = rsnd_kctrl_new_m(mod, io, rtd,
 			is_play ?
@@ -285,8 +279,6 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	rsnd_flags_set(dvc, KCTRL_INITIALIZED);
-
 	return 0;
 }
 
-- 
2.19.0.rc2

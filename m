From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: rsnd: tidyup registering method for
	rsnd_kctrl_new()
Date: Tue, 27 Nov 2018 07:35:34 +0000
Message-ID: <87lg5f0yni.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400138.outbound.protection.outlook.com [40.107.140.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FA2F267A8C
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 08:35:43 +0100 (CET)
Content-Language: en-US
Content-ID: <11F876D16465714BB1B50629E8C2381E@jpnprd01.prod.outlook.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, DUNG NGUYEN <dung.nguyen.aj@renesas.com>, HIROYUKI YOKOYAMA <hiroyuki.yokoyama.vx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: alsa-devel@alsa-project.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

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
---
> Mark

This patch is for v4.20-rcX

 sound/soc/sh/rcar/core.c | 12 ++++++++++++
 sound/soc/sh/rcar/dvc.c  |  8 --------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 56469ac..031cd5b 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1476,6 +1476,18 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
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
index d65f24b..27c3761 100644
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
2.7.4

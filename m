From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: DVC kctrl sets once" to the asoc tree
Date: Wed, 04 Oct 2017 12:28:23 +0100
Message-ID: <E1dzhqh-0004Jz-Sl@debutante>
References: <87y3oumo79.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87y3oumo79.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: DVC kctrl sets once

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

>From b918f1bc7f1ce463d6fbb6ebf3db36bd302bded8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Sun, 1 Oct 2017 23:48:29 +0000
Subject: [PATCH] ASoC: rsnd: DVC kctrl sets once

Same DVC might be used few times if system/platform is using MIX.
For example below case.

	DAI0 playback = <&src0 &ctu02 &mix0 &dvc0 &ssi0>;
	DAI1 playback = <&src2 &ctu03 &mix0 &dvc0 &ssi0>;

This case, ALSA will have DVC,0 and DVC,1 kcontrol interfaces,
but these are same DVC. This is confusing.
This patch adds new flags and avoid such case.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 1743ade3cc55..bb22850e8fe6 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -44,8 +44,11 @@ struct rsnd_dvc {
 	struct rsnd_kctrl_cfg_s ren;	/* Ramp Enable */
 	struct rsnd_kctrl_cfg_s rup;	/* Ramp Rate Up */
 	struct rsnd_kctrl_cfg_s rdown;	/* Ramp Rate Down */
+	u32 flags;
 };
 
+#define KCTRL_INITIALIZED	(1 << 0)
+
 #define rsnd_dvc_get(priv, id) ((struct rsnd_dvc *)(priv->dvc) + id)
 #define rsnd_dvc_nr(priv) ((priv)->dvc_nr)
 
@@ -254,6 +257,9 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	int channels = rsnd_rdai_channels_get(rdai);
 	int ret;
 
+	if (rsnd_flags_has(dvc, KCTRL_INITIALIZED))
+		return 0;
+
 	/* Volume */
 	ret = rsnd_kctrl_new_m(mod, io, rtd,
 			is_play ?
@@ -307,6 +313,8 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
+	rsnd_flags_set(dvc, KCTRL_INITIALIZED);
+
 	return 0;
 }
 
-- 
2.14.1

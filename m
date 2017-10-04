From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: CTU kctrl sets once" to the asoc tree
Date: Wed, 04 Oct 2017 12:28:19 +0100
Message-ID: <E1dzhqd-0004Io-De@debutante>
References: <87wp4emo6t.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wp4emo6t.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: CTU kctrl sets once

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

>From 99dc79d0600849ff878a38d9884e76f5bebd3228 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Sun, 1 Oct 2017 23:48:46 +0000
Subject: [PATCH] ASoC: rsnd: CTU kctrl sets once

Same CTU might be used few times if system/platform is using MIX.
For example below case.

	DAI0 playback = <&src0 &ctu02 &mix0 &dvc0 &ssi0>;
	DAI1 playback = <&src2 &ctu03 &mix0 &dvc0 &ssi0>;

This case, ALSA will have CTU,0 and CTU,1 kcontrol interfaces,
but these are same CTU. This is confusing.
This patch adds new flags and avoid such case.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index e7f53f44165d..ad07ba8c3720 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -81,8 +81,11 @@ struct rsnd_ctu {
 	struct rsnd_kctrl_cfg_m sv3;
 	struct rsnd_kctrl_cfg_s reset;
 	int channels;
+	u32 flags;
 };
 
+#define KCTRL_INITIALIZED	(1 << 0)
+
 #define rsnd_ctu_nr(priv) ((priv)->ctu_nr)
 #define for_each_rsnd_ctu(pos, priv, i)					\
 	for ((i) = 0;							\
@@ -277,6 +280,9 @@ static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
 	struct rsnd_ctu *ctu = rsnd_mod_to_ctu(mod);
 	int ret;
 
+	if (rsnd_flags_has(ctu, KCTRL_INITIALIZED))
+		return 0;
+
 	/* CTU Pass */
 	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU Pass",
 			       rsnd_kctrl_accept_anytime,
@@ -326,6 +332,8 @@ static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
 			       rsnd_ctu_value_reset,
 			       &ctu->reset, 1);
 
+	rsnd_flags_set(ctu, KCTRL_INITIALIZED);
+
 	return ret;
 }
 
-- 
2.14.1

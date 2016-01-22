From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup Playback/Capture sequence"
	to the asoc tree
Date: Fri, 22 Jan 2016 18:26:39 +0000
Message-ID: <E1aMgPv-00045I-CM@debutante>
References: <877fj34rwc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AA92F260541
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:47 +0100 (CET)
In-Reply-To: <877fj34rwc.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup Playback/Capture sequence

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

>From 38587f4cb7937344e12a9eef1ccdc5b8a0e992ba Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:59:55 +0000
Subject: [PATCH] ASoC: rsnd: tidyup Playback/Capture sequence

Based on datasheet sequence

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index b460d714d088..1fcefab03ad6 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -358,15 +358,51 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	ret;								\
 })
 
+static enum rsnd_mod_type rsnd_mod_sequence[][RSND_MOD_MAX] = {
+	{
+		/* CAPTURE */
+		RSND_MOD_AUDMAPP,
+		RSND_MOD_AUDMA,
+		RSND_MOD_DVC,
+		RSND_MOD_MIX,
+		RSND_MOD_CTU,
+		RSND_MOD_CMD,
+		RSND_MOD_SRC,
+		RSND_MOD_SSIU,
+		RSND_MOD_SSIM3,
+		RSND_MOD_SSIM2,
+		RSND_MOD_SSIM1,
+		RSND_MOD_SSIP,
+		RSND_MOD_SSI,
+	}, {
+		/* PLAYBACK */
+		RSND_MOD_AUDMAPP,
+		RSND_MOD_AUDMA,
+		RSND_MOD_SSIM3,
+		RSND_MOD_SSIM2,
+		RSND_MOD_SSIM1,
+		RSND_MOD_SSIP,
+		RSND_MOD_SSI,
+		RSND_MOD_SSIU,
+		RSND_MOD_DVC,
+		RSND_MOD_MIX,
+		RSND_MOD_CTU,
+		RSND_MOD_CMD,
+		RSND_MOD_SRC,
+	},
+};
+
 #define rsnd_dai_call(fn, io, param...)				\
 ({								\
 	struct rsnd_mod *mod;					\
+	int type, is_play = rsnd_io_is_play(io);		\
 	int ret = 0, i;						\
 	for (i = 0; i < RSND_MOD_MAX; i++) {			\
-		mod = (io)->mod[i];				\
+		type = rsnd_mod_sequence[is_play][i];		\
+		mod = (io)->mod[type];				\
 		if (!mod)					\
 			continue;				\
-		ret |= rsnd_mod_call(i, io, fn, param);		\
+		ret |= rsnd_mod_call(type, io, fn, param);	\
 	}							\
 	ret;							\
 })
-- 
2.7.0.rc3

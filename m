From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_io_to_mod()" to the asoc
	tree
Date: Thu, 16 Jul 2015 22:29:50 +0100
Message-ID: <E1ZFqj0-0004gS-Q3@finisterre>
References: <87a8uxvqp7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05D512605DC
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:29:56 +0200 (CEST)
In-Reply-To: <87a8uxvqp7.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add rsnd_io_to_mod()

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

>From 5cbbadd3d507eeb7711266e3932f4c427cbcbd61 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:16:19 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_io_to_mod()

Sometimes we would like to get each module directly, especially data path
searching. this patch adds rsnd_io_to_mod() macro, and existing
rsnd_io_to_mod_xxx() use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 705e66f..5f5b8b1 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -348,9 +348,10 @@ struct rsnd_dai_stream {
 	int byte_per_period;
 	int next_period_byte;
 };
-#define rsnd_io_to_mod_ssi(io)	((io)->mod[RSND_MOD_SSI])
-#define rsnd_io_to_mod_src(io)	((io)->mod[RSND_MOD_SRC])
-#define rsnd_io_to_mod_dvc(io)	((io)->mod[RSND_MOD_DVC])
+#define rsnd_io_to_mod(io, i)	((i) < RSND_MOD_MAX ? (io)->mod[(i)] : NULL)
+#define rsnd_io_to_mod_ssi(io)	rsnd_io_to_mod((io), RSND_MOD_SSI)
+#define rsnd_io_to_mod_src(io)	rsnd_io_to_mod((io), RSND_MOD_SRC)
+#define rsnd_io_to_mod_dvc(io)	rsnd_io_to_mod((io), RSND_MOD_DVC)
 #define rsnd_io_to_rdai(io)	((io)->rdai)
 #define rsnd_io_to_priv(io)	(rsnd_rdai_to_priv(rsnd_io_to_rdai(io)))
 #define rsnd_io_is_play(io)	(&rsnd_io_to_rdai(io)->playback == io)
-- 
2.1.4

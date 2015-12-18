From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup return value of
	rsnd_get_adinr_bit()" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:29 +0000
Message-ID: <E1a9twX-00066U-6a@debutante>
References: <87bn9piy5w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD7DD2665B1
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:33 +0100 (CET)
In-Reply-To: <87bn9piy5w.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup return value of rsnd_get_adinr_bit()

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

>From 5e7b9edd928d22ffd4936fc61c80532ed6df5077 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:55:51 +0000
Subject: [PATCH] ASoC: rsnd: tidyup return value of rsnd_get_adinr_bit()

Renesas sound driver has rsnd_get_adinr_bit/chan() functions.
It is assuming _bit() returns ADINR :: OTBL,
and _chan() returns ADINR :: CHNUM.
Current _bit() returns both OTBL and CHNUM. This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 849c1ad93df2..44f32c1db05d 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -227,21 +227,17 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	u32 adinr = runtime->channels;
 
 	switch (runtime->sample_bits) {
 	case 16:
-		adinr |= (8 << 16);
-		break;
+		return 8 << 16;
 	case 32:
-		adinr |= (0 << 16);
-		break;
-	default:
-		dev_warn(dev, "not supported sample bits\n");
-		return 0;
+		return 0 << 16;
 	}
 
-	return adinr;
+	dev_warn(dev, "not supported sample bits\n");
+
+	return 0;
 }
 
 u32 rsnd_get_adinr_chan(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
-- 
2.6.2

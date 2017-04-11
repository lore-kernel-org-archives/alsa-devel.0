From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas2552: Return the real error code" to
	the asoc tree
Date: Tue, 11 Apr 2017 19:37:26 +0100
Message-ID: <E1cy0fO-00047k-Mt@debutante>
References: <1491918122-15253-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D28D92666E1
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 20:37:38 +0200 (CEST)
In-Reply-To: <1491918122-15253-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas2552: Return the real error code

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

>From 6f2daf82fa1e92fcc10ec34a1d0ffe85a00bf794 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 11 Apr 2017 10:42:02 -0300
Subject: [PATCH] ASoC: tas2552: Return the real error code

In the case of error in tas2552_codec_probe() we should better
propagate the real error code instead of always returning '-EIO'.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index baf455e8c2f7..fd5251e98eca 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -611,7 +611,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 
 	regulator_bulk_disable(ARRAY_SIZE(tas2552->supplies),
 					tas2552->supplies);
-	return -EIO;
+	return ret;
 }
 
 static int tas2552_codec_remove(struct snd_soc_codec *codec)
-- 
2.11.0

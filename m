From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Added 10ms sleep after amp
	software reset" to the asoc tree
Date: Tue, 28 Aug 2018 21:46:00 +0100 (BST)
Message-ID: <20180828204600.DFE2744007A@finisterre.ee.mobilebroadband>
References: <20180824013708.23737-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 478C726781A
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:46:39 +0200 (CEST)
In-Reply-To: <20180824013708.23737-1-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Added 10ms sleep after amp software reset

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

>From ca917f9fe1a0fab3dde41bba4bbd173c5a3c5805 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Thu, 23 Aug 2018 18:37:08 -0700
Subject: [PATCH] ASoC: max98373: Added 10ms sleep after amp software reset

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 2764fae69333..1093f766d0d2 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -730,6 +730,7 @@ static int max98373_probe(struct snd_soc_component *component)
 	/* Software Reset */
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -818,6 +819,7 @@ static int max98373_resume(struct device *dev)
 
 	regmap_write(max98373->regmap,
 		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
+	usleep_range(10000, 11000);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
-- 
2.18.0

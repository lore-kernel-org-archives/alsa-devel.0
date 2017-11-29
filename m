From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: byt: Fix quirk for KIANO laptop"
	to the asoc tree
Date: Wed, 29 Nov 2017 18:59:49 +0000
Message-ID: <E1eK7aH-0004dy-6m@debutante>
References: <20171121171546.5656-3-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A12326793A
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 19:59:56 +0100 (CET)
In-Reply-To: <20171121171546.5656-3-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: byt: Fix quirk for KIANO laptop

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

>From 56fa898be862053327b2ff8abfa0a6e7f350f81d Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Tue, 21 Nov 2017 17:15:46 +0000
Subject: [PATCH] ASoC: intel: byt: Fix quirk for KIANO laptop

This laptop has actually two different analog mics, no just one. Fix the
quirk to reflect the correct configuration.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e3d5e6ea707f..488ec48f296a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -264,7 +264,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
 		},
-		.driver_data = (void *)(BYT_RT5651_IN2_MAP),
+		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
 };
-- 
2.15.0

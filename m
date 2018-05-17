From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: Fix Dell Venue 8
	5830 Pro quirk" to the asoc tree
Date: Thu, 17 May 2018 17:39:36 +0100 (BST)
Message-ID: <20180517163936.2045E44007E@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-12-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 234A12671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:39:39 +0200 (CEST)
In-Reply-To: <20180508153604.23711-12-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: Fix Dell Venue 8 5830 Pro quirk

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

>From 6748fb7e77ebff6a216243076cf162c1c700e9d6 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 May 2018 09:24:27 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Fix Dell Venue 8 5830 Pro quirk

This fixes the following 3 issues:

1) The sys_vendor match should be for "Dell Inc." not "DellInc.",
   without this fixed the quirk never gets applied
2) DMIC1 is used not DMIC2, this was not a problem sofar because for
   regular BYT boards (rather then BYTCR) we default to DMIC1 and because
   of 1. the quirk was not being applied
3) The Dell Venue 8 5830 Pro only has a single speaker

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index cc607cfeda56..d0706ea3b04f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -370,10 +370,11 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{
 		.callback = byt_rt5640_quirk_cb,
 		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "DellInc."),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
 		},
-		.driver_data = (void *)(BYT_RT5640_DMIC2_MAP |
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_MONO_SPEAKER |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
-- 
2.17.0

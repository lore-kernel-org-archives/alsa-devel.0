From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Set OVCD limit for
	VIOS LTH17 to 2000uA" to the asoc tree
Date: Thu, 19 Jul 2018 17:57:05 +0100
Message-ID: <E1fgCEj-0005Qk-PB@debutante>
References: <20180718205542.12364-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5159D267749
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 18:57:11 +0200 (CEST)
In-Reply-To: <20180718205542.12364-4-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Set OVCD limit for VIOS LTH17 to 2000uA

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

>From 8627fb257e1673d2c2277494545642921097da86 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 18 Jul 2018 22:55:39 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Set OVCD limit for VIOS LTH17 to
 2000uA

With the default over current detect limit of 1500uA headsets on often
get detected as headphones on the VIOS LTH17 and even when detected as
headset the OVCD current triggers often while plugged in, resulting in
false-positive button press detection.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 601e47c33ba8..53ac97c15fc6 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -414,8 +414,11 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "VIOS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
-		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_IN2_MAP),
+		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP |
+					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVCD_TH_2000UA |
+					BYT_RT5651_OVCD_SF_1P0 |
+					BYT_RT5651_MCLK_EN),
 	},
 	{}
 };
-- 
2.18.0

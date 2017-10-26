From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: byt: Enable IN2 map quirk for a
	KIANO laptop" to the asoc tree
Date: Thu, 26 Oct 2017 15:16:46 +0100 (BST)
Message-ID: <20171026141646.46D4A44005B@finisterre.ee.mobilebroadband>
References: <20171020111859.2448-4-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0988F266E15
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 16:16:48 +0200 (CEST)
In-Reply-To: <20171020111859.2448-4-carlo@caione.org>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, edgar_shen@realtek.com, tiwai@suse.com, pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org, albertchen@realtek.com, broonie@kernel.org, bardliao@realtek.com, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: byt: Enable IN2 map quirk for a KIANO laptop

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

>From 2fe30129b0a6a8ddf71c46c8fb4524cb89739bc0 Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Fri, 20 Oct 2017 12:18:57 +0100
Subject: [PATCH] ASoC: intel: byt: Enable IN2 map quirk for a KIANO laptop

This cherry-trails laptop has the internal mic connected to the IN2
input pins. Enable the quirk to correctly map the routes.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 0df9067e4382..d955836c6870 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -250,6 +250,14 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5651_DMIC_MAP |
 					BYT_RT5651_DMIC_EN),
 	},
+	{
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
+		},
+		.driver_data = (void *)(BYT_RT5651_IN2_MAP),
+	},
 	{}
 };
 
-- 
2.14.1

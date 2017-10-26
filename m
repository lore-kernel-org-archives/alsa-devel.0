From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Enable JD1_1 quirk for KIANO laptopt" to the asoc tree
Date: Thu, 26 Oct 2017 15:16:54 +0100 (BST)
Message-ID: <20171026141654.8531544005B@finisterre.ee.mobilebroadband>
References: <20171020111859.2448-6-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020111859.2448-6-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Mark Brown <broonie@kernel.org>, linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Enable JD1_1 quirk for KIANO laptopt

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

>From f85353fdd49fe0087438ef7d7475a832d16276c4 Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Fri, 20 Oct 2017 12:18:59 +0100
Subject: [PATCH] ASoC: rt5651: Enable JD1_1 quirk for KIANO laptopt

The KIANO SlimNote 14.2 laptop uses the JD1_1 input pin for jack
detection. Set the correct quirk in the codec driver.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index f01d41101631..831b297978a4 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1753,6 +1753,14 @@ static int rt5651_quirk_cb(const struct dmi_system_id *id)
 }
 
 static const struct dmi_system_id rt5651_quirk_table[] = {
+	{
+		.callback = rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
+		},
+		.driver_data = (unsigned long *) RT5651_JD1_1,
+	},
 	{}
 };
 
-- 
2.14.1

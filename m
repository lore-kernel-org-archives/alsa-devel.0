From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add struct dmi_system_id "Google Celes" for chrome platform" to the asoc tree
Date: Tue, 25 Aug 2015 19:13:08 +0100
Message-ID: <E1ZUIia-0006At-2d@debutante>
References: <1440489828-24347-1-git-send-email-oder_chiou@realtek.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1440489828-24347-1-git-send-email-oder_chiou@realtek.com>
Sender: stable-owner@vger.kernel.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add struct dmi_system_id "Google Celes" for chrome platform

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

>From c1713485f9fc06e1f4de9800b43f6486f2527379 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Tue, 25 Aug 2015 16:03:48 +0800
Subject: [PATCH] ASoC: rt5645: Add struct dmi_system_id "Google Celes" for
 chrome platform

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/rt5645.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ce311e088fc..610eacd34900 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3229,6 +3229,13 @@ static struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Strago"),
 		},
 	},
+	{
+		.ident = "Google Celes",
+		.callback = strago_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
+		},
+	},
 	{ }
 };
 
-- 
2.5.0

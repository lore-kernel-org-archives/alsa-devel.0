From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add ACPI ID 10EC5640" to the
	asoc tree
Date: Fri, 08 Jul 2016 14:31:49 +0200
Message-ID: <E1bLUwf-0006sT-OV@finisterre>
References: <20160704050607.32213-2-stephenjust@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160704050607.32213-2-stephenjust@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Sachin Mokashi <sachinx.mokashi@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, patch@alsa-project.org, Stephen Just <stephenjust@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add ACPI ID 10EC5640

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

>From 79c89031e0b6de9e3dc2318b211f1872c99753f7 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 8 Jul 2016 15:39:50 +0530
Subject: [PATCH] ASoC: rt5645: Add ACPI ID 10EC5640

Some CHT platforms use RT5645 codec which has entry 10EC5640 so add it.
Also add DMI quirk for jack detection.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98001
[Jack detection]
Suggested-by: Stephen Just <stephenjust@gmail.com>
Signed-off-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index dbf05600b5ff..e5556a19c995 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3543,6 +3543,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
 	{ "10EC5650", 0 },
+	{ "10EC5640", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
@@ -3573,6 +3574,12 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
 		},
 	},
+	{
+		.ident = "Microsoft Surface 3",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
+		},
+	},
 	{ }
 };
 
-- 
2.8.1

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: rt5670: add Thinkpad Tablet 10
	quirk" to the asoc tree
Date: Tue, 18 Apr 2017 19:00:04 +0100
Message-ID: <E1d0XQ4-0007BT-EV@debutante>
References: <20170417150408.20935-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8790E266DBE
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 20:00:18 +0200 (CEST)
In-Reply-To: <20170417150408.20935-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicole Faerber <nicole.faerber@id3p.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: rt5670: add Thinkpad Tablet 10 quirk

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

>From 67e03ff3f32ffeb8f425d80627f3054b60bac0b7 Mon Sep 17 00:00:00 2001
From: Nicole Faerber <nicole.faerber@id3p.com>
Date: Mon, 17 Apr 2017 10:04:08 -0500
Subject: [PATCH] ASoC: codecs: rt5670: add Thinkpad Tablet 10 quirk

The Thinkpad Tablet tablet has a similar audio setup as the Intel Braswell
platform.
A quirk is needed to detect the platform and setup the platform data
properly:

Manufacturer: LENOVO
        Product Name: 20C1CTO1WW
        Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C3001VHH
	Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C10024GE
	Version: ThinkPad Tablet B

Manufacturer: LENOVO
    	Product Name: 20359
    	Version: Lenovo Miix 2 10

Signed-off-by: Nicole Faerber <nicole.faerber@id3p.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 17d20b99f041..e27c5a4a0a15 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2835,6 +2835,27 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Wyse 3040"),
 		},
 	},
+	{
+		.ident = "Lenovo Thinkpad Tablet 10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 10"),
+		},
+	},
+	{
+		.ident = "Lenovo Thinkpad Tablet 10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Tablet B"),
+		},
+	},
+	{
+		.ident = "Lenovo Thinkpad Tablet 10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
+		},
+	},
 	{}
 };
 
-- 
2.11.0

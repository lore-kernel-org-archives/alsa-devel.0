From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 08/10] ASoC: Intel: cht_bsw_rt5645: Convert
	to use acpi_dev_get_first_match_dev()
Date: Thu, 28 Mar 2019 19:17:27 +0200
Message-ID: <20190328171729.44002-9-andriy.shevchenko@linux.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C28C6F89705
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 18:17:39 +0100 (CET)
In-Reply-To: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

acpi_dev_get_first_match_name() is deprecated and going to be removed
because it leaks a reference.

Convert the driver to use acpi_dev_get_first_match_dev() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index cbc2d458483f..32dbeaf1ab94 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -532,7 +532,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
 	struct cht_mc_private *drv;
-	const char *i2c_name = NULL;
+	struct acpi_device *adev;
 	bool found = false;
 	bool is_bytcr = false;
 	int dai_index = 0;
@@ -573,10 +573,11 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 
 	/* fixup codec name based on HID */
-	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
-	if (i2c_name) {
+	adev = acpi_dev_get_first_match_dev(mach->id, NULL, -1);
+	if (adev) {
 		snprintf(cht_rt5645_codec_name, sizeof(cht_rt5645_codec_name),
-			"%s%s", "i2c-", i2c_name);
+			 "i2c-%s", acpi_dev_name(adev));
+		put_device(&adev->dev);
 		cht_dailink[dai_index].codec_name = cht_rt5645_codec_name;
 	}
 
-- 
2.20.1

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 07/10] ASoC: Intel: bytcr_rt5651: Convert to
	use acpi_dev_get_first_match_dev()
Date: Thu, 28 Mar 2019 19:17:26 +0200
Message-ID: <20190328171729.44002-8-andriy.shevchenko@linux.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A95FF89714
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 18:17:40 +0100 (CET)
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
 sound/soc/intel/boards/bytcr_rt5651.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index b0a4d297176e..b744add01d12 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -867,8 +867,8 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
+	struct acpi_device *adev;
 	struct device *codec_dev;
-	const char *i2c_name = NULL;
 	const char *hp_swapped;
 	bool is_bytcr = false;
 	int ret_val = 0;
@@ -894,14 +894,16 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	/* fixup codec name based on HID */
-	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
-	if (!i2c_name) {
+	adev = acpi_dev_get_first_match_dev(mach->id, NULL, -1);
+	if (adev) {
+		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
+			 "i2c-%s", acpi_dev_name(adev));
+		put_device(&adev->dev);
+		byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
+	} else {
 		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
 		return -ENODEV;
 	}
-	snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
-		"%s%s", "i2c-", i2c_name);
-	byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
 
 	codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL,
 					    byt_rt5651_codec_name);
-- 
2.20.1

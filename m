From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 02/10] extcon: axp288: Convert to use
	acpi_dev_get_first_match_dev()
Date: Thu, 28 Mar 2019 19:17:21 +0200
Message-ID: <20190328171729.44002-3-andriy.shevchenko@linux.intel.com>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6411F8963C
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 18:17:36 +0100 (CET)
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
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: alsa-devel@alsa-project.org

acpi_dev_get_first_match_name() is deprecated and going to be removed
because it leaks a reference.

Convert the driver to use acpi_dev_get_first_match_dev() instead.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-axp288.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index a983708b77a6..50f9402fb325 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -333,7 +333,7 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 	struct axp288_extcon_info *info;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
-	const char *name;
+	struct acpi_device *adev;
 	int ret, i, pirq;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -357,9 +357,10 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		name = acpi_dev_get_first_match_name("INT3496", NULL, -1);
-		if (name) {
-			info->id_extcon = extcon_get_extcon_dev(name);
+		adev = acpi_dev_get_first_match_dev("INT3496", NULL, -1);
+		if (adev) {
+			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
+			put_device(&adev->dev);
 			if (!info->id_extcon)
 				return -EPROBE_DEFER;
 
-- 
2.20.1

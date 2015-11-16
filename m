From: Pavel Machek <pavel@ucw.cz>
Subject: Re: multi-codec support for arizona-ldo1 was Re:
 System with multiple arizona (wm5102) codecs
Date: Mon, 16 Nov 2015 13:29:47 +0100
Message-ID: <20151116122947.GA9125@amd>
References: <20151113215812.GA19020@amd> <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd> <20151114123931.GW12392@sirena.org.uk>
 <20151114175915.GA20429@amd> <20151114184940.GY12392@sirena.org.uk>
 <20151114211633.GE20429@amd> <20151115001402.GZ12392@sirena.org.uk>
 <20151116074534.GA5606@amd> <20151116105035.GA31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40C46260455
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 13:30:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151116105035.GA31303@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi!

> > > Every single sound driver gets this right, none of them assume the name
> > > is global.  What makes you say that they assume names are global?
> 
> > Ok, so you are saying that if I fix mfd initialization, sound will
> > automagically switch from global regulators to device-specific
> > regulators and things will start working?
> 
> Yes.

Ok, so something like this should be applied?

(I'm not sure how to test it, as audio works before and after the
patch.)

Thanks,
								Pavel

Signed-off-by: Pavel Machek <pavel@denx.de>

commit d6005263acb94343645e719ee90b8940cb2545df
Author: Pavel <pavel@ucw.cz>
Date:   Mon Nov 16 13:19:21 2015 +0100

    regulator_bulk_register() needs device to be already
    registered. Reorganize the code to make it so.

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 14fd5cb..e891f10 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -147,12 +147,6 @@ static int mfd_add_device(struct device *parent, int id,
 	pdev->dev.dma_parms = parent->dma_parms;
 	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
 
-	ret = regulator_bulk_register_supply_alias(
-			&pdev->dev, cell->parent_supplies,
-			parent, cell->parent_supplies,
-			cell->num_parent_supplies);
-	if (ret < 0)
-		goto fail_res;
 
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
@@ -169,12 +176,12 @@ static int mfd_add_device(struct device *parent, int id,
 		ret = platform_device_add_data(pdev,
 					cell->platform_data, cell->pdata_size);
 		if (ret)
-			goto fail_alias;
+			goto fail_res;
 	}
 
 	ret = mfd_platform_add_cell(pdev, cell, usage_count);
 	if (ret)
-		goto fail_alias;
+		goto fail_res;
 
 	for (r = 0; r < cell->num_resources; r++) {
 		res[r].name = cell->resources[r].name;
@@ -210,22 +217,29 @@ static int mfd_add_device(struct device *parent, int id,
 			if (has_acpi_companion(&pdev->dev)) {
 				ret = acpi_check_resource_conflict(&res[r]);
 				if (ret)
-					goto fail_alias;
+					goto fail_res;
 			}
 		}
 	}
 
 	ret = platform_device_add_resources(pdev, res, cell->num_resources);
 	if (ret)
-		goto fail_alias;
+		goto fail_res;
 
 	ret = platform_device_add(pdev);
 	if (ret)
-		goto fail_alias;
+		goto fail_res;
 
 	if (cell->pm_runtime_no_callbacks)
 		pm_runtime_no_callbacks(&pdev->dev);
 
+	ret = regulator_bulk_register_supply_alias(
+			&pdev->dev, cell->parent_supplies,
+			parent, cell->parent_supplies,
+			cell->num_parent_supplies);
+	if (ret < 0)
+		goto fail_alias;
+
 	kfree(res);
 
 	return 0;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_da7213: cosmetic fixes"
	to the asoc tree
Date: Wed, 18 Oct 2017 12:31:17 +0100
Message-ID: <E1e4mZB-0003xM-W5@debutante>
References: <20171005185243.4174-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C622E26745A
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 13:31:21 +0200 (CEST)
In-Reply-To: <20171005185243.4174-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vinod.koul@intel.com, broonie@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_da7213: cosmetic fixes

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

>From 22a317a0505d11db3ab08f4e4b25d3064228af02 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:38:00 -0500
Subject: [PATCH] ASoC: Intel: bytcht_da7213: cosmetic fixes

Reorder variable names, change tests
No functional change

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_da7213.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 18873e23f404..24070bc06040 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -231,12 +231,12 @@ static char codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
 
 static int bytcht_da7213_probe(struct platform_device *pdev)
 {
-	int ret_val = 0;
-	int i;
 	struct snd_soc_card *card;
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
+	int ret_val = 0;
+	int i;
 
 	mach = (&pdev->dev)->platform_data;
 	card = &bytcht_da7213_card;
@@ -253,7 +253,7 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	i2c_name = sst_acpi_find_name_from_hid(mach->id);
-	if (i2c_name != NULL) {
+	if (i2c_name) {
 		snprintf(codec_name, sizeof(codec_name),
 			"%s%s", "i2c-", i2c_name);
 		dailink[dai_index].codec_name = codec_name;
-- 
2.14.1

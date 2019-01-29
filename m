From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_rt5672: remove useless
	test" to the asoc tree
Date: Tue, 29 Jan 2019 17:16:08 +0000 (GMT)
Message-ID: <20190129171608.2640B1127D50@debutante.sirena.org.uk>
References: <20190129154220.3142-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 90C092674A3
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 18:16:10 +0100 (CET)
In-Reply-To: <20190129154220.3142-1-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Colin Ian King <colin.king@canonical.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_rt5672: remove useless test

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

>From 53b6d0adffb0505db5332589e78da1c66f7e626a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 29 Jan 2019 09:42:20 -0600
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5672: remove useless test

For some reason we test if the machine is passed as a parameter before
fixing up the codec name. This is unnecessary, generates false
positives in static analysis tools and done only in this machine
driver, remove and adjust indentation.

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index f1c1f9dd5353..3d5a2b3a06f0 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -411,18 +411,15 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	strcpy(drv->codec_name, RT5672_I2C_DEFAULT);
 
 	/* fixup codec name based on HID */
-	if (mach) {
-		i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
-		if (i2c_name) {
-			snprintf(drv->codec_name, sizeof(drv->codec_name),
-				 "i2c-%s", i2c_name);
-			for (i = 0; i < ARRAY_SIZE(cht_dailink); i++) {
-				if (!strcmp(cht_dailink[i].codec_name,
-					    RT5672_I2C_DEFAULT)) {
-					cht_dailink[i].codec_name =
-						drv->codec_name;
-					break;
-				}
+	i2c_name = acpi_dev_get_first_match_name(mach->id, NULL, -1);
+	if (i2c_name) {
+		snprintf(drv->codec_name, sizeof(drv->codec_name),
+			 "i2c-%s", i2c_name);
+		for (i = 0; i < ARRAY_SIZE(cht_dailink); i++) {
+			if (!strcmp(cht_dailink[i].codec_name,
+				RT5672_I2C_DEFAULT)) {
+				cht_dailink[i].codec_name = drv->codec_name;
+				break;
 			}
 		}
 	}
-- 
2.20.1

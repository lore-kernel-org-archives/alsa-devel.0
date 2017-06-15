From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] ASoC: Intel: bdw-rt5677: Switch to
	devm_acpi_dev_add_driver_gpios()
Date: Thu, 15 Jun 2017 15:46:38 +0300
Message-ID: <20170615124638.65971-4-andriy.shevchenko@linux.intel.com>
References: <20170615124638.65971-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C6B76266819
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 14:47:12 +0200 (CEST)
In-Reply-To: <20170615124638.65971-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, John Keeping <john@metanate.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Switch to use managed variant of acpi_dev_add_driver_gpios() to simplify
error path and fix potentially wrong assignment if ->probe() fails.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index bb98e94dd6f9..058b8ccedf02 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -207,8 +207,7 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	int ret;
 
-	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(codec->dev),
-			bdw_rt5677_gpios);
+	ret = devm_acpi_dev_add_driver_gpios(codec->dev, bdw_rt5677_gpios);
 	if (ret)
 		dev_warn(codec->dev, "Failed to add driver gpios\n");
 
-- 
2.11.0

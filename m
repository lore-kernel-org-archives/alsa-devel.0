From: han.lu@intel.com
Subject: [PATCH V6 2/2] ASoC: bytcr-rt5640: register DMI names
	for card
Date: Wed,  6 Apr 2016 12:43:22 +0800
Message-ID: <1cb291dc87f36b778ee6e3cc6520c930ce32aafe.1459917632.git.han.lu@intel.com>
References: <cover.1459917632.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 04F2C2659E3
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 06:42:33 +0200 (CEST)
In-Reply-To: <cover.1459917632.git.han.lu@intel.com>
In-Reply-To: <cover.1459917632.git.han.lu@intel.com>
References: <cover.1459917632.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Register DMI names for products using bytcr-rt5640 driver, such as ASUS
T100TA and Dell Venue 8 Pro 5830, for user space utils to distinguish
different products.

For example, previously on T100TA:
  $ cat /proc/asound/cards
    0 [bytcrrt5640 ]: bytcr-rt5640 -  bytcr-rt5640
                      bytcr-rt5640
  $ amixer -c0 info
  Card hw:0 'bytcrrt5640'/'bytcr-rt5640'
    Mixer name    : ''
    Components    : ''
    Controls      : 256
    Simple ctrls  : 228

After apply the patch:
  $ cat /proc/asound/cards
    0 [T100TA      ]: bytcr-rt5640 -  T100TA
                      T100TA;bytcr-rt5640;ASUSTek COMPUTER INC.;intel/fw_
  sst_0f28.bin
  $ amixer -c0 info
  Card hw:0 'T100TA'/'T100TA;bytcr-rt5640;ASUSTek COMPUTER INC.;intel/fw_
  sst_0f28.bin'
    Mixer name    : ''
    Components    : 'T100TA;bytcr-rt5640;ASUSTek COMPUTER INC.;intel/fw_s
  st_0f28.bin'
    Controls      : 256
    Simple ctrls  : 228

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 032a2e7..014b549 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -152,6 +152,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{}
 };
 
+static struct snd_soc_card byt_rt5640_card;
+
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
@@ -159,6 +161,13 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_card *card = runtime->card;
 	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
+	struct sst_acpi_mach *mach = byt_rt5640_card.dev->platform_data;
+
+	ret = snd_soc_set_card_names(card, mach->fw_filename);
+	if (ret < 0) {
+		dev_err(card->dev, "unable to register card names\n");
+		return ret;
+	}
 
 	card->dapm.idle_bias_off = true;
 
@@ -380,12 +389,21 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	return ret_val;
 }
 
+static int snd_byt_rt5640_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &byt_rt5640_card;
+
+	snd_soc_cleanup_card_names(card);
+	return 0;
+}
+
 static struct platform_driver snd_byt_rt5640_mc_driver = {
 	.driver = {
 		.name = "bytcr_rt5640",
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = snd_byt_rt5640_mc_probe,
+	.remove = snd_byt_rt5640_mc_remove,
 };
 
 module_platform_driver(snd_byt_rt5640_mc_driver);
-- 
2.5.0

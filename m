From: han.lu@intel.com
Subject: [PATCH V4 2/2] ASoC: bytcr-rt5640: register DMI names
	to card
Date: Fri,  1 Apr 2016 13:46:32 +0800
Message-ID: <0adfd09de5f28756a8be556b1664ab5a9d547d9e.1459488225.git.han.lu@intel.com>
References: <cover.1459488225.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 21AB1265232
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 07:45:31 +0200 (CEST)
In-Reply-To: <cover.1459488225.git.han.lu@intel.com>
In-Reply-To: <cover.1459488225.git.han.lu@intel.com>
References: <cover.1459488225.git.han.lu@intel.com>
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
                      T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.:intel/fw_
  sst_0f28.bin
  $ amixer -c0 info
  Card hw:0 'T100TA'/'T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.:intel/fw_
  sst_0f28.bin'
    Mixer name    : ''
    Components    : 'T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.:intel/fw_s
  st_0f28.bin'
    Controls      : 256
    Simple ctrls  : 228

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 032a2e7..468a724 100644
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
@@ -159,6 +161,19 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_card *card = runtime->card;
 	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
+	const char *board, *vendor;
+	struct sst_acpi_mach *mach = byt_rt5640_card.dev->platform_data;
+
+	/* Add board/product/vendor/firmware name for userspace */
+	board = dmi_get_system_info(DMI_BOARD_NAME);
+	if (!board)
+		board = dmi_get_system_info(DMI_PRODUCT_NAME);
+	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	ret = snd_soc_set_card_names(card, board, vendor, mach->fw_filename);
+	if (ret < 0) {
+		dev_err(card->dev, "unable to set card names\n");
+		return ret;
+	}
 
 	card->dapm.idle_bias_off = true;
 
-- 
2.5.0

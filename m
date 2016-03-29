From: han.lu@intel.com
Subject: [PATCH 1/1] Asoc: bytcr-rt5640: add more machine/board
	information for user space
Date: Tue, 29 Mar 2016 14:35:07 +0800
Message-ID: <1459233307-12842-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A1BA126066B
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 08:34:25 +0200 (CEST)
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

Add more machine/board information for PA and UCM.
Previously on ASoc, the card short name, driver name and long name are
all the same as the machine driver name. On T100TA it looks like:
  $ cat /proc/asound/cards
    0 [bytcr-rt5640]: bytcr-rt5640 -  bytcr-rt5640
                      bytcr-rt5640
The patch made changes below:
  driver name --->  machine driver name
  short name  --->  DMI_PRODUCT_NAME or DMI_BOARD_NAME
  long name   --->  short name:driver name(:DMI_SYS_VENDOR if applicable)
And add card component: long name:firmware name. On T100TA it looks like:
  $ cat /proc/asound/cards
    0 [T100TA      ]: bytcr-rt5640 -  T100TA
                      T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.
  $ amixer -c0 info
  Card hw:0 'T100TA'/'T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.'
    Mixer name    : ''
    Components    : 'T100TA:bytcr-rt5640:ASUSTek COMPUTER INC.:intel/fw_s
  st_0f28.bin'
    Controls      : 256
    Simple ctrls  : 228

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 032a2e7..068cd58 100644
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
@@ -159,6 +161,34 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_card *card = runtime->card;
 	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
+	const char *dmi_name;
+	char *component;
+	struct sst_acpi_mach *mach = byt_rt5640_card.dev->platform_data;
+
+	/* Add machine/board information for userspace:
+	 *   card driver name --->  machine driver name
+	 *   card short name  --->  DMI_PRODUCT_NAME or DMI_BOARD_NAME
+	 *   card long name   --->  short name:driver name(:DMI_SYS_VENDOR)
+	 */
+	card->driver_name = card->name;
+	dmi_name = dmi_get_system_info(DMI_PRODUCT_NAME);
+	if (!dmi_name)
+		dmi_name = dmi_get_system_info(DMI_BOARD_NAME);
+	if (dmi_name)
+		card->name = dmi_name;
+	card->long_name = kstrdup(card->name, GFP_KERNEL);
+	strcat((char *)card->long_name, ":");
+	strcat((char *)card->long_name, card->driver_name);
+	dmi_name = dmi_get_system_info(DMI_SYS_VENDOR);
+	if (dmi_name) {
+		strcat((char *)card->long_name, ":");
+		strcat((char *)card->long_name, dmi_name);
+	}
+	/*  card component  --->  long name:firmware name */
+	component = kstrdup(card->long_name, GFP_KERNEL);
+	strcat(component, ":");
+	strcat(component, mach->fw_filename);
+	snd_component_add(card->snd_card, component);
 
 	card->dapm.idle_bias_off = true;
 
-- 
2.5.0

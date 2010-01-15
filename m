From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: [PATCH] ALSA: Fix mute led GPIO on HP dv-series
	notebooks.
Date: Fri, 15 Jan 2010 12:04:11 +0530
Message-ID: <1263537251-3932-1-git-send-email-kunal.gangakhedkar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id EE0A010380E
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 07:47:00 +0100 (CET)
Received: by ywh33 with SMTP id 33so267001ywh.23
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 22:46:58 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Devel List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Goldwyn Rodrigues <goldwynr@gmail.com>, Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
List-Id: alsa-devel@alsa-project.org

On my laptop (HP dv6-1110ax), there are no OEM strings in SMBIOS of type
"HP_Mute_LED*". Hence, the GPIO for the mute button LED doesn't get set
properly. I didn't find the strings in my cousin's laptop (HP dv9500t CTO)
either.

As per the documentation of find_mute_led_gpio(), these strings occur
in HP B-series systems - so, before scanning the SMBIOS strings, we need to
check if we're dealing with a B-series system.
Need to get confirmation from HP if this logic takes care of all the
systems. I'm trying to poke a friend there.

Please let me know if this looks OK or needs changes.

Signed-off-by: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
---
 sound/pci/hda/patch_sigmatel.c |   82 ++++++++++++++++++++++++++++++----------
 1 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 117919a..d421b3b 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4737,6 +4737,8 @@ static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
 	}
 }
 
+static int hp_blike_system(u32 subsystem_id);
+
 /*
  * This method searches for the mute LED GPIO configuration
  * provided as OEM string in SMBIOS. The format of that string
@@ -4748,6 +4750,19 @@ static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
  *
  * So, HP B-series like systems may have HP_Mute_LED_0 (current models)
  * or  HP_Mute_LED_0_3 (future models) OEM SMBIOS strings
+ *
+ *
+ * The dv-series laptops don't seem to have the HP_Mute_LED* strings in
+ * SMBIOS - at least the ones I have seen do not have them - which include
+ * my own system (HP Pavilion dv6-1110ax) and my cousin's
+ * HP Pavilion dv9500t CTO.
+ * Need more information on whether it is true across the entire series.
+ *
+ * The "else" could be converted into a conditional check for dv-series -
+ * say, hp_dv_series_system() - just like hp_blike_system(); however,
+ * I don't have all the PCI ids to identify the dv-series machines - maybe,
+ * we can add that later.
+ * -- kunal
  */
 static int find_mute_led_gpio(struct hda_codec *codec)
 {
@@ -4755,29 +4770,54 @@ static int find_mute_led_gpio(struct hda_codec *codec)
 	const struct dmi_device *dev = NULL;
 
 	if ((codec->subsystem_id >> 16) == PCI_VENDOR_ID_HP) {
-		while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
+		if (hp_blike_system(codec->subsystem_id)) {
+			while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
 								NULL, dev))) {
-			if (sscanf(dev->name, "HP_Mute_LED_%d_%d",
-			      &spec->gpio_led_polarity,
-			      &spec->gpio_led) == 2) {
-				spec->gpio_led = 1 << spec->gpio_led;
-				return 1;
-			}
-			if (sscanf(dev->name, "HP_Mute_LED_%d",
-			      &spec->gpio_led_polarity) == 1) {
-				switch (codec->vendor_id) {
-				case 0x111d7608:
-					/* GPIO 0 */
-					spec->gpio_led = 0x01;
-					return 1;
-				case 0x111d7600:
-				case 0x111d7601:
-				case 0x111d7602:
-				case 0x111d7603:
-					/* GPIO 3 */
-					spec->gpio_led = 0x08;
+				if (sscanf(dev->name, "HP_Mute_LED_%d_%d",
+					  &spec->gpio_led_polarity,
+					  &spec->gpio_led) == 2) {
+					spec->gpio_led = 1 << spec->gpio_led;
 					return 1;
 				}
+				if (sscanf(dev->name, "HP_Mute_LED_%d",
+					  &spec->gpio_led_polarity) == 1) {
+					switch (codec->vendor_id) {
+					case 0x111d7608:
+						/* GPIO 0 */
+						spec->gpio_led = 0x01;
+						return 1;
+					case 0x111d7600:
+					case 0x111d7601:
+					case 0x111d7602:
+					case 0x111d7603:
+						/* GPIO 3 */
+						spec->gpio_led = 0x08;
+						return 1;
+					}
+				}
+			}
+		} else {
+			/*
+			 * Pavilion dv series notebooks do not seem to have
+			 * HP_Mute_LED* in SMBIOS.
+			 * If HP decides to add it in dv series,
+			 * we'll need to fix this part
+			 * - or merge it with the B-like check above.
+			 */
+			switch (codec->vendor_id) {
+			case 0x111d7608:
+				/* GPIO 0 */
+				spec->gpio_led = 0x01;
+				spec->gpio_led_polarity |= spec->gpio_led;
+				return 1;
+			case 0x111d7600:
+			case 0x111d7601:
+			case 0x111d7602:
+			case 0x111d7603:
+				/* GPIO 3 */
+				spec->gpio_led = 0x08;
+				spec->gpio_led_polarity |= spec->gpio_led;
+				return 1;
 			}
 		}
 	}
@@ -5603,6 +5643,8 @@ again:
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
 	spec->num_smuxes = stac92hd71bxx_connected_smuxes(codec, 0x1e);
 
+	snd_printd("Found board config: %d\n", spec->board_config);
+
 	switch (spec->board_config) {
 	case STAC_HP_M4:
 		/* enable internal microphone */
-- 
1.6.6.60.gc2ff1

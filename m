From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/12] ALSA: hda/sigmatel - Remove PCI id check
	in find_mute_led_cfg()
Date: Tue, 15 Jan 2013 12:09:47 +0100
Message-ID: <1358248189-14166-11-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D2803265D76
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 881C8A520C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
In-Reply-To: <1358248189-14166-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The PCI vendor ID check in find_mute_led_cfg() is now superfluous
because the function is called in the fixup table entries of HP
machines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 83 ++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index fa16ff7..3368f74 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -6219,53 +6219,50 @@ static int find_mute_led_cfg(struct hda_codec *codec, int default_polarity)
 		return 1;
 	}
 
-	if ((codec->subsystem_id >> 16) == PCI_VENDOR_ID_HP) {
-		while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
-								NULL, dev))) {
-			if (sscanf(dev->name, "HP_Mute_LED_%d_%x",
-				  &spec->gpio_led_polarity,
-				  &spec->gpio_led) == 2) {
-				unsigned int max_gpio;
-				max_gpio = snd_hda_param_read(codec, codec->afg,
-							      AC_PAR_GPIO_CAP);
-				max_gpio &= AC_GPIO_IO_COUNT;
-				if (spec->gpio_led < max_gpio)
-					spec->gpio_led = 1 << spec->gpio_led;
-				else
-					spec->vref_mute_led_nid = spec->gpio_led;
-				return 1;
-			}
-			if (sscanf(dev->name, "HP_Mute_LED_%d",
-				  &spec->gpio_led_polarity) == 1) {
-				set_hp_led_gpio(codec);
-				return 1;
-			}
-			/* BIOS bug: unfilled OEM string */
-			if (strstr(dev->name, "HP_Mute_LED_P_G")) {
-				set_hp_led_gpio(codec);
-				switch (codec->subsystem_id) {
-				case 0x103c148a:
-					spec->gpio_led_polarity = 0;
-					break;
-				default:
-					spec->gpio_led_polarity = 1;
-					break;
-				}
-				return 1;
-			}
+	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev))) {
+		if (sscanf(dev->name, "HP_Mute_LED_%d_%x",
+			   &spec->gpio_led_polarity,
+			   &spec->gpio_led) == 2) {
+			unsigned int max_gpio;
+			max_gpio = snd_hda_param_read(codec, codec->afg,
+						      AC_PAR_GPIO_CAP);
+			max_gpio &= AC_GPIO_IO_COUNT;
+			if (spec->gpio_led < max_gpio)
+				spec->gpio_led = 1 << spec->gpio_led;
+			else
+				spec->vref_mute_led_nid = spec->gpio_led;
+			return 1;
 		}
-
-		/*
-		 * Fallback case - if we don't find the DMI strings,
-		 * we statically set the GPIO - if not a B-series system
-		 * and default polarity is provided
-		 */
-		if (!hp_blike_system(codec->subsystem_id) &&
-			(default_polarity == 0 || default_polarity == 1)) {
+		if (sscanf(dev->name, "HP_Mute_LED_%d",
+			   &spec->gpio_led_polarity) == 1) {
 			set_hp_led_gpio(codec);
-			spec->gpio_led_polarity = default_polarity;
 			return 1;
 		}
+		/* BIOS bug: unfilled OEM string */
+		if (strstr(dev->name, "HP_Mute_LED_P_G")) {
+			set_hp_led_gpio(codec);
+			switch (codec->subsystem_id) {
+			case 0x103c148a:
+				spec->gpio_led_polarity = 0;
+				break;
+			default:
+				spec->gpio_led_polarity = 1;
+				break;
+			}
+			return 1;
+		}
+	}
+
+	/*
+	 * Fallback case - if we don't find the DMI strings,
+	 * we statically set the GPIO - if not a B-series system
+	 * and default polarity is provided
+	 */
+	if (!hp_blike_system(codec->subsystem_id) &&
+	    (default_polarity == 0 || default_polarity == 1)) {
+		set_hp_led_gpio(codec);
+		spec->gpio_led_polarity = default_polarity;
+		return 1;
 	}
 	return 0;
 }
-- 
1.8.1

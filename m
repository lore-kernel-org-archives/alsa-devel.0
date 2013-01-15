From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/12] ALSA: hda/sigmatel - Move w/a for HP
	Mini 110 LED to fixup table
Date: Tue, 15 Jan 2013 12:09:48 +0100
Message-ID: <1358248189-14166-12-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DAE7C265D7A
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9C5D8A5230
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

Instead of checking the codec SSID in find_mute_led_cfg() for HP Mini
110, set the proper spec->default_polairty in the fixup table.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3368f74..ccad9ad 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2343,6 +2343,8 @@ static const struct snd_pci_quirk stac92hd83xxx_fixup_tbl[] = {
 			  "HP Mini", STAC_92HD83XXX_HP_LED),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x144E,
 			  "HP Pavilion dv5", STAC_92HD83XXX_HP_INV_LED),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x148a,
+		      "HP Mini", STAC_92HD83XXX_HP_LED),
 	SND_PCI_QUIRK_VENDOR(PCI_VENDOR_ID_HP, "HP", STAC_92HD83XXX_HP),
 	{} /* terminator */
 };
@@ -6241,14 +6243,10 @@ static int find_mute_led_cfg(struct hda_codec *codec, int default_polarity)
 		/* BIOS bug: unfilled OEM string */
 		if (strstr(dev->name, "HP_Mute_LED_P_G")) {
 			set_hp_led_gpio(codec);
-			switch (codec->subsystem_id) {
-			case 0x103c148a:
-				spec->gpio_led_polarity = 0;
-				break;
-			default:
+			if (default_polarity >= 0)
+				spec->gpio_led_polarity = default_polarity;
+			else
 				spec->gpio_led_polarity = 1;
-				break;
-			}
 			return 1;
 		}
 	}
-- 
1.8.1

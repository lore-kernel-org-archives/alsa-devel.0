From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: VREF powerdown for headphones.
Date: Thu, 09 Oct 2008 09:32:17 -0400
Message-ID: <48EE07E1.3050003@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 1300F244A1
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 15:32:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Add support for powering down VREF on standard headphone insertion, also
powers up the VREF on a headset insertion.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index b5c1449..2e866e0 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -38,6 +38,7 @@
 #define NUM_CONTROL_ALLOC	32
 #define STAC_PWR_EVENT		0x20
 #define STAC_HP_EVENT		0x30
+#define STAC_VREF_EVENT		0x40

 enum {
 	STAC_REF,
@@ -3811,13 +3812,22 @@ static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
 	struct sigmatel_spec *spec = codec->spec;
 	int idx = res >> 26 & 0x0f;

-	switch ((res >> 26) & 0x30) {
+	switch ((res >> 26) & 0x70) {
 	case STAC_HP_EVENT:
 		stac92xx_hp_detect(codec, res);
 		/* fallthru */
 	case STAC_PWR_EVENT:
 		if (spec->num_pwrs > 0)
 			stac92xx_pin_sense(codec, idx);
+		break;
+	case STAC_VREF_EVENT: {
+		int data = snd_hda_codec_read(codec, codec->afg, 0,
+			AC_VERB_GET_GPIO_DATA, 0);
+		/* toggle VREF state based on GPIOx status */
+		snd_hda_codec_write(codec, codec->afg, 0, 0x7e0,
+			!!(data & (1 << idx)));
+		break;
+		}
 	}
 }

@@ -4318,6 +4328,17 @@ again:
 		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 		break;
 	case 0x111d7608: /* 5 Port with Analog Mixer */
+		switch (codec->subsystem_id) {
+		case 0x103c361a:
+			/* Enable VREF power saving on GPIO1 detect */
+			snd_hda_codec_write(codec, codec->afg, 0,
+				AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
+			snd_hda_codec_write_cache(codec, codec->afg, 0,
+					AC_VERB_SET_UNSOLICITED_ENABLE,
+					(AC_USRSP_EN | STAC_VREF_EVENT | 0x01));
+			spec->gpio_mask |= 0x02;
+			break;
+		}
 		if ((codec->revision_id & 0xf) == 0 ||
 				(codec->revision_id & 0xf) == 1) {
 #ifdef SND_HDA_NEEDS_RESUME

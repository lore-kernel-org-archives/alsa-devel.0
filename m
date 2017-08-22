From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: ice1712: Add support for STAudio ADCIII
Date: Tue, 22 Aug 2017 16:59:18 +0200
Message-ID: <20170822145918.14012-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 461C3266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 16:59:22 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DC2A3AB1E
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:59:21 +0000 (UTC)
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

STAudio ADCIII has the same SSID as Hoontech STDSP24, but requires a
slightly different configuration.  This patch allows user to choose
this model via model=staudio option to set the proper configuration
for the board.

Bugzilla: http://bugzilla.suse.com/show_bug.cgi?id=1048934
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ice1712/hoontech.c | 39 ++++++++++++++++++++++++++++++++++-----
 sound/pci/ice1712/hoontech.h |  1 +
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/sound/pci/ice1712/hoontech.c b/sound/pci/ice1712/hoontech.c
index f37ed0bc203d..fa301d31745b 100644
--- a/sound/pci/ice1712/hoontech.c
+++ b/sound/pci/ice1712/hoontech.c
@@ -166,7 +166,7 @@ static void snd_ice1712_stdsp24_midi2(struct snd_ice1712 *ice, int activate)
 	mutex_unlock(&ice->gpio_mutex);
 }
 
-static int snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
+static int hoontech_init(struct snd_ice1712 *ice, bool staudio)
 {
 	struct hoontech_spec *spec;
 	int box, chn;
@@ -203,7 +203,10 @@ static int snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
 	ICE1712_STDSP24_3_INSEL(spec->boxbits, 0);
 
 	/* let's go - activate only functions in first box */
-	spec->config = 0;
+	if (staudio)
+		spec->config = ICE1712_STDSP24_MUTE;
+	else
+		spec->config = 0;
 			    /* ICE1712_STDSP24_MUTE |
 			       ICE1712_STDSP24_INSEL |
 			       ICE1712_STDSP24_DAREAR; */
@@ -226,9 +229,16 @@ static int snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
 				     ICE1712_STDSP24_BOX_CHN4 |
 				     ICE1712_STDSP24_BOX_MIDI1 |
 				     ICE1712_STDSP24_BOX_MIDI2;
-	spec->boxconfig[1] = 
-	spec->boxconfig[2] = 
-	spec->boxconfig[3] = 0;
+	if (staudio) {
+		spec->boxconfig[1] =
+		spec->boxconfig[2] =
+		spec->boxconfig[3] = spec->boxconfig[0];
+	} else {
+		spec->boxconfig[1] =
+		spec->boxconfig[2] =
+		spec->boxconfig[3] = 0;
+	}
+
 	snd_ice1712_stdsp24_darear(ice,
 		(spec->config & ICE1712_STDSP24_DAREAR) ? 1 : 0);
 	snd_ice1712_stdsp24_mute(ice,
@@ -248,6 +258,16 @@ static int snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
 	return 0;
 }
 
+static int snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
+{
+	return hoontech_init(ice, false);
+}
+
+static int snd_ice1712_staudio_init(struct snd_ice1712 *ice)
+{
+	return hoontech_init(ice, true);
+}
+
 /*
  * AK4524 access
  */
@@ -351,5 +371,14 @@ struct snd_ice1712_card_info snd_ice1712_hoontech_cards[] = {
 		.model = "ez8",
 		.chip_init = snd_ice1712_ez8_init,
 	},
+	{
+		/* STAudio ADCIII has the same SSID as Hoontech StA DSP24,
+		 * thus identified only via the explicit model option
+		 */
+		.subvendor = ICE1712_SUBDEVICE_STAUDIO_ADCIII,	/* a dummy id */
+		.name = "STAudio ADCIII",
+		.model = "staudio",
+		.chip_init = snd_ice1712_staudio_init,
+	},
 	{ } /* terminator */
 };
diff --git a/sound/pci/ice1712/hoontech.h b/sound/pci/ice1712/hoontech.h
index cc1da1e69ad1..7f94943392ce 100644
--- a/sound/pci/ice1712/hoontech.h
+++ b/sound/pci/ice1712/hoontech.h
@@ -34,6 +34,7 @@
 #define ICE1712_SUBDEVICE_STDSP24_VALUE		0x00010010	/* A dummy id for Hoontech SoundTrack Audio DSP 24 Value */
 #define ICE1712_SUBDEVICE_STDSP24_MEDIA7_1	0x16141217	/* Hoontech ST Audio DSP24 Media 7.1 */
 #define ICE1712_SUBDEVICE_EVENT_EZ8		0x00010001	/* A dummy id for EZ8 */
+#define ICE1712_SUBDEVICE_STAUDIO_ADCIII	0x00010002	/* A dummy id for STAudio ADCIII */
 
 extern struct snd_ice1712_card_info snd_ice1712_hoontech_cards[];
 
-- 
2.14.0

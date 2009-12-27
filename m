From: Sergiy Kovalchuk <cnb_zerg@yahoo.com>
Subject: Re: [PATCH 1/1] Added functionality for E-mu
	0404USB/0202USB/TrackerPre
Date: Sun, 27 Dec 2009 09:13:41 -0800 (PST)
Message-ID: <415799.13042.qm@web56104.mail.re3.yahoo.com>
References: <s5hzl57tc5u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n6.bullet.re3.yahoo.com (n6.bullet.re3.yahoo.com
	[68.142.237.91]) by alsa0.perex.cz (Postfix) with SMTP id 4EEE824420
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 18:13:42 +0100 (CET)
In-Reply-To: <s5hzl57tc5u.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

!!! Sorry, previous patch is incorrect !!!

> Thanks for the patch.  Through a quick look, it's
> fine.
> But, could you fix the following and repost?

Summary:
Added functionality for E-mu 0404USB/0202USB/TrackerPre

Added functionality:
1) Extension Units support (all XU settings now available at alsamixer, kmix, etc):
- "AnalogueIn soft limiter" switch;
- "Sample rate" selector (values 0,1,2,3,4,5 corresponds to 44.1 48 ... 192 kHz);
- "DigitalIn CLK source" selector (internal/external) (**);
- "DigitalOut format SPDIF/AC3" switch (**);
(**)E-mu-0404usb only.

2) Automatic device sample rate adjustment depending on substream samplerate for both capture and playback substream.


Signed-off-by: Sergiy Kovalchuk <cnb_zerg@yahoo.com>
---
 sound/usb/usbaudio.c |   47 +++++++++++++++++++++++++++++++
 sound/usb/usbaudio.h |   13 ++++++++
 sound/usb/usbmixer.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 31b63ea..a356dac 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -1271,6 +1271,45 @@ static int init_usb_sample_rate(struct usb_device *dev, int iface,
 }
 
 /*
+ * For E-Mu 0404USB/0202USB/TrackerPre sample rate should be set for device,
+ * not for interface.
+*/
+static void set_format_emu_quirk(struct snd_usb_substream *subs,
+		struct audioformat *fmt)
+{
+	unsigned char emu_samplerate_id = 0;
+
+	/* When capture is active
+	 * sample rate shouldn't be changed
+	 *  by playback substream*/
+	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE].interface != -1)
+			return;
+	}
+
+	switch (fmt->rate_min) {
+	case 48000:
+		emu_samplerate_id = EMU_QUIRK_SR_48000HZ;
+		break;
+	case 88200:
+		emu_samplerate_id = EMU_QUIRK_SR_88200HZ;
+		break;
+	case 96000:
+		emu_samplerate_id = EMU_QUIRK_SR_96000HZ;
+		break;
+	case 176400:
+		emu_samplerate_id = EMU_QUIRK_SR_176400HZ;
+		break;
+	case 192000:
+		emu_samplerate_id = EMU_QUIRK_SR_192000HZ;
+		break;
+	default:
+		emu_samplerate_id = EMU_QUIRK_SR_44100HZ;
+	}
+	snd_emuusb_set_samplerate(subs->stream->chip, emu_samplerate_id);
+}
+
+/*
  * find a matching format and set up the interface
  */
 static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
@@ -1383,6 +1422,14 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 
 	subs->cur_audiofmt = fmt;
 
+	switch (subs->stream->chip->usb_id) {
+	case USB_ID(0x041e, 0x3f02): /* E-Mu 0202 USB */
+	case USB_ID(0x041e, 0x3f04): /* E-Mu 0404 USB */
+	case USB_ID(0x041e, 0x3f0a): /* E-Mu Tracker Pre */
+		set_format_emu_quirk(subs, fmt);
+	break;
+	}
+
 #if 0
 	printk(KERN_DEBUG
 	       "setting done: format = %d, rate = %d..%d, channels = %d\n",
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 9826337..1522167 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -208,6 +208,16 @@ struct snd_usb_midi_endpoint_info {
 /*
  */
 
+/*E-mu USB samplerate control quirk*/
+enum {
+	EMU_QUIRK_SR_44100HZ = 0,
+	EMU_QUIRK_SR_48000HZ,
+	EMU_QUIRK_SR_88200HZ,
+	EMU_QUIRK_SR_96000HZ,
+	EMU_QUIRK_SR_176400HZ,
+	EMU_QUIRK_SR_192000HZ
+};
+
 #define combine_word(s)    ((*(s)) | ((unsigned int)(s)[1] << 8))
 #define combine_triple(s)  (combine_word(s) | ((unsigned int)(s)[2] << 16))
 #define combine_quad(s)    (combine_triple(s) | ((unsigned int)(s)[3] << 24))
@@ -233,6 +243,9 @@ void snd_usbmidi_input_stop(struct list_head* p);
 void snd_usbmidi_input_start(struct list_head* p);
 void snd_usbmidi_disconnect(struct list_head *p);
 
+void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
+			unsigned char samplerate_id);
+
 /*
  * retrieve usb_interface descriptor from the host interface
  * (conditional for compatibility with the older API)
diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index c998220..adcb23b 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -186,6 +186,21 @@ enum {
 	USB_PROC_DCR_RELEASE = 6,
 };
 
+/*E-mu 0202(0404) eXtension Unit(XU) control*/
+enum {
+  USB_XU_CLOCK_RATE 		= 0xe301,
+  USB_XU_CLOCK_SOURCE		= 0xe302,
+  USB_XU_DIGITAL_IO_STATUS	= 0xe303,
+  USB_XU_DEVICE_OPTIONS		= 0xe304,
+  USB_XU_DIRECT_MONITORING	= 0xe305,
+  USB_XU_METERING		= 0xe306
+};
+enum {
+	USB_XU_CLOCK_SOURCE_SELECTOR = 0x02,	/* clock source*/
+	USB_XU_CLOCK_RATE_SELECTOR = 0x03,	/* clock rate */
+	USB_XU_DIGITAL_FORMAT_SELECTOR = 0x01,   /* the spdif format */
+	USB_XU_SOFT_LIMIT_SELECTOR = 0x03 /* soft limiter */
+};
 
 /*
  * manual mapping of mixer names
@@ -1330,7 +1345,32 @@ static struct procunit_info procunits[] = {
 	{ USB_PROC_DCR, "DCR", dcr_proc_info },
 	{ 0 },
 };
-
+/*
+ * predefined data for extension units
+ */
+static struct procunit_value_info clock_rate_xu_info[] = {
+       { USB_XU_CLOCK_RATE_SELECTOR, "Selector", USB_MIXER_U8, 0},
+       { 0 }
+};
+static struct procunit_value_info clock_source_xu_info[] = {
+	{ USB_XU_CLOCK_SOURCE_SELECTOR, "External", USB_MIXER_BOOLEAN},
+	{ 0 }
+};
+static struct procunit_value_info spdif_format_xu_info[] = {
+	{ USB_XU_DIGITAL_FORMAT_SELECTOR, "SPDIF/AC3", USB_MIXER_BOOLEAN},
+	{ 0 }
+};
+static struct procunit_value_info soft_limit_xu_info[] = {
+	{ USB_XU_SOFT_LIMIT_SELECTOR, " ", USB_MIXER_BOOLEAN},
+	{ 0 }
+};
+static struct procunit_info extunits[] = {
+	{ USB_XU_CLOCK_RATE, "Clock rate", clock_rate_xu_info },
+	{ USB_XU_CLOCK_SOURCE, "DigitalIn CLK source", clock_source_xu_info },
+	{ USB_XU_DIGITAL_IO_STATUS, "DigitalOut format:", spdif_format_xu_info },
+	{ USB_XU_DEVICE_OPTIONS, "AnalogueIn Soft Limit", soft_limit_xu_info },
+	{ 0 }
+};
 /*
  * build a processing/extension unit
  */
@@ -1391,8 +1431,17 @@ static int build_audio_procunit(struct mixer_build *state, int unitid, unsigned
 			cval->max = dsc[15];
 			cval->res = 1;
 			cval->initialized = 1;
-		} else
-			get_min_max(cval, valinfo->min_value);
+		} else {
+			if (type == USB_XU_CLOCK_RATE) {
+				/*E-Mu USB 0404/0202/TrackerPre
+				 * samplerate control quirk*/
+				cval->min = 0;
+				cval->max = 5;
+				cval->res = 1;
+				cval->initialized = 1;
+			} else
+				get_min_max(cval, valinfo->min_value);
+		}
 
 		kctl = snd_ctl_new1(&mixer_procunit_ctl, cval);
 		if (! kctl) {
@@ -1433,7 +1482,7 @@ static int parse_audio_processing_unit(struct mixer_build *state, int unitid, un
 
 static int parse_audio_extension_unit(struct mixer_build *state, int unitid, unsigned char *desc)
 {
-	return build_audio_procunit(state, unitid, desc, NULL, "Extension Unit");
+	return build_audio_procunit(state, unitid, desc, extunits, "Extension Unit");
 }
 
 
@@ -2109,6 +2158,24 @@ static int snd_xonar_u1_controls_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
+		unsigned char samplerate_id)
+{
+	 struct usb_mixer_interface *mixer;
+	 struct list_head *p;
+	 struct usb_mixer_elem_info *cval;
+	 int unitid = 12; /*SamleRate ExtensionUnit ID*/
+	 list_for_each(p, &chip->mixer_list) {
+		 mixer = list_entry(p, struct usb_mixer_interface, list);
+		 cval = mixer->id_elems[unitid];
+		 if (cval) {
+			set_cur_ctl_value(cval, cval->control << 8, samplerate_id);
+			snd_usb_mixer_notify_id(mixer, unitid);
+		 }
+		 break;
+	 }
+}
+
 int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 			 int ignore_error)
 {
-- 
1.6.6

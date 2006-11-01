From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] snd_usb_audio: add mixer mapping for Sitecom,
	some cleanup
Date: Wed, 1 Nov 2006 01:58:33 +0100
Message-ID: <20061101005833.GA18171@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello all,

picked up my first USB 5.1 sound card for 3,-(!) Euros at a local fair,
was totally confident that I'd have to do a bit of a hack job on it.

Sound is incredibly good, mixer capabilities are currently
astonishingly poor (no channel-specific volume, ...).

- add mixer mapping for Sitecom USB 5.1 adapter
- constify variables
- fix tons of spelling issues
- explain how to add mixer mappings
- misc.

Patch against 2.6.19-rc3-mm1, compile- and runtime-tested,
should hopefully apply to current ALSA.
I guess there will be some more work soon, but I just want
to see this part out my door.

ToDo items:
- speaker-test shows swapped channels (what the heck??? Similar
  problem for Terratec Aureon 5.1 MKII,
  http://www.linux-club.de/ftopic70435.html)
- figure out where all those additional mixer controls that are
  available in the Windows mixer panel went...
- support USB HID volume hardware buttons on the device

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.19-rc3-mm1.orig/sound/usb/usbaudio.c linux-2.6.19-rc3-mm1/sound/usb/usbaudio.c
--- linux-2.6.19-rc3-mm1.orig/sound/usb/usbaudio.c	2006-11-07 07:58:49.000000000 +0100
+++ linux-2.6.19-rc3-mm1/sound/usb/usbaudio.c	2006-11-08 08:04:57.000000000 +0100
@@ -29,11 +29,11 @@
  *
  *   - async unlink should be used for avoiding the sleep inside lock.
  *     2.4.22 usb-uhci seems buggy for async unlinking and results in
- *     oops.  in such a cse, pass async_unlink=0 option.
+ *     oops.  in such a case, pass async_unlink=0 option.
  *   - the linked URBs would be preferred but not used so far because of
  *     the instability of unlinking.
  *   - type II is not supported properly.  there is no device which supports
- *     this type *correctly*.  SB extigy looks as if it supports, but it's
+ *     this type *correctly*.  SB Extigy looks as if it supports, but it's
  *     indeed an AC3 stream packed in SPDIF frames (i.e. no real AC3 stream).
  */
 
@@ -340,7 +340,7 @@
 /*
  * process after capture complete
  *
- * copy the data from each desctiptor to the pcm buffer, and
+ * copy the data from each descriptor to the pcm buffer, and
  * update the current position.
  */
 static int retire_capture_urb(struct snd_usb_substream *subs,
@@ -1016,7 +1016,7 @@
 }
 
 /*
- * initialize a substream for plaback/capture
+ * initialize a substream for playback/capture
  */
 static int init_substream_urbs(struct snd_usb_substream *subs, unsigned int period_bytes,
 			       unsigned int rate, unsigned int frame_bits)
@@ -1086,7 +1086,7 @@
 	}
 	subs->nurbs = (total_packs + urb_packs - 1) / urb_packs;
 	if (subs->nurbs > MAX_URBS) {
-		/* too much... */
+		/* too many... */
 		subs->nurbs = MAX_URBS;
 		total_packs = MAX_URBS * urb_packs;
 	}
@@ -1236,7 +1236,7 @@
 
 
 /*
- * initialize the picth control and sample rate
+ * initialize the pitch control and sample rate
  */
 static int init_usb_pitch(struct usb_device *dev, int iface,
 			  struct usb_host_interface *alts,
@@ -2106,7 +2106,7 @@
 static void proc_dump_substream_formats(struct snd_usb_substream *subs, struct snd_info_buffer *buffer)
 {
 	struct list_head *p;
-	static char *sync_types[4] = {
+	static const char * const sync_types[4] = {
 		"NONE", "ASYNC", "ADAPTIVE", "SYNC"
 	};
 
@@ -2361,7 +2361,7 @@
 
 /*
  * parse the audio format type I descriptor
- * and returns the corresponding pcm format
+ * and return the corresponding pcm format
  *
  * @dev: usb device
  * @fp: audioformat record
@@ -2442,7 +2442,7 @@
 
 
 /*
- * parse the format descriptor and stores the possible sample rates
+ * parse the format descriptor and store the possible sample rates
  * on the audioformat table.
  *
  * @dev: usb device
@@ -2468,7 +2468,7 @@
 		 */
 		int r, idx, c;
 		/* this table corresponds to the SNDRV_PCM_RATE_XXX bit */
-		static unsigned int conv_rates[] = {
+		static const unsigned int conv_rates[] = {
 			5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000,
 			64000, 88200, 96000, 176400, 192000
 		};
@@ -2590,8 +2590,8 @@
 	if (err < 0)
 		return err;
 #if 1
-	/* FIXME: temporary hack for extigy/audigy 2 nx/zs */
-	/* extigy apparently supports sample rates other than 48k
+	/* FIXME: temporary hack for Extigy/Audigy 2 nx/zs */
+	/* Extigy apparently supports sample rates other than 48k
 	 * but not in ordinary way.  so we enable only 48k atm.
 	 */
 	if (chip->usb_id == USB_ID(0x041e, 0x3000) ||
@@ -3218,7 +3218,7 @@
  * audio-interface quirks
  *
  * returns zero if no standard audio/MIDI parsing is needed.
- * returns a postive value if standard audio/midi interfaces are parsed
+ * returns a positive value if standard audio/midi interfaces are parsed
  * after this.
  * returns a negative value at error.
  */
@@ -3406,10 +3406,10 @@
 /*
  * probe the active usb device
  *
- * note that this can be called multiple times per a device, when it
+ * note that this can be called multiple times per device, when it
  * includes multiple audio control interfaces.
  *
- * thus we check the usb device pointer and creates the card instance
+ * thus we check the usb device pointer and create the card instance
  * only at the first time.  the successive calls of this function will
  * append the pcm interface to the corresponding card.
  */
diff -urN linux-2.6.19-rc3-mm1.orig/sound/usb/usbmixer.c linux-2.6.19-rc3-mm1/sound/usb/usbmixer.c
--- linux-2.6.19-rc3-mm1.orig/sound/usb/usbmixer.c	2006-11-07 07:57:01.000000000 +0100
+++ linux-2.6.19-rc3-mm1/sound/usb/usbmixer.c	2006-11-08 07:49:18.000000000 +0100
@@ -370,7 +370,7 @@
 	return -EINVAL;
 }
 
-static int get_cur_ctl_value(struct usb_mixer_elem_info *cval, int validx, int *value)
+static inline int get_cur_ctl_value(struct usb_mixer_elem_info *cval, int validx, int *value)
 {
 	return get_ctl_value(cval, GET_CUR, validx, value);
 }
@@ -485,9 +485,9 @@
  * get a terminal name string
  */
 
-static struct iterm_name_combo {
+static const struct iterm_name_combo {
 	int type;
-	char *name;
+	const char *name;
 } iterm_names[] = {
 	{ 0x0300, "Output" },
 	{ 0x0301, "Speaker" },
@@ -531,7 +531,7 @@
 static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm,
 			 unsigned char *name, int maxlen, int term_only)
 {
-	struct iterm_name_combo *names;
+	const struct iterm_name_combo *names;
 
 	if (iterm->name)
 		return snd_usb_copy_string_desc(state, iterm->name, name, maxlen);
@@ -638,7 +638,7 @@
 	unsigned int type;	/* control type (mute, volume, etc.) */
 };
 
-static struct usb_feature_control_info audio_feature_info[] = {
+static const struct usb_feature_control_info audio_feature_info[] = {
 	{ "Mute",		USB_MIXER_INV_BOOLEAN },
 	{ "Volume",		USB_MIXER_S16 },
 	{ "Tone Control - Bass",	USB_MIXER_S8 },
@@ -995,7 +995,7 @@
 /*
  * parse a feature unit
  *
- * most of controlls are defined here.
+ * most controls are defined here.
  */
 static int parse_audio_feature_unit(struct mixer_build *state, int unitid, unsigned char *ftr)
 {
diff -urN linux-2.6.19-rc3-mm1.orig/sound/usb/usbmixer_maps.c linux-2.6.19-rc3-mm1/sound/usb/usbmixer_maps.c
--- linux-2.6.19-rc3-mm1.orig/sound/usb/usbmixer_maps.c	2006-11-07 07:57:01.000000000 +0100
+++ linux-2.6.19-rc3-mm1/sound/usb/usbmixer_maps.c	2006-11-08 09:33:34.000000000 +0100
@@ -19,6 +19,21 @@
  *
  */
 
+/*
+ * The purpose of this file is to enable displaying more detailed, precise
+ * names for mixer controls of a specific device than the default, generic
+ * naming.
+ *
+ * Quick intro about adding maps for new devices:
+ * See lsusb -v output, that should quickly show you
+ * the relationship between unit IDs, source IDs, ...
+ * and the topology graphs of other cards here.
+ *
+ * IT = Input Terminal
+ * OT = Output Terminal
+ * FU = Feature Unit
+ * Further unit acronyms: see xxx_UNIT in source.
+ */
 
 struct usbmix_name_map {
 	int id;
@@ -40,7 +55,7 @@
 };
 
 /*
- * USB control mappers for SB Exitigy
+ * USB control mappers for SB Extigy
  */
 
 /*
@@ -223,7 +238,7 @@
 	/* 2: Not present */
 	{ 3, NULL}, /* IT mic (No mic input on device) */
 	/* 4: Not present */
-	/* 5: OT speacker */
+	/* 5: OT speaker */
 	/* 6: OT pcm capture */
 	{ 7, "Master Playback" }, /* Mute/volume for speaker */
 	{ 8, NULL }, /* Capture Switch (No capture inputs on device) */
@@ -234,6 +249,52 @@
 	{ 0 } /* terminator */
 };
 
+/*
+ * Sitecom 5.1 Audio Adapter (round case, USB vendor ID Microdia)
+ *
+ * BIG FIXME!!!
+ * The device-specific Windows mixer panel has additional controls for
+ * channel-specific volume and various filter settings
+ * (stereo -> 5.1 up-sampling, subwoofer cutoff frequency, ...).
+ * I don't have ANY idea whatsoever why such controls don't show up
+ * in default lsusb output. Possibly they're being controlled using
+ * proprietary USB traffic (especially since the manual shows a
+ * prominent notice that while Windows enjoys full support, Mac only
+ * supports stereo sound and doesn't support the two USB HID volume buttons).
+ * We might want to support the HID buttons properly some time, too...
+ *
+ * Topology:
+
+USB_IN[1] ---------------+-+-->MU[15]----->FU[9]---> OT[6]
+                         | |
+            +---->FU[14]-+ |
+            |              |
+Mic_IN[2] --|--+->FU[13]---+
+            |  |
+            |  +->FU[10]-------------+
+            |                        +---->FU[8]---> OT[7]
+Lin_IN[3] --+---->FU[11]-------------+
+ */
+
+static struct usbmix_name_map sitecom_map[] = {
+	/* 1: IT USB */
+	/* 2: IT Mic */
+	/* 3: IT Line */
+	/* 4 */
+	/* 5 */
+	/* 6: OT Speaker */
+	/* 7: OT USB */
+	{ 8, "Capture Source" }, /* SU */
+	{ 9, "Master Playback" }, /* FU */
+	{ 10, "Mic Capture" }, /* FU */
+	{ 11, "Line Capture" }, /* FU */
+	/* 12: IEC958 In Capture */
+	{ 13, "Mic Playback" }, /* FU */
+	{ 14, "Line Playback" }, /* FU */
+	/* 15: MU */
+	{} /* terminator */
+};
+
 /* TerraTec Aureon 5.1 MkII USB */
 static struct usbmix_name_map aureon_51_2_map[] = {
 	/* 1: IT USB */
@@ -297,6 +358,10 @@
 		.map = justlink_map,
 	},
 	{
+		.id = USB_ID(0x0c45, 0x167f),
+		.map = sitecom_map,
+	},
+	{
 		.id = USB_ID(0x0ccd, 0x0028),
 		.map = aureon_51_2_map,
 	},

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

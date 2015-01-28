From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: line6: Tidy up and typo fixes in
	comments
Date: Wed, 28 Jan 2015 17:41:24 +0100
Message-ID: <1422463289-19135-3-git-send-email-tiwai@suse.de>
References: <1422463289-19135-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 14AF726262D
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:41:37 +0100 (CET)
In-Reply-To: <1422463289-19135-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Just reformatting the comments and typos fixed, no functional
changes.  Particularly,
- avoid the kerneldoc marker "/**",
- reduce multiple comment lines into single lines,
- corrected wrongly referred function names

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c   |  2 +-
 sound/usb/line6/driver.h   | 73 ++++++++++++++--------------------------------
 sound/usb/line6/midi.h     | 32 +++++---------------
 sound/usb/line6/pcm.h      | 52 +++++++++------------------------
 sound/usb/line6/pod.c      | 32 +++++---------------
 sound/usb/line6/podhd.c    |  4 +--
 sound/usb/line6/toneport.c | 24 ++++-----------
 sound/usb/line6/variax.c   | 20 ++++---------
 8 files changed, 65 insertions(+), 174 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index a0436993a167..f46da99c44b3 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -44,7 +44,7 @@ static const char line6_request_version[] = {
 	0xf0, 0x7e, 0x7f, 0x06, 0x01, 0xf7
 };
 
-/**
+/*
 	 Class for asynchronous messages.
 */
 struct message {
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index fce10f12f0d3..80d42a0fd889 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -60,26 +60,20 @@ extern const unsigned char line6_midi_id[3];
 static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
 static const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
 
-/**
+/*
 	 Common properties of Line 6 devices.
 */
 struct line6_properties {
-	/**
-		 Card id string (maximum 16 characters).
-		 This can be used to address the device in ALSA programs as
-		 "default:CARD=<id>"
-	*/
+	/* Card id string (maximum 16 characters).
+	 * This can be used to address the device in ALSA programs as
+	 * "default:CARD=<id>"
+	 */
 	const char *id;
 
-	/**
-		 Card short name (maximum 32 characters).
-	*/
+	/* Card short name (maximum 32 characters) */
 	const char *name;
 
-	/**
-		 Bit vector defining this device's capabilities in the
-		 line6usb driver.
-	*/
+	/* Bit vector defining this device's capabilities in line6usb driver */
 	int capabilities;
 
 	int altsetting;
@@ -90,70 +84,47 @@ struct line6_properties {
 	unsigned ep_audio_w;
 };
 
-/**
+/*
 	 Common data shared by all Line 6 devices.
 	 Corresponds to a pair of USB endpoints.
 */
 struct usb_line6 {
-	/**
-		 USB device.
-	*/
+	/* USB device */
 	struct usb_device *usbdev;
 
-	/**
-		 Properties.
-	*/
+	/* Properties */
 	const struct line6_properties *properties;
 
-	/**
-		 Interval (ms).
-	*/
+	/* Interval (ms) */
 	int interval;
 
-	/**
-		 Maximum size of USB packet.
-	*/
+	/* Maximum size of USB packet */
 	int max_packet_size;
 
-	/**
-		 Device representing the USB interface.
-	*/
+	/* Device representing the USB interface */
 	struct device *ifcdev;
 
-	/**
-		 Line 6 sound card data structure.
-		 Each device has at least MIDI or PCM.
-	*/
+	/* Line 6 sound card data structure.
+	 * Each device has at least MIDI or PCM.
+	 */
 	struct snd_card *card;
 
-	/**
-		 Line 6 PCM device data structure.
-	*/
+	/* Line 6 PCM device data structure */
 	struct snd_line6_pcm *line6pcm;
 
-	/**
-		 Line 6 MIDI device data structure.
-	*/
+	/* Line 6 MIDI device data structure */
 	struct snd_line6_midi *line6midi;
 
-	/**
-		 URB for listening to PODxt Pro control endpoint.
-	*/
+	/* URB for listening to PODxt Pro control endpoint */
 	struct urb *urb_listen;
 
-	/**
-		 Buffer for listening to PODxt Pro control endpoint.
-	*/
+	/* Buffer for listening to PODxt Pro control endpoint */
 	unsigned char *buffer_listen;
 
-	/**
-		 Buffer for message to be processed.
-	*/
+	/* Buffer for message to be processed */
 	unsigned char *buffer_message;
 
-	/**
-		 Length of message to be processed.
-	*/
+	/* Length of message to be processed */
 	int message_length;
 
 	void (*process_message)(struct usb_line6 *);
diff --git a/sound/usb/line6/midi.h b/sound/usb/line6/midi.h
index 9d9467b2613c..cf82d69e2747 100644
--- a/sound/usb/line6/midi.h
+++ b/sound/usb/line6/midi.h
@@ -19,44 +19,28 @@
 #define MIDI_BUFFER_SIZE 1024
 
 struct snd_line6_midi {
-	/**
-		 Pointer back to the Line 6 driver data structure.
-	*/
+	/* Pointer back to the Line 6 driver data structure */
 	struct usb_line6 *line6;
 
-	/**
-		 MIDI substream for receiving (or NULL if not active).
-	*/
+	/* MIDI substream for receiving (or NULL if not active) */
 	struct snd_rawmidi_substream *substream_receive;
 
-	/**
-		 MIDI substream for transmitting (or NULL if not active).
-	*/
+	/* MIDI substream for transmitting (or NULL if not active) */
 	struct snd_rawmidi_substream *substream_transmit;
 
-	/**
-		 Number of currently active MIDI send URBs.
-	*/
+	/* Number of currently active MIDI send URBs */
 	int num_active_send_urbs;
 
-	/**
-		 Spin lock to protect MIDI buffer handling.
-	*/
+	/* Spin lock to protect MIDI buffer handling */
 	spinlock_t lock;
 
-	/**
-		 Wait queue for MIDI transmission.
-	*/
+	/* Wait queue for MIDI transmission */
 	wait_queue_head_t send_wait;
 
-	/**
-		 Buffer for incoming MIDI stream.
-	*/
+	/* Buffer for incoming MIDI stream */
 	struct midi_buffer midibuf_in;
 
-	/**
-		 Buffer for outgoing MIDI stream.
-	*/
+	/* Buffer for outgoing MIDI stream */
 	struct midi_buffer midibuf_out;
 };
 
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 42d3e6fc2c61..19c12f0a9008 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -66,8 +66,8 @@
 	the running flag indicates whether the stream is running.
 
 	For monitor or impulse operations, the driver needs to call
-	snd_line6_duplex_acquire() or snd_line6_duplex_release() with the
-	appropriate LINE6_STREAM_* flag.
+	line6_pcm_acquire() or line6_pcm_release() with the appropriate
+	LINE6_STREAM_* flag.
 */
 
 /* stream types */
@@ -139,19 +139,13 @@ struct line6_pcm_stream {
 };
 
 struct snd_line6_pcm {
-	/**
-		 Pointer back to the Line 6 driver data structure.
-	*/
+	/* Pointer back to the Line 6 driver data structure */
 	struct usb_line6 *line6;
 
-	/**
-		 Properties.
-	*/
+	/* Properties. */
 	struct line6_pcm_properties *properties;
 
-	/**
-		 ALSA pcm stream
-	*/
+	/* ALSA pcm stream */
 	struct snd_pcm *pcm;
 
 	/* protection to state changes of in/out streams */
@@ -161,49 +155,31 @@ struct snd_line6_pcm {
 	struct line6_pcm_stream in;
 	struct line6_pcm_stream out;
 
-	/**
-		 Previously captured frame (for software monitoring).
-	*/
+	/* Previously captured frame (for software monitoring) */
 	unsigned char *prev_fbuf;
 
-	/**
-		 Size of previously captured frame (for software monitoring).
-	*/
+	/* Size of previously captured frame (for software monitoring) */
 	int prev_fsize;
 
-	/**
-		 Maximum size of USB packet.
-	*/
+	/* Maximum size of USB packet */
 	int max_packet_size;
 
-	/**
-		 PCM playback volume (left and right).
-	*/
+	/* PCM playback volume (left and right) */
 	int volume_playback[2];
 
-	/**
-		 PCM monitor volume.
-	*/
+	/* PCM monitor volume */
 	int volume_monitor;
 
-	/**
-		 Volume of impulse response test signal (if zero, test is disabled).
-	*/
+	/* Volume of impulse response test signal (if zero, test is disabled) */
 	int impulse_volume;
 
-	/**
-		 Period of impulse response test signal.
-	*/
+	/* Period of impulse response test signal */
 	int impulse_period;
 
-	/**
-		 Counter for impulse response test signal.
-	*/
+	/* Counter for impulse response test signal */
 	int impulse_count;
 
-	/**
-		 Several status bits (see LINE6_FLAG_*).
-	*/
+	/* Several status bits (see LINE6_FLAG_*) */
 	unsigned long flags;
 };
 
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 6f7cd585f2d8..bc20cf141719 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -58,44 +58,28 @@ enum {
 };
 
 struct usb_line6_pod {
-	/**
-		Generic Line 6 USB data.
-	*/
+	/* Generic Line 6 USB data */
 	struct usb_line6 line6;
 
-	/**
-		Instrument monitor level.
-	*/
+	/* Instrument monitor level */
 	int monitor_level;
 
-	/**
-		Timer for device initializaton.
-	*/
+	/* Timer for device initialization */
 	struct timer_list startup_timer;
 
-	/**
-		Work handler for device initializaton.
-	*/
+	/* Work handler for device initialization */
 	struct work_struct startup_work;
 
-	/**
-		Current progress in startup procedure.
-	*/
+	/* Current progress in startup procedure */
 	int startup_progress;
 
-	/**
-		Serial number of device.
-	*/
+	/* Serial number of device */
 	int serial_number;
 
-	/**
-		Firmware version (x 100).
-	*/
+	/* Firmware version (x 100) */
 	int firmware_version;
 
-	/**
-		Device ID.
-	*/
+	/* Device ID */
 	int device_id;
 };
 
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 43c39886597e..c4e83ab33a21 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -27,9 +27,7 @@ enum {
 };
 
 struct usb_line6_podhd {
-	/**
-		Generic Line 6 USB data.
-	*/
+	/* Generic Line 6 USB data */
 	struct usb_line6 line6;
 };
 
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 819e06b3f3db..9024acb2b850 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -43,34 +43,22 @@ struct toneport_led {
 };
 
 struct usb_line6_toneport {
-	/**
-		Generic Line 6 USB data.
-	*/
+	/* Generic Line 6 USB data */
 	struct usb_line6 line6;
 
-	/**
-		Source selector.
-	*/
+	/* Source selector */
 	int source;
 
-	/**
-		Serial number of device.
-	*/
+	/* Serial number of device */
 	int serial_number;
 
-	/**
-		Firmware version (x 100).
-	*/
+	/* Firmware version (x 100) */
 	int firmware_version;
 
-	/**
-		 Timer for delayed PCM startup.
-	*/
+	/* Timer for delayed PCM startup */
 	struct timer_list timer;
 
-	/**
-		 Device type.
-	*/
+	/* Device type */
 	enum line6_device_type type;
 
 	/* LED instances */
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 9701ffa61365..44042cbdef01 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -42,30 +42,20 @@ enum {
 };
 
 struct usb_line6_variax {
-	/**
-		Generic Line 6 USB data.
-	*/
+	/* Generic Line 6 USB data */
 	struct usb_line6 line6;
 
-	/**
-		Buffer for activation code.
-	*/
+	/* Buffer for activation code */
 	unsigned char *buffer_activate;
 
-	/**
-		Handler for device initializaton.
-	*/
+	/* Handler for device initialization */
 	struct work_struct startup_work;
 
-	/**
-		Timers for device initializaton.
-	*/
+	/* Timers for device initialization */
 	struct timer_list startup_timer1;
 	struct timer_list startup_timer2;
 
-	/**
-		Current progress in startup procedure.
-	*/
+	/* Current progress in startup procedure */
 	int startup_progress;
 };
 
-- 
2.2.2

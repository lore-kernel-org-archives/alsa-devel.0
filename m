From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-us428.patch.0.3
Date: Mon, 3 Nov 2003 12:10:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311031210.46564.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2ejp/5ey3cOuo2E"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_2ejp/5ey3cOuo2E
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

please commit this with Comment:
>>>
24Bit in 3Bytes (S24_3LE) support.
<<<

Danke, 
Karsten

--Boundary-00=_2ejp/5ey3cOuo2E
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-us428.patch.0.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-us428.patch.0.3"

Index: alsa-driver/usb/us428/usbus428.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/us428/usbus428.c,v
retrieving revision 1.6
diff -u -r1.6 usbus428.c
--- alsa-driver/usb/us428/usbus428.c	24 Oct 2003 13:58:47 -0000	1.6
+++ alsa-driver/usb/us428/usbus428.c	3 Nov 2003 10:55:22 -0000
@@ -1,6 +1,11 @@
 /*
  * usbus428.c - ALSA USB US-428 Driver
  *
+2003-11-03 Karsten Wiese
+	Version 0.3:
+	24Bit support. 
+	"arecord -D hw:1 -c 2 -r 48000 -M -f S24_3LE|aplay -D hw:1 -c 2 -r 48000 -M -f S24_3LE" works.
+
 2003-08-22 Karsten Wiese
 	Version 0.0.8:
 	Removed EZUSB Firmware. First Stage Firmwaredownload is now done by tascam-firmware downloader.
@@ -75,7 +80,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.2");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.3");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_DEVICES("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001) }}");
@@ -226,18 +231,14 @@
 {
 	int		dev;
 	snd_card_t*	card;
-
 	for (dev = 0; dev < SNDRV_CARDS; ++dev)
 		if (enable[dev] && !snd_us428_card_used[dev])
 			break;
-
 	if (dev >= SNDRV_CARDS)
 		return NULL;
-
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, sizeof(us428dev_t));
 	if (!card)
 		return NULL;
-
 	snd_us428_card_used[us428(card)->chip.index = dev] = 1;
 	card->private_free = snd_us428_card_private_free;
 	us428(card)->chip.dev = device;
@@ -245,7 +246,6 @@
 	init_MUTEX (&us428(card)->open_mutex);
 	INIT_LIST_HEAD(&us428(card)->chip.midi_list);
 	us428(card)->Seq04Complete = 1;
-	us428(card)->stride = 4;		// 16 Bit 
 	strcpy(card->driver, "USB "NAME_ALLCAPS"");
 	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
 	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
@@ -258,25 +258,15 @@
 }
 
 
-static void* snd_us428_usb_probe(struct usb_device* device,
-				 struct usb_interface *intf,
-				 const struct usb_device_id* device_id)
+static void* snd_us428_usb_probe(struct usb_device* device, struct usb_interface *intf, const struct usb_device_id* device_id)
 {
 	int		err;
 	snd_card_t*	card;
-	
-			/* See if the device offered us matches what we can accept */
-	if (device->descriptor.idVendor != 0x1604 || device->descriptor.idProduct != 0x8001)
+	if (device->descriptor.idVendor != 0x1604 || device->descriptor.idProduct != 0x8001 ||
+	    !(card = snd_us428_create_card(device)))
 		return 0;
-
-	if (!(card = snd_us428_create_card(device)))
-		return 0;
-
-	if ((err = snd_usX2Y_hwdep_new(card, device)) < 0) {
-		snd_card_free(card);
-		return 0;
-	}
-	if ((err = snd_card_register(card)) < 0) {
+	if ((err = snd_usX2Y_hwdep_new(card, device)) < 0  ||
+	    (err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return 0;
 	}
@@ -287,8 +277,7 @@
 /*
  * new 2.5 USB kernel API
  */
-static int snd_us428_probe(struct usb_interface *intf,
-			   const struct usb_device_id *id)
+static int snd_us428_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	void *chip;
 	chip = snd_us428_usb_probe(interface_to_usbdev(intf), intf, id);
@@ -308,8 +297,7 @@
 /*
  * 2.4 USB kernel API
  */
-static void *snd_us428_probe(struct usb_device *dev, unsigned int ifnum,
-			     const struct usb_device_id *id)
+static void *snd_us428_probe(struct usb_device *dev, unsigned int ifnum, const struct usb_device_id *id)
 {
 	return snd_us428_usb_probe(dev, usb_ifnum_to_if(dev, ifnum), id);
 }
Index: alsa-driver/usb/us428/usbus428.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/us428/usbus428.h,v
retrieving revision 1.2
diff -u -r1.2 usbus428.h
--- alsa-driver/usb/us428/usbus428.h	24 Sep 2003 16:45:10 -0000	1.2
+++ alsa-driver/usb/us428/usbus428.h	3 Nov 2003 10:55:22 -0000
@@ -14,12 +14,12 @@
 
 #define URBS_AsyncSeq 10
 #define URB_DataLen_AsyncSeq 32
-typedef struct{
+typedef struct {
 	urb_t*	urb[URBS_AsyncSeq];
 	char*   buffer;
 } snd_us428_AsyncSeq_t;
 
-typedef struct{
+typedef struct {
 	int	submitted;
 	int	len;
 	urb_t*	urb[0];
@@ -38,7 +38,8 @@
 	int 			Seq04Complete;
 	wait_queue_head_t	In04WaitQueue;
 	snd_us428_AsyncSeq_t	AS04;
-	int			rate;
+	unsigned int		rate,
+				format;
 	int			refframes;
 	purb_t			play_urb_waiting[2];
 	int			pipe0Aframes[NRURBS][NRPACKS];
Index: alsa-driver/usb/us428/usbus428audio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/us428/usbus428audio.c,v
retrieving revision 1.6
diff -u -r1.6 usbus428audio.c
--- alsa-driver/usb/us428/usbus428audio.c	24 Oct 2003 13:58:47 -0000	1.6
+++ alsa-driver/usb/us428/usbus428audio.c	3 Nov 2003 10:55:24 -0000
@@ -47,6 +47,7 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include "usbus428.h"
 
@@ -153,9 +154,9 @@
 			      struct urb *urb)
 {
 	unsigned long 	flags;
-	unsigned char *	cp;
+	unsigned char	*cp;
 	int 		i, len, lens = 0, hwptr_done = subs->hwptr_done;
-	us428dev_t*	us428 = subs->stream->us428;
+	us428dev_t	*us428 = subs->stream->us428;
 
 	for (i = 0; i < NRPACKS; i++) {
 		cp = (unsigned char*)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
@@ -310,7 +311,7 @@
 #if NRPACKS > 1
 			       + urb->iso_frame_desc[1].actual_length
 #endif
-		               ) / 4; //FIXME !!stride 16 24 Bit!!
+		               ) / subs->stream->us428->stride;
 
 	spin_lock_irqsave(&subs->lock, flags);
 	
@@ -349,7 +350,6 @@
 	snd_pcm_substream_t *substream = subs->pcm_substream;
 	int err;
 
-
 	if (urb->status) {
 		snd_printk("play urb->status = %i\n", urb->status);
 		urb->status = 0;
@@ -390,13 +390,13 @@
 	int err;
 
 	if (urb->status) {
-		snd_printk( "snd_us428_urb_capt_complete(): urb->status = %i\n", urb->status);
+		snd_printk("snd_us428_urb_capt_complete(): urb->status = %i\n", urb->status);
 		urb->status = 0;
 		return;
 	}
 	if (pcm_captsubs && snd_pcm_running(pcm_captsubs))
 		runtime = pcm_captsubs->runtime;
-	if (NULL == runtime){
+	if (NULL == runtime) {
 		snd_us428_substream_t *playsubs = captsubs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK;
 		snd_pcm_substream_t *pcm_playsubs = playsubs->pcm_substream;
 		if (pcm_playsubs && snd_pcm_running(pcm_playsubs))
@@ -592,8 +592,7 @@
 		alive = 0;
 		for (ep = 0; ep < subs->endpoints; ep++)
 			for (i = 0; i < NRURBS; i++) {
-				if (	subs->dataurb[ep][i]
-					&&	subs->dataurb[ep][i]->status)
+				if (subs->dataurb[ep][i] && subs->dataurb[ep][i]->status)
 					alive++;
 			}
 		if (! alive)
@@ -624,11 +623,11 @@
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_printd("snd_us428_pcm_capt_trigger(START )\n");
+		snd_printd("snd_us428_pcm_capt_trigger(START)\n");
 		err = snd_us428_urb_capt_start(subs, substream->runtime);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_printd("snd_us428_pcm_capt_trigger(STOP )\n");
+		snd_printd("snd_us428_pcm_capt_trigger(STOP)\n");
 		err = snd_us428_urbs_deactivate(subs);
 		break;
 	default:
@@ -647,11 +646,11 @@
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_printd("snd_us428_pcm_play_trigger(START )\n");
+		snd_printd("snd_us428_pcm_play_trigger(START)\n");
 		err = snd_us428_urb_play_start(subs, substream->runtime);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_printd("snd_us428_pcm_play_trigger(STOP )\n");
+		snd_printd("snd_us428_pcm_play_trigger(STOP)\n");
 		err = snd_us428_urbs_deactivate(subs);
 		break;
 	default:
@@ -759,10 +758,8 @@
 static int snd_us428_set_format(snd_us428_substream_t *subs, snd_pcm_runtime_t *runtime)
 {
 	struct usb_device *dev = subs->stream->us428->chip.dev;
-
 	snd_printd("about to set format: format = %s, rate = %d, channels = %d\n",
 			   snd_pcm_format_name(runtime->format), runtime->rate, runtime->channels);
-
 	/* create data pipes */
 	if (subs == (subs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK)) {
 		subs->datapipe[0] = usb_sndisocpipe(dev, subs->endpoint[0]);
@@ -772,7 +769,6 @@
 		subs->datapipe[1] = usb_rcvisocpipe(dev, subs->endpoint[1]);
 		subs->maxpacksize = dev->epmaxpacketin[subs->endpoint[0]];
 	}
-
 	return 0;
 }
 
@@ -957,15 +953,31 @@
 static int snd_us428_hw_params(	snd_pcm_substream_t*	substream,
 				snd_pcm_hw_params_t*	hw_params)
 {
-	int			err = 0, rate = params_rate(hw_params);
- 	snd_us428_stream_t*	us428_stream = snd_pcm_substream_chip(substream);
-
+	int			err = 0;
+	unsigned int		rate = params_rate(hw_params),
+				format = params_format(hw_params);
+ 	snd_us428_stream_t	*us428_stream = snd_pcm_substream_chip(substream);
+	if (us428_stream->us428->format != format) {
+		int alternate;
+		if (format == SNDRV_PCM_FORMAT_S24_3LE) {
+			alternate = 2;
+			us428_stream->us428->stride = 6;
+		} else {
+			alternate = 1;
+			us428_stream->us428->stride = 4;
+		}
+		if ((err = usb_set_interface(us428_stream->us428->chip.dev, 0, alternate))) {
+			snd_printk("usb_set_interface error \n");
+			return err;
+		}
+		us428_stream->us428->format = format;
+		us428_stream->us428->rate = 0;
+	}
 	if (us428_stream->us428->rate != rate)
 		err = us428_rate_set(us428_stream, rate);
-
 	if (0 == err) {
 		if (0 > (err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))))
-		snd_printd("snd_pcm_lib_malloc_pages(%x, %i) returned %i\n", substream, params_buffer_bytes(hw_params), err);
+			snd_printd("snd_pcm_lib_malloc_pages(%x, %i) returned %i\n", substream, params_buffer_bytes(hw_params), err);
 	}
 	return err;
 }
@@ -1001,7 +1013,7 @@
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
-	.formats =                 SNDRV_PCM_FMTBIT_S16_LE,
+	.formats =                 SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_3LE,
 	.rates =                   SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
 	.rate_min =                44100,
 	.rate_max =                48000,
@@ -1020,7 +1032,7 @@
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
-	.formats =                 SNDRV_PCM_FMTBIT_S16_LE,
+	.formats =                 SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_3LE,
 	.rates =                   SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
 	.rate_min =                44100,
 	.rate_max =                48000,
@@ -1037,18 +1049,14 @@
 static int snd_usb_pcm_open(snd_pcm_substream_t *substream, int direction,
 			    snd_pcm_hardware_t *hw)
 {
-	snd_us428_stream_t *as = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_us428_substream_t *subs = &as->substream[direction];
+	snd_us428_stream_t	*as = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t	*runtime = substream->runtime;
+	snd_us428_substream_t	*subs = &as->substream[direction];
 
 	runtime->hw = *hw;
-
 	runtime->private_data = subs;
 	subs->pcm_substream = substream;
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-				     1000,
-				     200000);
-
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME, 1000, 200000);
 	return 0;
 }
 

--Boundary-00=_2ejp/5ey3cOuo2E--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

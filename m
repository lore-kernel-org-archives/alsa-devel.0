From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DigiDesign MBox USB Audio device
Date: Tue, 06 Apr 2004 16:20:41 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404061619410.24331-200000@studcom.urz.uni-halle.de>
References: <Pine.HPX.4.33n.0404061037500.17488-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_wfvu7yIK4cmN6+uFCwS0UQ)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.HPX.4.33n.0404061037500.17488-100000@studcom.urz.uni-halle.de>
Content-id: <Pine.HPX.4.33n.0404061620190.24331@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Boettcher <patrick.boettcher@desy.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_wfvu7yIK4cmN6+uFCwS0UQ)
Content-id: <Pine.HPX.4.33n.0404061620191.24331@studcom.urz.uni-halle.de>
Content-type: TEXT/PLAIN; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT

I wrote:
> I think I'll write a quirk for this ...

Please try the attached patch.


HTH
Clemens

--Boundary_(ID_wfvu7yIK4cmN6+uFCwS0UQ)
Content-id: <Pine.HPX.4.33n.0404061620180.24331@studcom.urz.uni-halle.de>
Content-type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=mbox.patch
Content-transfer-encoding: 7BIT
Content-disposition: ATTACHMENT; FILENAME=mbox.patch
Content-description: 

diff -urN alsaold/alsa-kernel/usb/usbaudio.c alsa/alsa-kernel/usb/usbaudio.c
--- alsaold/alsa-kernel/usb/usbaudio.c	Tue Mar 30 13:51:30 2004
+++ alsa/alsa-kernel/usb/usbaudio.c	Tue Apr  6 13:20:36 2004
@@ -2640,6 +2640,7 @@
 	struct audioformat *fp;
 	struct usb_host_interface *alts;
 	int stream, err;
+	int *rate_table = NULL;
 
 	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
 	if (! fp) {
@@ -2647,16 +2648,30 @@
 		return -ENOMEM;
 	}
 	memcpy(fp, quirk->data, sizeof(*fp));
+	if (fp->nr_rates > 0) {
+		rate_table = kmalloc(sizeof(int) * fp->nr_rates, GFP_KERNEL);
+		if (!rate_table) {
+			kfree(fp);
+			return -ENOMEM;
+		}
+		memcpy(rate_table, fp->rate_table, sizeof(int) * fp->nr_rates);
+		fp->rate_table = rate_table;
+	}
+
 	stream = (fp->endpoint & USB_DIR_IN)
 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 	err = add_audio_endpoint(chip, stream, fp);
 	if (err < 0) {
 		kfree(fp);
+		if (rate_table)
+			kfree(rate_table);
 		return err;
 	}
 	if (fp->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
 	    fp->altset_idx >= iface->num_altsetting) {
 		kfree(fp);
+		if (rate_table)
+			kfree(rate_table);
 		return -EINVAL;
 	}
 	alts = &iface->altsetting[fp->altset_idx];
diff -urN alsaold/alsa-kernel/usb/usbquirks.h alsa/alsa-kernel/usb/usbquirks.h
--- alsaold/alsa-kernel/usb/usbquirks.h	Thu Mar 18 21:45:03 2004
+++ alsa/alsa-kernel/usb/usbquirks.h	Tue Apr  6 13:44:07 2004
@@ -838,6 +886,72 @@
 		.product_name = "PHASE 26",
 		.ifnum = 3,
 		.type = QUIRK_MIDI_STANDARD_INTERFACE
+	}
+},
+
+{
+	USB_DEVICE(0x0dba, 0x1000),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Digidesign",
+		.product_name = "MBox",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const snd_usb_audio_quirk_t[]) {
+			{
+				/*
+				 * The MBox has both endpoints in interface 1,
+				 * but we need one interface for each
+				 * direction, so use interface 0 here.
+				 */
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.format = SNDRV_PCM_FORMAT_S24_3BE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x81,
+					.ep_attr = EP_ATTR_ASYNC | 0x01,
+					.maxpacksize = 0x130,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000,
+					.rate_min = 44100,
+					.rate_max = 48000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) {
+						44100, 48000
+					}
+				}
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.format = SNDRV_PCM_FORMAT_S24_3BE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x02,
+					.ep_attr = 0x01,
+					.maxpacksize = 0x130,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000,
+					.rate_min = 44100,
+					.rate_max = 48000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) {
+						44100, 48000
+					}
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
 	}
 },
 

--Boundary_(ID_wfvu7yIK4cmN6+uFCwS0UQ)--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

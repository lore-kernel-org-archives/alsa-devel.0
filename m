From: Bjoern Fay <mail@bfay.de>
Subject: Re: Edirol UA-101 patch ?
Date: Sun, 04 Feb 2007 23:06:52 +0100
Message-ID: <1170626812.3853.31.camel@main.chaos>
References: <1170416804.45c324a4d7044@imp.free.fr>
	<s5hirekjxw6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-g9/cpUuJTgjNFDfkS6o4"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirekjxw6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, balkanboy@free.fr
List-Id: alsa-devel@alsa-project.org


--=-g9/cpUuJTgjNFDfkS6o4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

sorry for the long time, but I was a bit stressed and time was short.

I didn't neither know what the sign-off is good for nor where to put it,
so I put it at the end of the changelog. Hope that's o.k., if not put it
where it belongs or mail me what to do.

The patch is still again the debian source of the 2.6.18 Kernel, hope
that's not a problem.

I also subscribed to the alsa-devel list now.

And as stated the first time, I'm not very familar with software
development, so if there something I could/should do, just mail. I hope
that it will not take so long for my answer/reaction the next time.

If there is someone who has an idea how to manage this playback-sync
problem or how to write a mixer (quirk) for the UA-101 (I think that
it's not so difficult, if you have some knowledge in USB-Mixer for ALSA,
but I can work without it and hence don't want to invest so much time to
work that out alone), I am willing to do some tests or what else is
needed.

Greetings
Bjoern



Am Freitag, den 02.02.2007, 18:02 +0100 schrieb Takashi Iwai:
> At Fri, 02 Feb 2007 12:46:44 +0100,
> balkanboy@free.fr wrote:
> > 
> > Hello,
> > 
> > I browsed the archives of the mailing list and noticed a recent message from
> > Bjoern Fay  about a possible patch for supporting the Edirol UA-101.
> > 
> > Will this patch be released soon and how to get it ?
> 
> The patch looked OK but as I already replied earlier, the following
> things have to be fulfilled:
> 
> - create a unified patch (diff -ru) including all changes in a single
>   patch file
> - provide a proper changelog (summary and description of the patch)
> - sign-off (Signed-off-by: XXX) from the author / submitter
> 
> Bjoern, could you do the above so that I can merge your patch to the
> upstream?
> 
> 
> Takashi
> 

--=-g9/cpUuJTgjNFDfkS6o4
Content-Disposition: attachment; filename=ua-101-changelog.txt
Content-Type: text/plain; name=ua-101-changelog.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

2007-02-04 Bjoern Fay mail@bfay.de
	Added support for the Edirol UA-101 (only in high-speed mode) by taking the quirks for the UA-1000 and change them accordingly. Changes were made in "usbaudio.c", "usbaudio.h", and "usbquirks.h"
	MIDI and recording seem to work perfectly (with JACK), but playback gives some few glitches. I think that's the mentioned synchronizing-problem in the UA-1000 quirk ("FIXME: playback must be synchronized to capture"), so I didn't change that.
	ToDo: Adding Mixer-Support for the built-in control-panel/patch-bay/router.

Signed-off-by: Bjoern Fay


--=-g9/cpUuJTgjNFDfkS6o4
Content-Disposition: attachment; filename=ua-101.patch
Content-Type: text/x-patch; name=ua-101.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -ru linux-source-2.6.18/sound/usb/usbaudio.c linux-my-hack/sound/usb/usbaudio.c
--- linux-source-2.6.18/sound/usb/usbaudio.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-my-hack/sound/usb/usbaudio.c	2006-12-28 22:35:26.000000000 +0100
@@ -3007,6 +3007,59 @@
 	return 0;
 }
 
+/*
+ * Create a stream for an Edirol UA-101 interface.
+ * Copy, paste and modify from Edirol UA-1000
+ */
+static int create_ua101_quirk(struct snd_usb_audio *chip,
+			       struct usb_interface *iface,
+			       const struct snd_usb_audio_quirk *quirk)
+{
+	static const struct audioformat ua101_format = {
+		.format = SNDRV_PCM_FORMAT_S32_LE,
+		.fmt_type = USB_FORMAT_TYPE_I,
+		.altsetting = 1,
+		.altset_idx = 1,
+		.attributes = 0,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+	};
+	struct usb_host_interface *alts;
+	struct usb_interface_descriptor *altsd;
+	struct audioformat *fp;
+	int stream, err;
+
+	if (iface->num_altsetting != 2)
+		return -ENXIO;
+	alts = &iface->altsetting[1];
+	altsd = get_iface_desc(alts);
+	if (alts->extralen != 18 || alts->extra[1] != USB_DT_CS_INTERFACE ||
+	    altsd->bNumEndpoints != 1)
+		return -ENXIO;
+
+	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+	if (!fp)
+		return -ENOMEM;
+	memcpy(fp, &ua101_format, sizeof(*fp));
+
+	fp->channels = alts->extra[11];
+	fp->iface = altsd->bInterfaceNumber;
+	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
+	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
+	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	fp->rate_max = fp->rate_min = combine_triple(&alts->extra[15]);
+
+	stream = (fp->endpoint & USB_DIR_IN)
+		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+	err = add_audio_endpoint(chip, stream, fp);
+	if (err < 0) {
+		kfree(fp);
+		return err;
+	}
+	/* FIXME: playback must be synchronized to capture */
+	usb_set_interface(chip->dev, fp->iface, 0);
+	return 0;
+}
+
 static int snd_usb_create_quirk(struct snd_usb_audio *chip,
 				struct usb_interface *iface,
 				const struct snd_usb_audio_quirk *quirk);
@@ -3188,6 +3241,7 @@
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UA700_UA25] = create_ua700_ua25_quirk,
 		[QUIRK_AUDIO_EDIROL_UA1000] = create_ua1000_quirk,
+		[QUIRK_AUDIO_EDIROL_UA101] = create_ua101_quirk,
 	};
 
 	if (quirk->type < QUIRK_TYPE_COUNT) {
diff -ru linux-source-2.6.18/sound/usb/usbaudio.h linux-my-hack/sound/usb/usbaudio.h
--- linux-source-2.6.18/sound/usb/usbaudio.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-my-hack/sound/usb/usbaudio.h	2006-12-28 17:01:50.000000000 +0100
@@ -159,6 +159,7 @@
 	QUIRK_AUDIO_FIXED_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UA700_UA25,
 	QUIRK_AUDIO_EDIROL_UA1000,
+	QUIRK_AUDIO_EDIROL_UA101,
 
 	QUIRK_TYPE_COUNT
 };
diff -ru linux-source-2.6.18/sound/usb/usbquirks.h linux-my-hack/sound/usb/usbquirks.h
--- linux-source-2.6.18/sound/usb/usbquirks.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-my-hack/sound/usb/usbquirks.h	2006-12-28 22:32:56.000000000 +0100
@@ -1093,7 +1093,37 @@
 		}
 	}
 },
-	/* TODO: add Edirol UA-101 support */
+/* Roland UA-101 in High-Speed Mode only */
+{
+	USB_DEVICE(0x0582, 0x007d),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Roland",
+		.product_name = "UA-101",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_EDIROL_UA101
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_EDIROL_UA101
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const struct snd_usb_midi_endpoint_info) {
+					.out_cables = 0x0001,
+					.in_cables  = 0x0001
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 {
 	/* has ID 0x0081 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0080),

--=-g9/cpUuJTgjNFDfkS6o4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-g9/cpUuJTgjNFDfkS6o4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-g9/cpUuJTgjNFDfkS6o4--

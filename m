From: Bjoern Fay <mail@bfay.de>
Subject: Edirol UA-101 support
Date: Fri, 29 Dec 2006 19:01:36 +0100
Message-ID: <1167415296.3715.48.camel@main.chaos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XiwSVS0Uj2PkIEzGUA9m"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org


--=-XiwSVS0Uj2PkIEzGUA9m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

it's my first try in Kernel development. With copy, paste and modify I
have written a quirk for the Edirol UA-101 from the quirk for the
UA-1000. So far I can use the UA-101, but neither I can access it
through XMMS and the ALSA-plugin, nor do I have a mixer for it. Perhaps
that's just some little change elsewhere, but I don't have the time and
knowledge to do further research. For me it is enough to access the
UA-101 through jackd, which works: 12 capture channels (I don't know
what the last 2 are) and 10 playback channels. And MIDI also works.

I worked with the 2.6.18 Kernel under Debian etch and modified the three
files: usbaudio.c usbaudio.h usbquirks.h

Why there are "!" in the last diffs (at the end) I don't know.

I attach the files to the mail, if that it possible and also copy &
paste it at the end.

If there are any questions or things I should do like sending the files
to someone or so, just say so. As I said I have no experience in writing
kernel driver or anything like this.

I hope the code will be inserted or at least leads to support of the
UA-101 under Linux.

Thanks and kind regards
Bjoern

PS: I'm not in the mailinglist.


*** /usr/src/linux-source-2.6.18/sound/usb/usbaudio.c	2006-09-20
05:42:06.000000000 +0200
--- usbaudio.c	2006-12-28 22:35:26.000000000 +0100
***************
*** 3007,3012 ****
--- 3007,3065 ----
  	return 0;
  }
  
+ /*
+  * Create a stream for an Edirol UA-101 interface.
+  * Copy, paste and modify from Edirol UA-1000
+  */
+ static int create_ua101_quirk(struct snd_usb_audio *chip,
+ 			       struct usb_interface *iface,
+ 			       const struct snd_usb_audio_quirk *quirk)
+ {
+ 	static const struct audioformat ua101_format = {
+ 		.format = SNDRV_PCM_FORMAT_S32_LE,
+ 		.fmt_type = USB_FORMAT_TYPE_I,
+ 		.altsetting = 1,
+ 		.altset_idx = 1,
+ 		.attributes = 0,
+ 		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+ 	};
+ 	struct usb_host_interface *alts;
+ 	struct usb_interface_descriptor *altsd;
+ 	struct audioformat *fp;
+ 	int stream, err;
+ 
+ 	if (iface->num_altsetting != 2)
+ 		return -ENXIO;
+ 	alts = &iface->altsetting[1];
+ 	altsd = get_iface_desc(alts);
+ 	if (alts->extralen != 18 || alts->extra[1] != USB_DT_CS_INTERFACE ||
+ 	    altsd->bNumEndpoints != 1)
+ 		return -ENXIO;
+ 
+ 	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+ 	if (!fp)
+ 		return -ENOMEM;
+ 	memcpy(fp, &ua101_format, sizeof(*fp));
+ 
+ 	fp->channels = alts->extra[11];
+ 	fp->iface = altsd->bInterfaceNumber;
+ 	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
+ 	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
+ 	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+ 	fp->rate_max = fp->rate_min = combine_triple(&alts->extra[15]);
+ 
+ 	stream = (fp->endpoint & USB_DIR_IN)
+ 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+ 	err = add_audio_endpoint(chip, stream, fp);
+ 	if (err < 0) {
+ 		kfree(fp);
+ 		return err;
+ 	}
+ 	/* FIXME: playback must be synchronized to capture */
+ 	usb_set_interface(chip->dev, fp->iface, 0);
+ 	return 0;
+ }
+ 
  static int snd_usb_create_quirk(struct snd_usb_audio *chip,
  				struct usb_interface *iface,
  				const struct snd_usb_audio_quirk *quirk);
***************
*** 3188,3193 ****
--- 3241,3247 ----
  		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
  		[QUIRK_AUDIO_EDIROL_UA700_UA25] = create_ua700_ua25_quirk,
  		[QUIRK_AUDIO_EDIROL_UA1000] = create_ua1000_quirk,
+ 		[QUIRK_AUDIO_EDIROL_UA101] = create_ua101_quirk,
  	};
  
  	if (quirk->type < QUIRK_TYPE_COUNT) {





*** /usr/src/linux-source-2.6.18/sound/usb/usbaudio.h	2006-09-20
05:42:06.000000000 +0200
--- usbaudio.h	2006-12-28 17:01:50.000000000 +0100
***************
*** 159,164 ****
--- 159,165 ----
  	QUIRK_AUDIO_FIXED_ENDPOINT,
  	QUIRK_AUDIO_EDIROL_UA700_UA25,
  	QUIRK_AUDIO_EDIROL_UA1000,
+ 	QUIRK_AUDIO_EDIROL_UA101,
  
  	QUIRK_TYPE_COUNT
  };




*** /usr/src/linux-source-2.6.18/sound/usb/usbquirks.h	2006-09-20
05:42:06.000000000 +0200
--- usbquirks.h	2006-12-28 22:32:56.000000000 +0100
***************
*** 1093,1099 ****
  		}
  	}
  },
! 	/* TODO: add Edirol UA-101 support */
  {
  	/* has ID 0x0081 when not in "Advanced Driver" mode */
  	USB_DEVICE(0x0582, 0x0080),
--- 1093,1129 ----
  		}
  	}
  },
! /* Roland UA-101 in High-Speed Mode only */
! {
! 	USB_DEVICE(0x0582, 0x007d),
! 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
! 		.vendor_name = "Roland",
! 		.product_name = "UA-101",
! 		.ifnum = QUIRK_ANY_INTERFACE,
! 		.type = QUIRK_COMPOSITE,
! 		.data = (const struct snd_usb_audio_quirk[]) {
! 			{
! 				.ifnum = 0,
! 				.type = QUIRK_AUDIO_EDIROL_UA101
! 			},
! 			{
! 				.ifnum = 1,
! 				.type = QUIRK_AUDIO_EDIROL_UA101
! 			},
! 			{
! 				.ifnum = 2,
! 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
! 				.data = & (const struct snd_usb_midi_endpoint_info) {
! 					.out_cables = 0x0001,
! 					.in_cables  = 0x0001
! 				}
! 			},
! 			{
! 				.ifnum = -1
! 			}
! 		}
! 	}
! },
  {
  	/* has ID 0x0081 when not in "Advanced Driver" mode */
  	USB_DEVICE(0x0582, 0x0080),

--=-XiwSVS0Uj2PkIEzGUA9m
Content-Disposition: attachment; filename=usbaudio.c.diff
Content-Type: text/x-patch; name=usbaudio.c.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

*** /usr/src/linux-source-2.6.18/sound/usb/usbaudio.c	2006-09-20 05:42:06.000000000 +0200
--- usbaudio.c	2006-12-28 22:35:26.000000000 +0100
***************
*** 3007,3012 ****
--- 3007,3065 ----
  	return 0;
  }
  
+ /*
+  * Create a stream for an Edirol UA-101 interface.
+  * Copy, paste and modify from Edirol UA-1000
+  */
+ static int create_ua101_quirk(struct snd_usb_audio *chip,
+ 			       struct usb_interface *iface,
+ 			       const struct snd_usb_audio_quirk *quirk)
+ {
+ 	static const struct audioformat ua101_format = {
+ 		.format = SNDRV_PCM_FORMAT_S32_LE,
+ 		.fmt_type = USB_FORMAT_TYPE_I,
+ 		.altsetting = 1,
+ 		.altset_idx = 1,
+ 		.attributes = 0,
+ 		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+ 	};
+ 	struct usb_host_interface *alts;
+ 	struct usb_interface_descriptor *altsd;
+ 	struct audioformat *fp;
+ 	int stream, err;
+ 
+ 	if (iface->num_altsetting != 2)
+ 		return -ENXIO;
+ 	alts = &iface->altsetting[1];
+ 	altsd = get_iface_desc(alts);
+ 	if (alts->extralen != 18 || alts->extra[1] != USB_DT_CS_INTERFACE ||
+ 	    altsd->bNumEndpoints != 1)
+ 		return -ENXIO;
+ 
+ 	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+ 	if (!fp)
+ 		return -ENOMEM;
+ 	memcpy(fp, &ua101_format, sizeof(*fp));
+ 
+ 	fp->channels = alts->extra[11];
+ 	fp->iface = altsd->bInterfaceNumber;
+ 	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
+ 	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
+ 	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+ 	fp->rate_max = fp->rate_min = combine_triple(&alts->extra[15]);
+ 
+ 	stream = (fp->endpoint & USB_DIR_IN)
+ 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+ 	err = add_audio_endpoint(chip, stream, fp);
+ 	if (err < 0) {
+ 		kfree(fp);
+ 		return err;
+ 	}
+ 	/* FIXME: playback must be synchronized to capture */
+ 	usb_set_interface(chip->dev, fp->iface, 0);
+ 	return 0;
+ }
+ 
  static int snd_usb_create_quirk(struct snd_usb_audio *chip,
  				struct usb_interface *iface,
  				const struct snd_usb_audio_quirk *quirk);
***************
*** 3188,3193 ****
--- 3241,3247 ----
  		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
  		[QUIRK_AUDIO_EDIROL_UA700_UA25] = create_ua700_ua25_quirk,
  		[QUIRK_AUDIO_EDIROL_UA1000] = create_ua1000_quirk,
+ 		[QUIRK_AUDIO_EDIROL_UA101] = create_ua101_quirk,
  	};
  
  	if (quirk->type < QUIRK_TYPE_COUNT) {

--=-XiwSVS0Uj2PkIEzGUA9m
Content-Disposition: attachment; filename=usbaudio.h.diff
Content-Type: text/x-patch; name=usbaudio.h.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

*** /usr/src/linux-source-2.6.18/sound/usb/usbaudio.h	2006-09-20 05:42:06.000000000 +0200
--- usbaudio.h	2006-12-28 17:01:50.000000000 +0100
***************
*** 159,164 ****
--- 159,165 ----
  	QUIRK_AUDIO_FIXED_ENDPOINT,
  	QUIRK_AUDIO_EDIROL_UA700_UA25,
  	QUIRK_AUDIO_EDIROL_UA1000,
+ 	QUIRK_AUDIO_EDIROL_UA101,
  
  	QUIRK_TYPE_COUNT
  };

--=-XiwSVS0Uj2PkIEzGUA9m
Content-Disposition: attachment; filename=usbquirks.h.diff
Content-Type: text/x-patch; name=usbquirks.h.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

*** /usr/src/linux-source-2.6.18/sound/usb/usbquirks.h	2006-09-20 05:42:06.000000000 +0200
--- usbquirks.h	2006-12-28 22:32:56.000000000 +0100
***************
*** 1093,1099 ****
  		}
  	}
  },
! 	/* TODO: add Edirol UA-101 support */
  {
  	/* has ID 0x0081 when not in "Advanced Driver" mode */
  	USB_DEVICE(0x0582, 0x0080),
--- 1093,1129 ----
  		}
  	}
  },
! /* Roland UA-101 in High-Speed Mode only */
! {
! 	USB_DEVICE(0x0582, 0x007d),
! 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
! 		.vendor_name = "Roland",
! 		.product_name = "UA-101",
! 		.ifnum = QUIRK_ANY_INTERFACE,
! 		.type = QUIRK_COMPOSITE,
! 		.data = (const struct snd_usb_audio_quirk[]) {
! 			{
! 				.ifnum = 0,
! 				.type = QUIRK_AUDIO_EDIROL_UA101
! 			},
! 			{
! 				.ifnum = 1,
! 				.type = QUIRK_AUDIO_EDIROL_UA101
! 			},
! 			{
! 				.ifnum = 2,
! 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
! 				.data = & (const struct snd_usb_midi_endpoint_info) {
! 					.out_cables = 0x0001,
! 					.in_cables  = 0x0001
! 				}
! 			},
! 			{
! 				.ifnum = -1
! 			}
! 		}
! 	}
! },
  {
  	/* has ID 0x0081 when not in "Advanced Driver" mode */
  	USB_DEVICE(0x0582, 0x0080),

--=-XiwSVS0Uj2PkIEzGUA9m
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-XiwSVS0Uj2PkIEzGUA9m
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-XiwSVS0Uj2PkIEzGUA9m--

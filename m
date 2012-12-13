From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: sound: usb-audio: full capture/playback/spdif
 support for Digidesign Mbox 2
Date: Fri, 14 Dec 2012 01:20:59 +1100
Message-ID: <CABXa2sGwkOSmEXGhZ8123QFsr9T_c=+UzK5fdkZt-OE0CLF40w@mail.gmail.com>
References: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>
 <4CEED787.9050504@gmail.com>
 <AANLkTimjaYMaqA3fFqWKi0+8nsaqENe8oWj=hph1Hv09@mail.gmail.com>
 <s5hfwukp4k4.wl%tiwai@suse.de>
 <AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
 <4CF517BF.4020706@ladisch.de>
 <AANLkTi=Y6tA=1CW6Yu0rpAm7=JyLLjA1A-4cL-JFaBrP@mail.gmail.com>
 <AANLkTimH8OfncsS_WPtXGgFN316YeJQMtEEfkxXmEuQ8@mail.gmail.com>
 <CABXa2sE_WRgCv_Ym9gD2s0bggwBghSUsJhOamSYrNhq80_F8Bw@mail.gmail.com>
 <s5h6246saej.wl%tiwai@suse.de>
 <CABXa2sFRG7fuCnpvOhyhFre_McY7ts6caRUZeHO0didnTow3Sg@mail.gmail.com>
 <s5h4njqdraf.wl%tiwai@suse.de> <s5h38zadqvu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec550b544c1d84904d0bc9f68
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id ABE44261637
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 15:21:00 +0100 (CET)
Received: by mail-ob0-f179.google.com with SMTP id x4so2004893obh.38
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 06:20:59 -0800 (PST)
In-Reply-To: <s5h38zadqvu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

--bcaec550b544c1d84904d0bc9f68
Content-Type: text/plain; charset=ISO-8859-1

Support for Digidesign Mbox 2 USB sound card:

This patch is the result of a lot of trial and error, since there are no specs
available for the device.

Full duplex support is provided, i.e. playback and recording in stereo.
The format is hardcoded at 48000Hz @ 24 bit, which is the maximum that the
device supports.  Also, MIDI in and MIDI out both work.

Users will notice that the S/PDIF light also flashes when playback or recording
is active.  I believe this means that S/PDIF input/output is simultaneously
activated with the analogue i/o during use.
But this particular functionality remains untested.

Note that this particular version of the patch is so far untested on the
physical hardware because I have not compiled a full kernel with the changes.
However, extensive testing has been done by many users of the hardware
who believe other versions of my patch have worked since circa 2009.

Signed-off-by: Damien Zammit <damien@zamaudio.com>

---

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 34b9bb7..45532dd 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2181,6 +2181,11 @@ int snd_usbmidi_create(struct snd_card *card,
 		umidi->usb_protocol_ops = &snd_usbmidi_novation_ops;
 		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
+	case QUIRK_MIDI_MBOX2:
+		/* Digidesign Mbox 2 uses MIDIMAN MIDI protocol */
+		umidi->usb_protocol_ops = &snd_usbmidi_midiman_ops;
+		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
+		break;
 	case QUIRK_MIDI_RAW_BYTES:
 		umidi->usb_protocol_ops = &snd_usbmidi_raw_ops;
 		/*
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 49f9af9..c60eea2 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3078,6 +3078,93 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },

+/* DIGIDESIGN MBOX 2 */
+{
+	USB_DEVICE(0x0dba, 0x3000),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Digidesign",
+		.product_name = "Mbox 2",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
+					.channels = 2,
+					.iface = 2,
+					.altsetting = 2,
+					.altset_idx = 1,
+					.attributes = 0x00,
+					.endpoint = 0x03,
+					.ep_attr = USB_ENDPOINT_SYNC_ASYNC,
+					.maxpacksize = 0x128,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) {
+						48000
+					}
+				}
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 4,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+				.formats = SNDRV_PCM_FMTBIT_S24_3BE,
+					.channels = 2,
+					.iface = 4,
+					.altsetting = 2,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x85,
+					.ep_attr = USB_ENDPOINT_SYNC_SYNC,
+					.maxpacksize = 0x128,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) {
+						48000
+					}
+				}
+			},
+			{
+				.ifnum = 5,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 6,
+				.type = QUIRK_MIDI_MBOX2,
+				.data = &(const struct snd_usb_midi_endpoint_info) {
+					.out_ep =  0x02,
+					.out_cables = 0x0001,
+					.in_ep = 0x81,
+					.in_interval = 0x01,
+					.in_cables = 0x0001
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+
 {
 	/*
 	 * Some USB MIDI devices don't have an audio control interface,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0f58b4b..3510f87 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -306,6 +306,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_YAMAHA] = create_any_midi_quirk,
 		[QUIRK_MIDI_MIDIMAN] = create_any_midi_quirk,
 		[QUIRK_MIDI_NOVATION] = create_any_midi_quirk,
+		[QUIRK_MIDI_MBOX2] = create_any_midi_quirk,
 		[QUIRK_MIDI_RAW_BYTES] = create_any_midi_quirk,
 		[QUIRK_MIDI_EMAGIC] = create_any_midi_quirk,
 		[QUIRK_MIDI_CME] = create_any_midi_quirk,
@@ -655,6 +656,10 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 	case USB_ID(0x0ccd, 0x00b1): /* Terratec Aureon 7.1 USB */
 		return snd_usb_cm6206_boot_quirk(dev);

+	case USB_ID(0x0dba, 0x3000):
+		/* Digidesign Mbox 2 */
+		return snd_usb_mbox2_boot_quirk(dev);
+
 	case USB_ID(0x133e, 0x0815):
 		/* Access Music VirusTI Desktop */
 		return snd_usb_accessmusic_boot_quirk(dev);
@@ -761,6 +766,112 @@ void snd_usb_set_format_quirk(struct
snd_usb_substream *subs,
 	}
 }

+/* Digidesign Mbox 2 needs to load firmware onboard
+ * and driver must wait a few seconds for initialisation.
+ */
+
+#define MBOX2_FIRMWARE_SIZE    646
+#define MBOX2_BOOT_LOADING     0x01 /* Hard coded into the device */
+#define MBOX2_BOOT_READY       0x02 /* Hard coded into the device */
+
+int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
+{
+	struct usb_host_config *config = dev->actconfig;
+	int err;
+	u8 enablemagic[3];
+	u8 bootresponse;
+	u8 temp[12];
+	int fwsize;
+	int count;
+
+	fwsize = le16_to_cpu(get_cfg_desc(config)->wTotalLength);
+
+	if (fwsize == MBOX2_FIRMWARE_SIZE) {
+		snd_printk("Sending Digidesign Mbox 2 boot sequence...\n");
+
+		count = 0;
+		bootresponse = MBOX2_BOOT_LOADING;
+		while ((bootresponse == MBOX2_BOOT_LOADING) && (count < 10)) {
+			mdelay(500); /* 0.5 second delay */
+			snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+				0x85, 0xc0, 0x0001, 0x0000, &bootresponse, 0x0012);
+			if (bootresponse == MBOX2_BOOT_READY)
+				break;
+
+			snd_printk("device not ready, resending boot sequence...\n");
+			count++;
+		}
+
+		if (bootresponse == MBOX2_BOOT_READY) {
+			snd_printk("device initialised!\n");
+
+			err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
+				&dev->descriptor, sizeof(dev->descriptor));
+			config = dev->actconfig;
+			if (err < 0)
+				snd_printdd("error usb_get_descriptor: %d\n", err);
+			err = usb_reset_configuration(dev);
+			if (err < 0)
+				snd_printdd("error usb_reset_configuration: %d\n", err);
+			snd_printdd("mbox2_boot: new boot length = %d\n",
+				le16_to_cpu(get_cfg_desc(config)->wTotalLength));
+
+			/* We want 48 kHz mode for now */
+			enablemagic[0] = 0x80;
+			enablemagic[1] = 0xbb;
+			enablemagic[2] = 0x00;
+
+			/* Send the magic! */
+			snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+				0x01, 0x22, 0x0100, 0x0085, &temp, 0x0003);
+			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				0x81, 0xa2, 0x0100, 0x0085, &enablemagic, 0x0003);
+			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				0x81, 0xa2, 0x0100, 0x0086, &enablemagic, 0x0003);
+			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				0x81, 0xa2, 0x0100, 0x0003, &enablemagic, 0x0003);
+			snd_printk(KERN_INFO "Digidesign Mbox 2: 24 Bit 48kHz Analogue");
+
+			return 0; /* Successful boot */
+		}
+
+		snd_printk("Unknown bootresponse, or timed out, ignoring device:
%d\n", bootresponse);
+		return -ENODEV;
+	}
+	snd_printk("Invalid firmware size: %d\n", fwsize);
+	return -ENODEV;
+}
+
+int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
+					int iface, int altno)
+{
+	u8 srate[3];
+	u8 temp[12];
+
+	/* Reset ifaces 2,4 to 0 altsetting like the Windows driver does */
+	usb_set_interface(chip->dev, iface, 0);
+
+	/* Choose 48000Hz permanently */
+	srate[0] = 0x80;
+	srate[1] = 0xbb;
+	srate[2] = 0x00;
+
+	/* Send the magic! */
+	snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
+		0x01, 0x22, 0x0100, 0x0085, &temp, 0x0003);
+	snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+		0x81, 0xa2, 0x0100, 0x0085, &srate, 0x0003);
+	snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+		0x81, 0xa2, 0x0100, 0x0086, &srate, 0x0003);
+	snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+		0x81, 0xa2, 0x0100, 0x0003, &srate, 0x0003);
+
+	if (altno != 3)
+		return 1;
+
+	return 0;
+}
+
 void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 {
 	/*
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 0ca9e91..087a5b6 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -24,6 +24,11 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 int snd_usb_is_big_endian_format(struct snd_usb_audio *chip,
 				 struct audioformat *fp);

+int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
+				    int iface, int altno);
+
+int snd_usb_mbox2_boot_quirk(struct usb_device *dev);
+
 void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep);

 void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 1ac3fd9..a8172c1 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -76,6 +76,7 @@ enum quirk_type {
 	QUIRK_MIDI_YAMAHA,
 	QUIRK_MIDI_MIDIMAN,
 	QUIRK_MIDI_NOVATION,
+	QUIRK_MIDI_MBOX2,
 	QUIRK_MIDI_RAW_BYTES,
 	QUIRK_MIDI_EMAGIC,
 	QUIRK_MIDI_CME,

--bcaec550b544c1d84904d0bc9f68
Content-Type: text/plain; charset=US-ASCII; name="patch_for-next_dz2.txt"
Content-Disposition: attachment; filename="patch_for-next_dz2.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hanz4x1v0

U3VwcG9ydCBmb3IgRGlnaWRlc2lnbiBNYm94IDIgVVNCIHNvdW5kIGNhcmQ6CgpUaGlzIHBhdGNo
IGlzIHRoZSByZXN1bHQgb2YgYSBsb3Qgb2YgdHJpYWwgYW5kIGVycm9yLCBzaW5jZSB0aGVyZSBh
cmUgbm8gc3BlY3MKYXZhaWxhYmxlIGZvciB0aGUgZGV2aWNlLgoKRnVsbCBkdXBsZXggc3VwcG9y
dCBpcyBwcm92aWRlZCwgaS5lLiBwbGF5YmFjayBhbmQgcmVjb3JkaW5nIGluIHN0ZXJlby4KVGhl
IGZvcm1hdCBpcyBoYXJkY29kZWQgYXQgNDgwMDBIeiBAIDI0IGJpdCwgd2hpY2ggaXMgdGhlIG1h
eGltdW0gdGhhdCB0aGUKZGV2aWNlIHN1cHBvcnRzLiAgQWxzbywgTUlESSBpbiBhbmQgTUlESSBv
dXQgYm90aCB3b3JrLgoKVXNlcnMgd2lsbCBub3RpY2UgdGhhdCB0aGUgUy9QRElGIGxpZ2h0IGFs
c28gZmxhc2hlcyB3aGVuIHBsYXliYWNrIG9yIHJlY29yZGluZwppcyBhY3RpdmUuICBJIGJlbGll
dmUgdGhpcyBtZWFucyB0aGF0IFMvUERJRiBpbnB1dC9vdXRwdXQgaXMgc2ltdWx0YW5lb3VzbHkK
YWN0aXZhdGVkIHdpdGggdGhlIGFuYWxvZ3VlIGkvbyBkdXJpbmcgdXNlLgpCdXQgdGhpcyBwYXJ0
aWN1bGFyIGZ1bmN0aW9uYWxpdHkgcmVtYWlucyB1bnRlc3RlZC4KCk5vdGUgdGhhdCB0aGlzIHBh
cnRpY3VsYXIgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggaXMgc28gZmFyIHVudGVzdGVkIG9uIHRoZSAK
cGh5c2ljYWwgaGFyZHdhcmUgYmVjYXVzZSBJIGhhdmUgbm90IGNvbXBpbGVkIGEgZnVsbCBrZXJu
ZWwgd2l0aCB0aGUgY2hhbmdlcy4KSG93ZXZlciwgZXh0ZW5zaXZlIHRlc3RpbmcgaGFzIGJlZW4g
ZG9uZSBieSBtYW55IHVzZXJzIG9mIHRoZSBoYXJkd2FyZQp3aG8gYmVsaWV2ZSBvdGhlciB2ZXJz
aW9ucyBvZiBteSBwYXRjaCBoYXZlIHdvcmtlZCBzaW5jZSBjaXJjYSAyMDA5LgoKU2lnbmVkLW9m
Zi1ieTogRGFtaWVuIFphbW1pdCA8ZGFtaWVuQHphbWF1ZGlvLmNvbT4KCi0tLQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3VzYi9taWRpLmMgYi9zb3VuZC91c2IvbWlkaS5jCmluZGV4IDM0YjliYjcuLjQ1
NTMyZGQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3VzYi9taWRpLmMKKysrIGIvc291bmQvdXNiL21pZGku
YwpAQCAtMjE4MSw2ICsyMTgxLDExIEBAIGludCBzbmRfdXNibWlkaV9jcmVhdGUoc3RydWN0IHNu
ZF9jYXJkICpjYXJkLAogCQl1bWlkaS0+dXNiX3Byb3RvY29sX29wcyA9ICZzbmRfdXNibWlkaV9u
b3ZhdGlvbl9vcHM7CiAJCWVyciA9IHNuZF91c2JtaWRpX2RldGVjdF9wZXJfcG9ydF9lbmRwb2lu
dHModW1pZGksIGVuZHBvaW50cyk7CiAJCWJyZWFrOworCWNhc2UgUVVJUktfTUlESV9NQk9YMjoK
KwkJLyogRGlnaWRlc2lnbiBNYm94IDIgdXNlcyBNSURJTUFOIE1JREkgcHJvdG9jb2wgKi8KKwkJ
dW1pZGktPnVzYl9wcm90b2NvbF9vcHMgPSAmc25kX3VzYm1pZGlfbWlkaW1hbl9vcHM7CisJCWVy
ciA9IHNuZF91c2JtaWRpX2RldGVjdF9wZXJfcG9ydF9lbmRwb2ludHModW1pZGksIGVuZHBvaW50
cyk7CisJCWJyZWFrOwogCWNhc2UgUVVJUktfTUlESV9SQVdfQllURVM6CiAJCXVtaWRpLT51c2Jf
cHJvdG9jb2xfb3BzID0gJnNuZF91c2JtaWRpX3Jhd19vcHM7CiAJCS8qCmRpZmYgLS1naXQgYS9z
b3VuZC91c2IvcXVpcmtzLXRhYmxlLmggYi9zb3VuZC91c2IvcXVpcmtzLXRhYmxlLmgKaW5kZXgg
NDlmOWFmOS4uYzYwZWVhMiAxMDA2NDQKLS0tIGEvc291bmQvdXNiL3F1aXJrcy10YWJsZS5oCisr
KyBiL3NvdW5kL3VzYi9xdWlya3MtdGFibGUuaApAQCAtMzA3OCw2ICszMDc4LDkzIEBAIFlBTUFI
QV9ERVZJQ0UoMHg3MDEwLCAiVUI5OSIpLAogCX0KIH0sCiAKKy8qIERJR0lERVNJR04gTUJPWCAy
ICovCit7CisJVVNCX0RFVklDRSgweDBkYmEsIDB4MzAwMCksCisJLmRyaXZlcl9pbmZvID0gKHVu
c2lnbmVkIGxvbmcpICYoY29uc3Qgc3RydWN0IHNuZF91c2JfYXVkaW9fcXVpcmspIHsKKwkJLnZl
bmRvcl9uYW1lID0gIkRpZ2lkZXNpZ24iLAorCQkucHJvZHVjdF9uYW1lID0gIk1ib3ggMiIsCisJ
CS5pZm51bSA9IFFVSVJLX0FOWV9JTlRFUkZBQ0UsCisJCS50eXBlID0gUVVJUktfQ09NUE9TSVRF
LAorCQkuZGF0YSA9IChjb25zdCBzdHJ1Y3Qgc25kX3VzYl9hdWRpb19xdWlya1tdKSB7CisJCQl7
CisJCQkJLmlmbnVtID0gMCwKKwkJCQkudHlwZSA9IFFVSVJLX0lHTk9SRV9JTlRFUkZBQ0UKKwkJ
CX0sCisJCQl7CisJCQkJLmlmbnVtID0gMSwKKwkJCQkudHlwZSA9IFFVSVJLX0lHTk9SRV9JTlRF
UkZBQ0UKKwkJCX0sCisJCQl7CisJCQkJLmlmbnVtID0gMiwKKwkJCQkudHlwZSA9IFFVSVJLX0FV
RElPX0ZJWEVEX0VORFBPSU5ULAorCQkJCS5kYXRhID0gJihjb25zdCBzdHJ1Y3QgYXVkaW9mb3Jt
YXQpIHsKKwkJCQkJLmZvcm1hdHMgPSBTTkRSVl9QQ01fRk1UQklUX1MyNF8zQkUsCisJCQkJCS5j
aGFubmVscyA9IDIsCisJCQkJCS5pZmFjZSA9IDIsCisJCQkJCS5hbHRzZXR0aW5nID0gMiwKKwkJ
CQkJLmFsdHNldF9pZHggPSAxLAorCQkJCQkuYXR0cmlidXRlcyA9IDB4MDAsCisJCQkJCS5lbmRw
b2ludCA9IDB4MDMsCisJCQkJCS5lcF9hdHRyID0gVVNCX0VORFBPSU5UX1NZTkNfQVNZTkMsCisJ
CQkJCS5tYXhwYWNrc2l6ZSA9IDB4MTI4LAorCQkJCQkucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV80
ODAwMCwKKwkJCQkJLnJhdGVfbWluID0gNDgwMDAsCisJCQkJCS5yYXRlX21heCA9IDQ4MDAwLAor
CQkJCQkubnJfcmF0ZXMgPSAxLAorCQkJCQkucmF0ZV90YWJsZSA9ICh1bnNpZ25lZCBpbnRbXSkg
eworCQkJCQkJNDgwMDAKKwkJCQkJfQorCQkJCX0KKwkJCX0sCisJCQl7CisJCQkJLmlmbnVtID0g
MywKKwkJCQkudHlwZSA9IFFVSVJLX0lHTk9SRV9JTlRFUkZBQ0UKKwkJCX0sCisJCQl7CisJCQkJ
LmlmbnVtID0gNCwKKwkJCQkudHlwZSA9IFFVSVJLX0FVRElPX0ZJWEVEX0VORFBPSU5ULAorCQkJ
CS5kYXRhID0gJihjb25zdCBzdHJ1Y3QgYXVkaW9mb3JtYXQpIHsKKwkJCQkuZm9ybWF0cyA9IFNO
RFJWX1BDTV9GTVRCSVRfUzI0XzNCRSwKKwkJCQkJLmNoYW5uZWxzID0gMiwKKwkJCQkJLmlmYWNl
ID0gNCwKKwkJCQkJLmFsdHNldHRpbmcgPSAyLAorCQkJCQkuYWx0c2V0X2lkeCA9IDEsCisJCQkJ
CS5hdHRyaWJ1dGVzID0gVUFDX0VQX0NTX0FUVFJfU0FNUExFX1JBVEUsCisJCQkJCS5lbmRwb2lu
dCA9IDB4ODUsCisJCQkJCS5lcF9hdHRyID0gVVNCX0VORFBPSU5UX1NZTkNfU1lOQywKKwkJCQkJ
Lm1heHBhY2tzaXplID0gMHgxMjgsCisJCQkJCS5yYXRlcyA9IFNORFJWX1BDTV9SQVRFXzQ4MDAw
LAorCQkJCQkucmF0ZV9taW4gPSA0ODAwMCwKKwkJCQkJLnJhdGVfbWF4ID0gNDgwMDAsCisJCQkJ
CS5ucl9yYXRlcyA9IDEsCisJCQkJCS5yYXRlX3RhYmxlID0gKHVuc2lnbmVkIGludFtdKSB7CisJ
CQkJCQk0ODAwMAorCQkJCQl9CisJCQkJfQorCQkJfSwKKwkJCXsKKwkJCQkuaWZudW0gPSA1LAor
CQkJCS50eXBlID0gUVVJUktfSUdOT1JFX0lOVEVSRkFDRQorCQkJfSwKKwkJCXsKKwkJCQkuaWZu
dW0gPSA2LAorCQkJCS50eXBlID0gUVVJUktfTUlESV9NQk9YMiwKKwkJCQkuZGF0YSA9ICYoY29u
c3Qgc3RydWN0IHNuZF91c2JfbWlkaV9lbmRwb2ludF9pbmZvKSB7CisJCQkJCS5vdXRfZXAgPSAg
MHgwMiwKKwkJCQkJLm91dF9jYWJsZXMgPSAweDAwMDEsCisJCQkJCS5pbl9lcCA9IDB4ODEsCisJ
CQkJCS5pbl9pbnRlcnZhbCA9IDB4MDEsCisJCQkJCS5pbl9jYWJsZXMgPSAweDAwMDEKKwkJCQl9
CisJCQl9LAorCQkJeworCQkJCS5pZm51bSA9IC0xCisJCQl9CisJCX0KKwl9Cit9LAorCiB7CiAJ
LyoKIAkgKiBTb21lIFVTQiBNSURJIGRldmljZXMgZG9uJ3QgaGF2ZSBhbiBhdWRpbyBjb250cm9s
IGludGVyZmFjZSwKZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MuYyBiL3NvdW5kL3VzYi9x
dWlya3MuYwppbmRleCAwZjU4YjRiLi4zNTEwZjg3IDEwMDY0NAotLS0gYS9zb3VuZC91c2IvcXVp
cmtzLmMKKysrIGIvc291bmQvdXNiL3F1aXJrcy5jCkBAIC0zMDYsNiArMzA2LDcgQEAgaW50IHNu
ZF91c2JfY3JlYXRlX3F1aXJrKHN0cnVjdCBzbmRfdXNiX2F1ZGlvICpjaGlwLAogCQlbUVVJUktf
TUlESV9ZQU1BSEFdID0gY3JlYXRlX2FueV9taWRpX3F1aXJrLAogCQlbUVVJUktfTUlESV9NSURJ
TUFOXSA9IGNyZWF0ZV9hbnlfbWlkaV9xdWlyaywKIAkJW1FVSVJLX01JRElfTk9WQVRJT05dID0g
Y3JlYXRlX2FueV9taWRpX3F1aXJrLAorCQlbUVVJUktfTUlESV9NQk9YMl0gPSBjcmVhdGVfYW55
X21pZGlfcXVpcmssCiAJCVtRVUlSS19NSURJX1JBV19CWVRFU10gPSBjcmVhdGVfYW55X21pZGlf
cXVpcmssCiAJCVtRVUlSS19NSURJX0VNQUdJQ10gPSBjcmVhdGVfYW55X21pZGlfcXVpcmssCiAJ
CVtRVUlSS19NSURJX0NNRV0gPSBjcmVhdGVfYW55X21pZGlfcXVpcmssCkBAIC02NTUsNiArNjU2
LDEwIEBAIGludCBzbmRfdXNiX2FwcGx5X2Jvb3RfcXVpcmsoc3RydWN0IHVzYl9kZXZpY2UgKmRl
diwKIAljYXNlIFVTQl9JRCgweDBjY2QsIDB4MDBiMSk6IC8qIFRlcnJhdGVjIEF1cmVvbiA3LjEg
VVNCICovCiAJCXJldHVybiBzbmRfdXNiX2NtNjIwNl9ib290X3F1aXJrKGRldik7CiAKKwljYXNl
IFVTQl9JRCgweDBkYmEsIDB4MzAwMCk6CisJCS8qIERpZ2lkZXNpZ24gTWJveCAyICovCisJCXJl
dHVybiBzbmRfdXNiX21ib3gyX2Jvb3RfcXVpcmsoZGV2KTsKKwogCWNhc2UgVVNCX0lEKDB4MTMz
ZSwgMHgwODE1KToKIAkJLyogQWNjZXNzIE11c2ljIFZpcnVzVEkgRGVza3RvcCAqLwogCQlyZXR1
cm4gc25kX3VzYl9hY2Nlc3NtdXNpY19ib290X3F1aXJrKGRldik7CkBAIC03NjEsNiArNzY2LDEx
MiBAQCB2b2lkIHNuZF91c2Jfc2V0X2Zvcm1hdF9xdWlyayhzdHJ1Y3Qgc25kX3VzYl9zdWJzdHJl
YW0gKnN1YnMsCiAJfQogfQogCisvKiBEaWdpZGVzaWduIE1ib3ggMiBuZWVkcyB0byBsb2FkIGZp
cm13YXJlIG9uYm9hcmQKKyAqIGFuZCBkcml2ZXIgbXVzdCB3YWl0IGEgZmV3IHNlY29uZHMgZm9y
IGluaXRpYWxpc2F0aW9uLgorICovCisKKyNkZWZpbmUgTUJPWDJfRklSTVdBUkVfU0laRSAgICA2
NDYKKyNkZWZpbmUgTUJPWDJfQk9PVF9MT0FESU5HICAgICAweDAxIC8qIEhhcmQgY29kZWQgaW50
byB0aGUgZGV2aWNlICovCisjZGVmaW5lIE1CT1gyX0JPT1RfUkVBRFkgICAgICAgMHgwMiAvKiBI
YXJkIGNvZGVkIGludG8gdGhlIGRldmljZSAqLworCitpbnQgc25kX3VzYl9tYm94Ml9ib290X3F1
aXJrKHN0cnVjdCB1c2JfZGV2aWNlICpkZXYpCit7CisJc3RydWN0IHVzYl9ob3N0X2NvbmZpZyAq
Y29uZmlnID0gZGV2LT5hY3Rjb25maWc7CisJaW50IGVycjsKKwl1OCBlbmFibGVtYWdpY1szXTsK
Kwl1OCBib290cmVzcG9uc2U7CisJdTggdGVtcFsxMl07CisJaW50IGZ3c2l6ZTsKKwlpbnQgY291
bnQ7CisKKwlmd3NpemUgPSBsZTE2X3RvX2NwdShnZXRfY2ZnX2Rlc2MoY29uZmlnKS0+d1RvdGFs
TGVuZ3RoKTsKKworCWlmIChmd3NpemUgPT0gTUJPWDJfRklSTVdBUkVfU0laRSkgeworCQlzbmRf
cHJpbnRrKCJTZW5kaW5nIERpZ2lkZXNpZ24gTWJveCAyIGJvb3Qgc2VxdWVuY2UuLi5cbiIpOwor
CisJCWNvdW50ID0gMDsKKwkJYm9vdHJlc3BvbnNlID0gTUJPWDJfQk9PVF9MT0FESU5HOworCQl3
aGlsZSAoKGJvb3RyZXNwb25zZSA9PSBNQk9YMl9CT09UX0xPQURJTkcpICYmIChjb3VudCA8IDEw
KSkgeworCQkJbWRlbGF5KDUwMCk7IC8qIDAuNSBzZWNvbmQgZGVsYXkgKi8KKwkJCXNuZF91c2Jf
Y3RsX21zZyhkZXYsIHVzYl9yY3ZjdHJscGlwZShkZXYsIDApLAorCQkJCTB4ODUsIDB4YzAsIDB4
MDAwMSwgMHgwMDAwLCAmYm9vdHJlc3BvbnNlLCAweDAwMTIpOworCQkJaWYgKGJvb3RyZXNwb25z
ZSA9PSBNQk9YMl9CT09UX1JFQURZKQorCQkJCWJyZWFrOworCisJCQlzbmRfcHJpbnRrKCJkZXZp
Y2Ugbm90IHJlYWR5LCByZXNlbmRpbmcgYm9vdCBzZXF1ZW5jZS4uLlxuIik7CisJCQljb3VudCsr
OworCQl9CisKKwkJaWYgKGJvb3RyZXNwb25zZSA9PSBNQk9YMl9CT09UX1JFQURZKSB7CisJCQlz
bmRfcHJpbnRrKCJkZXZpY2UgaW5pdGlhbGlzZWQhXG4iKTsKKworCQkJZXJyID0gdXNiX2dldF9k
ZXNjcmlwdG9yKGRldiwgVVNCX0RUX0RFVklDRSwgMCwKKwkJCQkmZGV2LT5kZXNjcmlwdG9yLCBz
aXplb2YoZGV2LT5kZXNjcmlwdG9yKSk7CisJCQljb25maWcgPSBkZXYtPmFjdGNvbmZpZzsKKwkJ
CWlmIChlcnIgPCAwKQorCQkJCXNuZF9wcmludGRkKCJlcnJvciB1c2JfZ2V0X2Rlc2NyaXB0b3I6
ICVkXG4iLCBlcnIpOworCQkJZXJyID0gdXNiX3Jlc2V0X2NvbmZpZ3VyYXRpb24oZGV2KTsKKwkJ
CWlmIChlcnIgPCAwKQorCQkJCXNuZF9wcmludGRkKCJlcnJvciB1c2JfcmVzZXRfY29uZmlndXJh
dGlvbjogJWRcbiIsIGVycik7CisJCQlzbmRfcHJpbnRkZCgibWJveDJfYm9vdDogbmV3IGJvb3Qg
bGVuZ3RoID0gJWRcbiIsCisJCQkJbGUxNl90b19jcHUoZ2V0X2NmZ19kZXNjKGNvbmZpZyktPndU
b3RhbExlbmd0aCkpOworCisJCQkvKiBXZSB3YW50IDQ4IGtIeiBtb2RlIGZvciBub3cgKi8KKwkJ
CWVuYWJsZW1hZ2ljWzBdID0gMHg4MDsKKwkJCWVuYWJsZW1hZ2ljWzFdID0gMHhiYjsKKwkJCWVu
YWJsZW1hZ2ljWzJdID0gMHgwMDsKKworCQkJLyogU2VuZCB0aGUgbWFnaWMhICovCisJCQlzbmRf
dXNiX2N0bF9tc2coZGV2LCB1c2JfcmN2Y3RybHBpcGUoZGV2LCAwKSwKKwkJCQkweDAxLCAweDIy
LCAweDAxMDAsIDB4MDA4NSwgJnRlbXAsIDB4MDAwMyk7CisJCQlzbmRfdXNiX2N0bF9tc2coZGV2
LCB1c2Jfc25kY3RybHBpcGUoZGV2LCAwKSwKKwkJCQkweDgxLCAweGEyLCAweDAxMDAsIDB4MDA4
NSwgJmVuYWJsZW1hZ2ljLCAweDAwMDMpOworCQkJc25kX3VzYl9jdGxfbXNnKGRldiwgdXNiX3Nu
ZGN0cmxwaXBlKGRldiwgMCksCisJCQkJMHg4MSwgMHhhMiwgMHgwMTAwLCAweDAwODYsICZlbmFi
bGVtYWdpYywgMHgwMDAzKTsKKwkJCXNuZF91c2JfY3RsX21zZyhkZXYsIHVzYl9zbmRjdHJscGlw
ZShkZXYsIDApLAorCQkJCTB4ODEsIDB4YTIsIDB4MDEwMCwgMHgwMDAzLCAmZW5hYmxlbWFnaWMs
IDB4MDAwMyk7CisJCQlzbmRfcHJpbnRrKEtFUk5fSU5GTyAiRGlnaWRlc2lnbiBNYm94IDI6IDI0
IEJpdCA0OGtIeiBBbmFsb2d1ZSIpOworCisJCQlyZXR1cm4gMDsgLyogU3VjY2Vzc2Z1bCBib290
ICovCisJCX0KKworCQlzbmRfcHJpbnRrKCJVbmtub3duIGJvb3RyZXNwb25zZSwgb3IgdGltZWQg
b3V0LCBpZ25vcmluZyBkZXZpY2U6ICVkXG4iLCBib290cmVzcG9uc2UpOworCQlyZXR1cm4gLUVO
T0RFVjsKKwl9CisJc25kX3ByaW50aygiSW52YWxpZCBmaXJtd2FyZSBzaXplOiAlZFxuIiwgZndz
aXplKTsKKwlyZXR1cm4gLUVOT0RFVjsKK30KKworaW50IG1ib3gyX3NraXBfc2V0dGluZ19xdWly
ayhzdHJ1Y3Qgc25kX3VzYl9hdWRpbyAqY2hpcCwKKwkJCQkJaW50IGlmYWNlLCBpbnQgYWx0bm8p
Cit7CisJdTggc3JhdGVbM107CisJdTggdGVtcFsxMl07CisKKwkvKiBSZXNldCBpZmFjZXMgMiw0
IHRvIDAgYWx0c2V0dGluZyBsaWtlIHRoZSBXaW5kb3dzIGRyaXZlciBkb2VzICovCisJdXNiX3Nl
dF9pbnRlcmZhY2UoY2hpcC0+ZGV2LCBpZmFjZSwgMCk7CisKKwkvKiBDaG9vc2UgNDgwMDBIeiBw
ZXJtYW5lbnRseSAqLworCXNyYXRlWzBdID0gMHg4MDsKKwlzcmF0ZVsxXSA9IDB4YmI7CisJc3Jh
dGVbMl0gPSAweDAwOworCisJLyogU2VuZCB0aGUgbWFnaWMhICovCisJc25kX3VzYl9jdGxfbXNn
KGNoaXAtPmRldiwgdXNiX3JjdmN0cmxwaXBlKGNoaXAtPmRldiwgMCksCisJCTB4MDEsIDB4MjIs
IDB4MDEwMCwgMHgwMDg1LCAmdGVtcCwgMHgwMDAzKTsKKwlzbmRfdXNiX2N0bF9tc2coY2hpcC0+
ZGV2LCB1c2Jfc25kY3RybHBpcGUoY2hpcC0+ZGV2LCAwKSwKKwkJMHg4MSwgMHhhMiwgMHgwMTAw
LCAweDAwODUsICZzcmF0ZSwgMHgwMDAzKTsKKwlzbmRfdXNiX2N0bF9tc2coY2hpcC0+ZGV2LCB1
c2Jfc25kY3RybHBpcGUoY2hpcC0+ZGV2LCAwKSwKKwkJMHg4MSwgMHhhMiwgMHgwMTAwLCAweDAw
ODYsICZzcmF0ZSwgMHgwMDAzKTsKKwlzbmRfdXNiX2N0bF9tc2coY2hpcC0+ZGV2LCB1c2Jfc25k
Y3RybHBpcGUoY2hpcC0+ZGV2LCAwKSwKKwkJMHg4MSwgMHhhMiwgMHgwMTAwLCAweDAwMDMsICZz
cmF0ZSwgMHgwMDAzKTsKKworCWlmIChhbHRubyAhPSAzKQorCQlyZXR1cm4gMTsKKworCXJldHVy
biAwOworfQorCiB2b2lkIHNuZF91c2JfZW5kcG9pbnRfc3RhcnRfcXVpcmsoc3RydWN0IHNuZF91
c2JfZW5kcG9pbnQgKmVwKQogewogCS8qCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvcXVpcmtzLmgg
Yi9zb3VuZC91c2IvcXVpcmtzLmgKaW5kZXggMGNhOWU5MS4uMDg3YTViNiAxMDA2NDQKLS0tIGEv
c291bmQvdXNiL3F1aXJrcy5oCisrKyBiL3NvdW5kL3VzYi9xdWlya3MuaApAQCAtMjQsNiArMjQs
MTEgQEAgdm9pZCBzbmRfdXNiX3NldF9mb3JtYXRfcXVpcmsoc3RydWN0IHNuZF91c2Jfc3Vic3Ry
ZWFtICpzdWJzLAogaW50IHNuZF91c2JfaXNfYmlnX2VuZGlhbl9mb3JtYXQoc3RydWN0IHNuZF91
c2JfYXVkaW8gKmNoaXAsCiAJCQkJIHN0cnVjdCBhdWRpb2Zvcm1hdCAqZnApOwogCitpbnQgbWJv
eDJfc2tpcF9zZXR0aW5nX3F1aXJrKHN0cnVjdCBzbmRfdXNiX2F1ZGlvICpjaGlwLAorCQkJCSAg
ICBpbnQgaWZhY2UsIGludCBhbHRubyk7CisKK2ludCBzbmRfdXNiX21ib3gyX2Jvb3RfcXVpcmso
c3RydWN0IHVzYl9kZXZpY2UgKmRldik7CisKIHZvaWQgc25kX3VzYl9lbmRwb2ludF9zdGFydF9x
dWlyayhzdHJ1Y3Qgc25kX3VzYl9lbmRwb2ludCAqZXApOwogCiB2b2lkIHNuZF91c2JfY3RsX21z
Z19xdWlyayhzdHJ1Y3QgdXNiX2RldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgcGlwZSwKZGlmZiAt
LWdpdCBhL3NvdW5kL3VzYi91c2JhdWRpby5oIGIvc291bmQvdXNiL3VzYmF1ZGlvLmgKaW5kZXgg
MWFjM2ZkOS4uYTgxNzJjMSAxMDA2NDQKLS0tIGEvc291bmQvdXNiL3VzYmF1ZGlvLmgKKysrIGIv
c291bmQvdXNiL3VzYmF1ZGlvLmgKQEAgLTc2LDYgKzc2LDcgQEAgZW51bSBxdWlya190eXBlIHsK
IAlRVUlSS19NSURJX1lBTUFIQSwKIAlRVUlSS19NSURJX01JRElNQU4sCiAJUVVJUktfTUlESV9O
T1ZBVElPTiwKKwlRVUlSS19NSURJX01CT1gyLAogCVFVSVJLX01JRElfUkFXX0JZVEVTLAogCVFV
SVJLX01JRElfRU1BR0lDLAogCVFVSVJLX01JRElfQ01FLAo=
--bcaec550b544c1d84904d0bc9f68
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--bcaec550b544c1d84904d0bc9f68--

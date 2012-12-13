From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: sound: usb-audio: full capture/playback/spdif
 support for Digidesign Mbox 2
Date: Fri, 14 Dec 2012 00:09:08 +1100
Message-ID: <CABXa2sFRG7fuCnpvOhyhFre_McY7ts6caRUZeHO0didnTow3Sg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec550b544ccc9d504d0bb9e87
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6751B261617
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 14:09:09 +0100 (CET)
Received: by mail-oa0-f51.google.com with SMTP id n12so2041048oag.38
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 05:09:08 -0800 (PST)
In-Reply-To: <s5h6246saej.wl%tiwai@suse.de>
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

--bcaec550b544ccc9d504d0bb9e87
Content-Type: text/plain; charset=ISO-8859-1

Here is a patch based on for-next that does the job.

I haven't tested this particular merge on the hardware because I would
have to recompile the whole kernel, but it does compile without
warnings out of tree, and I haven't changed anything much from my
version other than semantics to make it fit with your newer code.

Please find attached the actual patch in case gmail wraps my lines.


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
index 49f9af9..dde20f4 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3078,6 +3078,93 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },

+/* DIGIDESIGN MBOX 2 */
+{
+	USB_DEVICE(0x0dba, 0x3000),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
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
+				.data = & (const struct audioformat) {
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
+                               	.data = & (const struct audioformat) {
+                                        .formats = SNDRV_PCM_FMTBIT_S24_3BE,
+                                        .channels = 2,
+                                        .iface = 4,
+                                        .altsetting = 2,
+                                        .altset_idx = 1,
+                                        .attributes =
UAC_EP_CS_ATTR_SAMPLE_RATE,
+                                        .endpoint = 0x85,
+                                        .ep_attr = USB_ENDPOINT_SYNC_SYNC,
+                                        .maxpacksize = 0x128,
+                                        .rates = SNDRV_PCM_RATE_48000,
+                                        .rate_min = 48000,
+                                        .rate_max = 48000,
+                                        .nr_rates = 1,
+                                        .rate_table = (unsigned int[]) {
+                                                48000
+                                        }
+                                }
+			},
+			{
+				.ifnum = 5,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 6,
+				.type = QUIRK_MIDI_MBOX2,
+				.data = & (const struct snd_usb_midi_endpoint_info) {
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
index 0f58b4b..9803962 100644
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
@@ -761,6 +766,107 @@ void snd_usb_set_format_quirk(struct
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
+	if ((fwsize = le16_to_cpu(get_cfg_desc(config)->wTotalLength)) ==
MBOX2_FIRMWARE_SIZE) {
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
+			if (err < 0) snd_printdd("error usb_get_descriptor: %d\n", err);
+			err = usb_reset_configuration(dev);
+			if (err < 0) snd_printdd("error usb_reset_configuration: %d\n", err);
+			snd_printdd("mbox2_boot: new boot length = %d\n",
+				le16_to_cpu(get_cfg_desc(config)->wTotalLength));
+
+			/* We want 48 kHz mode for now */
+			enablemagic[0]=0x80;
+			enablemagic[1]=0xbb;
+			enablemagic[2]=0x00;
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
+			return 0; /* Succesful boot */
+		}
+
+		snd_printk("Unknown bootresponse, or timed out, ignoring device:
%d\n",bootresponse);
+		return -ENODEV;
+	}
+	snd_printk("Invalid firmware size: %d\n",fwsize);
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
+	srate[0]=0x80;
+	srate[1]=0xbb;
+	srate[2]=0x00;
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
+	if (altno != 3) return 1;
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

--bcaec550b544ccc9d504d0bb9e87
Content-Type: text/plain; charset=US-ASCII; name="patch_for-next_dz.txt"
Content-Disposition: attachment; filename="patch_for-next_dz.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hanwkhog0

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taWRpLmMgYi9zb3VuZC91c2IvbWlkaS5jCmluZGV4IDM0
YjliYjcuLjQ1NTMyZGQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3VzYi9taWRpLmMKKysrIGIvc291bmQv
dXNiL21pZGkuYwpAQCAtMjE4MSw2ICsyMTgxLDExIEBAIGludCBzbmRfdXNibWlkaV9jcmVhdGUo
c3RydWN0IHNuZF9jYXJkICpjYXJkLAogCQl1bWlkaS0+dXNiX3Byb3RvY29sX29wcyA9ICZzbmRf
dXNibWlkaV9ub3ZhdGlvbl9vcHM7CiAJCWVyciA9IHNuZF91c2JtaWRpX2RldGVjdF9wZXJfcG9y
dF9lbmRwb2ludHModW1pZGksIGVuZHBvaW50cyk7CiAJCWJyZWFrOworCWNhc2UgUVVJUktfTUlE
SV9NQk9YMjoKKwkJLyogRGlnaWRlc2lnbiBNYm94IDIgdXNlcyBNSURJTUFOIE1JREkgcHJvdG9j
b2wgKi8KKwkJdW1pZGktPnVzYl9wcm90b2NvbF9vcHMgPSAmc25kX3VzYm1pZGlfbWlkaW1hbl9v
cHM7CisJCWVyciA9IHNuZF91c2JtaWRpX2RldGVjdF9wZXJfcG9ydF9lbmRwb2ludHModW1pZGks
IGVuZHBvaW50cyk7CisJCWJyZWFrOwogCWNhc2UgUVVJUktfTUlESV9SQVdfQllURVM6CiAJCXVt
aWRpLT51c2JfcHJvdG9jb2xfb3BzID0gJnNuZF91c2JtaWRpX3Jhd19vcHM7CiAJCS8qCmRpZmYg
LS1naXQgYS9zb3VuZC91c2IvcXVpcmtzLXRhYmxlLmggYi9zb3VuZC91c2IvcXVpcmtzLXRhYmxl
LmgKaW5kZXggNDlmOWFmOS4uZGRlMjBmNCAxMDA2NDQKLS0tIGEvc291bmQvdXNiL3F1aXJrcy10
YWJsZS5oCisrKyBiL3NvdW5kL3VzYi9xdWlya3MtdGFibGUuaApAQCAtMzA3OCw2ICszMDc4LDkz
IEBAIFlBTUFIQV9ERVZJQ0UoMHg3MDEwLCAiVUI5OSIpLAogCX0KIH0sCiAKKy8qIERJR0lERVNJ
R04gTUJPWCAyICovCit7CisJVVNCX0RFVklDRSgweDBkYmEsIDB4MzAwMCksCisJLmRyaXZlcl9p
bmZvID0gKHVuc2lnbmVkIGxvbmcpICYgKGNvbnN0IHN0cnVjdCBzbmRfdXNiX2F1ZGlvX3F1aXJr
KSB7CisJCS52ZW5kb3JfbmFtZSA9ICJEaWdpZGVzaWduIiwKKwkJLnByb2R1Y3RfbmFtZSA9ICJN
Ym94IDIiLAorCQkuaWZudW0gPSBRVUlSS19BTllfSU5URVJGQUNFLAorCQkudHlwZSA9IFFVSVJL
X0NPTVBPU0lURSwKKwkJLmRhdGEgPSAoY29uc3Qgc3RydWN0IHNuZF91c2JfYXVkaW9fcXVpcmtb
XSkgeworCQkJeworCQkJCS5pZm51bSA9IDAsCisJCQkJLnR5cGUgPSBRVUlSS19JR05PUkVfSU5U
RVJGQUNFCisJCQl9LAorCQkJeworCQkJCS5pZm51bSA9IDEsCisJCQkJLnR5cGUgPSBRVUlSS19J
R05PUkVfSU5URVJGQUNFCisJCQl9LAorCQkJeworCQkJCS5pZm51bSA9IDIsCisJCQkJLnR5cGUg
PSBRVUlSS19BVURJT19GSVhFRF9FTkRQT0lOVCwKKwkJCQkuZGF0YSA9ICYgKGNvbnN0IHN0cnVj
dCBhdWRpb2Zvcm1hdCkgeworCQkJCQkuZm9ybWF0cyA9IFNORFJWX1BDTV9GTVRCSVRfUzI0XzNC
RSwKKwkJCQkJLmNoYW5uZWxzID0gMiwKKwkJCQkJLmlmYWNlID0gMiwKKwkJCQkJLmFsdHNldHRp
bmcgPSAyLAorCQkJCQkuYWx0c2V0X2lkeCA9IDEsCisJCQkJCS5hdHRyaWJ1dGVzID0gMHgwMCwK
KwkJCQkJLmVuZHBvaW50ID0gMHgwMywKKwkJCQkJLmVwX2F0dHIgPSBVU0JfRU5EUE9JTlRfU1lO
Q19BU1lOQywKKwkJCQkJLm1heHBhY2tzaXplID0gMHgxMjgsCisJCQkJCS5yYXRlcyA9IFNORFJW
X1BDTV9SQVRFXzQ4MDAwLAorCQkJCQkucmF0ZV9taW4gPSA0ODAwMCwKKwkJCQkJLnJhdGVfbWF4
ID0gNDgwMDAsCisJCQkJCS5ucl9yYXRlcyA9IDEsCisJCQkJCS5yYXRlX3RhYmxlID0gKHVuc2ln
bmVkIGludFtdKSB7CisJCQkJCQk0ODAwMAorCQkJCQl9CisJCQkJfQorCQkJfSwKKwkJCXsKKwkJ
CQkuaWZudW0gPSAzLAorCQkJCS50eXBlID0gUVVJUktfSUdOT1JFX0lOVEVSRkFDRQorCQkJfSwK
KwkJCXsKKwkJCQkuaWZudW0gPSA0LAorCQkJCS50eXBlID0gUVVJUktfQVVESU9fRklYRURfRU5E
UE9JTlQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCS5kYXRhID0gJiAoY29uc3Qg
c3RydWN0IGF1ZGlvZm9ybWF0KSB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLmZvcm1hdHMgPSBTTkRSVl9QQ01fRk1UQklUX1MyNF8zQkUsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLmNoYW5uZWxzID0gMiwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAuaWZhY2UgPSA0LAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC5hbHRzZXR0aW5nID0gMiwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAuYWx0c2V0X2lkeCA9IDEsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLmF0dHJpYnV0ZXMgPSBVQUNfRVBfQ1NfQVRUUl9TQU1Q
TEVfUkFURSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuZW5kcG9p
bnQgPSAweDg1LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5lcF9h
dHRyID0gVVNCX0VORFBPSU5UX1NZTkNfU1lOQywKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAubWF4cGFja3NpemUgPSAweDEyOCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV80ODAwMCwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAucmF0ZV9taW4gPSA0ODAwMCwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAucmF0ZV9tYXggPSA0ODAwMCwK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAubnJfcmF0ZXMgPSAxLAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5yYXRlX3RhYmxlID0gKHVu
c2lnbmVkIGludFtdKSB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA0ODAwMAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQorCQkJfSwKKwkJCXsKKwkJCQkuaWZu
dW0gPSA1LAorCQkJCS50eXBlID0gUVVJUktfSUdOT1JFX0lOVEVSRkFDRQorCQkJfSwKKwkJCXsK
KwkJCQkuaWZudW0gPSA2LAorCQkJCS50eXBlID0gUVVJUktfTUlESV9NQk9YMiwKKwkJCQkuZGF0
YSA9ICYgKGNvbnN0IHN0cnVjdCBzbmRfdXNiX21pZGlfZW5kcG9pbnRfaW5mbykgeworCQkJCQku
b3V0X2VwID0gIDB4MDIsCisJCQkJCS5vdXRfY2FibGVzID0gMHgwMDAxLAorCQkJCQkuaW5fZXAg
PSAweDgxLAorCQkJCQkuaW5faW50ZXJ2YWwgPSAweDAxLAorCQkJCQkuaW5fY2FibGVzID0gMHgw
MDAxCisJCQkJfQorCQkJfSwKKwkJCXsKKwkJCQkuaWZudW0gPSAtMQorCQkJfQorCQl9CisJfQor
fSwKKwogewogCS8qCiAJICogU29tZSBVU0IgTUlESSBkZXZpY2VzIGRvbid0IGhhdmUgYW4gYXVk
aW8gY29udHJvbCBpbnRlcmZhY2UsCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvcXVpcmtzLmMgYi9z
b3VuZC91c2IvcXVpcmtzLmMKaW5kZXggMGY1OGI0Yi4uOTgwMzk2MiAxMDA2NDQKLS0tIGEvc291
bmQvdXNiL3F1aXJrcy5jCisrKyBiL3NvdW5kL3VzYi9xdWlya3MuYwpAQCAtMzA2LDYgKzMwNiw3
IEBAIGludCBzbmRfdXNiX2NyZWF0ZV9xdWlyayhzdHJ1Y3Qgc25kX3VzYl9hdWRpbyAqY2hpcCwK
IAkJW1FVSVJLX01JRElfWUFNQUhBXSA9IGNyZWF0ZV9hbnlfbWlkaV9xdWlyaywKIAkJW1FVSVJL
X01JRElfTUlESU1BTl0gPSBjcmVhdGVfYW55X21pZGlfcXVpcmssCiAJCVtRVUlSS19NSURJX05P
VkFUSU9OXSA9IGNyZWF0ZV9hbnlfbWlkaV9xdWlyaywKKwkJW1FVSVJLX01JRElfTUJPWDJdID0g
Y3JlYXRlX2FueV9taWRpX3F1aXJrLAogCQlbUVVJUktfTUlESV9SQVdfQllURVNdID0gY3JlYXRl
X2FueV9taWRpX3F1aXJrLAogCQlbUVVJUktfTUlESV9FTUFHSUNdID0gY3JlYXRlX2FueV9taWRp
X3F1aXJrLAogCQlbUVVJUktfTUlESV9DTUVdID0gY3JlYXRlX2FueV9taWRpX3F1aXJrLApAQCAt
NjU1LDYgKzY1NiwxMCBAQCBpbnQgc25kX3VzYl9hcHBseV9ib290X3F1aXJrKHN0cnVjdCB1c2Jf
ZGV2aWNlICpkZXYsCiAJY2FzZSBVU0JfSUQoMHgwY2NkLCAweDAwYjEpOiAvKiBUZXJyYXRlYyBB
dXJlb24gNy4xIFVTQiAqLwogCQlyZXR1cm4gc25kX3VzYl9jbTYyMDZfYm9vdF9xdWlyayhkZXYp
OwogCisJY2FzZSBVU0JfSUQoMHgwZGJhLCAweDMwMDApOgorCQkvKiBEaWdpZGVzaWduIE1ib3gg
MiAqLworCQlyZXR1cm4gc25kX3VzYl9tYm94Ml9ib290X3F1aXJrKGRldik7CisKIAljYXNlIFVT
Ql9JRCgweDEzM2UsIDB4MDgxNSk6CiAJCS8qIEFjY2VzcyBNdXNpYyBWaXJ1c1RJIERlc2t0b3Ag
Ki8KIAkJcmV0dXJuIHNuZF91c2JfYWNjZXNzbXVzaWNfYm9vdF9xdWlyayhkZXYpOwpAQCAtNzYx
LDYgKzc2NiwxMDcgQEAgdm9pZCBzbmRfdXNiX3NldF9mb3JtYXRfcXVpcmsoc3RydWN0IHNuZF91
c2Jfc3Vic3RyZWFtICpzdWJzLAogCX0KIH0KIAorLyogRGlnaWRlc2lnbiBNYm94IDIgbmVlZHMg
dG8gbG9hZCBmaXJtd2FyZSBvbmJvYXJkIAorICogYW5kIGRyaXZlciBtdXN0IHdhaXQgYSBmZXcg
c2Vjb25kcyBmb3IgaW5pdGlhbGlzYXRpb24uCisgKi8KKworI2RlZmluZSBNQk9YMl9GSVJNV0FS
RV9TSVpFICAgIDY0NgorI2RlZmluZSBNQk9YMl9CT09UX0xPQURJTkcgICAgIDB4MDEgLyogSGFy
ZCBjb2RlZCBpbnRvIHRoZSBkZXZpY2UgKi8KKyNkZWZpbmUgTUJPWDJfQk9PVF9SRUFEWSAgICAg
ICAweDAyIC8qIEhhcmQgY29kZWQgaW50byB0aGUgZGV2aWNlICovCisKK2ludCBzbmRfdXNiX21i
b3gyX2Jvb3RfcXVpcmsoc3RydWN0IHVzYl9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgdXNiX2hv
c3RfY29uZmlnICpjb25maWcgPSBkZXYtPmFjdGNvbmZpZzsKKwlpbnQgZXJyOworCXU4IGVuYWJs
ZW1hZ2ljWzNdOworCXU4IGJvb3RyZXNwb25zZTsKKwl1OCB0ZW1wWzEyXTsKKwlpbnQgZndzaXpl
OworCWludCBjb3VudDsKKworCWlmICgoZndzaXplID0gbGUxNl90b19jcHUoZ2V0X2NmZ19kZXNj
KGNvbmZpZyktPndUb3RhbExlbmd0aCkpID09IE1CT1gyX0ZJUk1XQVJFX1NJWkUpIHsKKwkJc25k
X3ByaW50aygiU2VuZGluZyBEaWdpZGVzaWduIE1ib3ggMiBib290IHNlcXVlbmNlLi4uXG4iKTsK
KworCQljb3VudCA9IDA7CisJCWJvb3RyZXNwb25zZSA9IE1CT1gyX0JPT1RfTE9BRElORzsKKwkJ
d2hpbGUgKChib290cmVzcG9uc2UgPT0gTUJPWDJfQk9PVF9MT0FESU5HKSAmJiAoY291bnQgPCAx
MCkpIHsKKwkJCW1kZWxheSg1MDApOyAvKiAwLjUgc2Vjb25kIGRlbGF5ICovCisJCQlzbmRfdXNi
X2N0bF9tc2coZGV2LCB1c2JfcmN2Y3RybHBpcGUoZGV2LCAwKSwKKwkJCQkweDg1LCAweGMwLCAw
eDAwMDEsIDB4MDAwMCwgJmJvb3RyZXNwb25zZSwgMHgwMDEyKTsKKwkJCWlmIChib290cmVzcG9u
c2UgPT0gTUJPWDJfQk9PVF9SRUFEWSkKKwkJCQlicmVhazsKKworCQkJc25kX3ByaW50aygiZGV2
aWNlIG5vdCByZWFkeSwgcmVzZW5kaW5nIGJvb3Qgc2VxdWVuY2UuLi5cbiIpOworCQkJY291bnQr
KzsKKwkJfQkKKworCQlpZiAoYm9vdHJlc3BvbnNlID09IE1CT1gyX0JPT1RfUkVBRFkpIHsKKwkJ
CXNuZF9wcmludGsoImRldmljZSBpbml0aWFsaXNlZCFcbiIpOworCisJCQllcnIgPSB1c2JfZ2V0
X2Rlc2NyaXB0b3IoZGV2LCBVU0JfRFRfREVWSUNFLCAwLAorCQkJCSZkZXYtPmRlc2NyaXB0b3Is
IHNpemVvZihkZXYtPmRlc2NyaXB0b3IpKTsKKwkJCWNvbmZpZyA9IGRldi0+YWN0Y29uZmlnOwor
CQkJaWYgKGVyciA8IDApIHNuZF9wcmludGRkKCJlcnJvciB1c2JfZ2V0X2Rlc2NyaXB0b3I6ICVk
XG4iLCBlcnIpOworCQkJZXJyID0gdXNiX3Jlc2V0X2NvbmZpZ3VyYXRpb24oZGV2KTsKKwkJCWlm
IChlcnIgPCAwKSBzbmRfcHJpbnRkZCgiZXJyb3IgdXNiX3Jlc2V0X2NvbmZpZ3VyYXRpb246ICVk
XG4iLCBlcnIpOworCQkJc25kX3ByaW50ZGQoIm1ib3gyX2Jvb3Q6IG5ldyBib290IGxlbmd0aCA9
ICVkXG4iLAorCQkJCWxlMTZfdG9fY3B1KGdldF9jZmdfZGVzYyhjb25maWcpLT53VG90YWxMZW5n
dGgpKTsKKworCQkJLyogV2Ugd2FudCA0OCBrSHogbW9kZSBmb3Igbm93ICovCisJCQllbmFibGVt
YWdpY1swXT0weDgwOworCQkJZW5hYmxlbWFnaWNbMV09MHhiYjsKKwkJCWVuYWJsZW1hZ2ljWzJd
PTB4MDA7CisKKwkJCS8qIFNlbmQgdGhlIG1hZ2ljISAqLworCQkJc25kX3VzYl9jdGxfbXNnKGRl
diwgdXNiX3JjdmN0cmxwaXBlKGRldiwgMCksCisJCQkJMHgwMSwgMHgyMiwgMHgwMTAwLCAweDAw
ODUsICZ0ZW1wLCAweDAwMDMpOworCQkJc25kX3VzYl9jdGxfbXNnKGRldiwgdXNiX3NuZGN0cmxw
aXBlKGRldiwgMCksCisJCQkJMHg4MSwgMHhhMiwgMHgwMTAwLCAweDAwODUsICZlbmFibGVtYWdp
YywgMHgwMDAzKTsKKwkJCXNuZF91c2JfY3RsX21zZyhkZXYsIHVzYl9zbmRjdHJscGlwZShkZXYs
IDApLAorCQkJCTB4ODEsIDB4YTIsIDB4MDEwMCwgMHgwMDg2LCAmZW5hYmxlbWFnaWMsIDB4MDAw
Myk7CisJCQlzbmRfdXNiX2N0bF9tc2coZGV2LCB1c2Jfc25kY3RybHBpcGUoZGV2LCAwKSwKKwkJ
CQkweDgxLCAweGEyLCAweDAxMDAsIDB4MDAwMywgJmVuYWJsZW1hZ2ljLCAweDAwMDMpOworCQkJ
c25kX3ByaW50ayhLRVJOX0lORk8gIkRpZ2lkZXNpZ24gTWJveCAyOiAyNCBCaXQgNDhrSHogQW5h
bG9ndWUiKTsKKworCQkJcmV0dXJuIDA7IC8qIFN1Y2Nlc2Z1bCBib290ICovCisJCX0KKworCQlz
bmRfcHJpbnRrKCJVbmtub3duIGJvb3RyZXNwb25zZSwgb3IgdGltZWQgb3V0LCBpZ25vcmluZyBk
ZXZpY2U6ICVkXG4iLGJvb3RyZXNwb25zZSk7CisJCXJldHVybiAtRU5PREVWOworCX0KKwlzbmRf
cHJpbnRrKCJJbnZhbGlkIGZpcm13YXJlIHNpemU6ICVkXG4iLGZ3c2l6ZSk7CisJcmV0dXJuIC1F
Tk9ERVY7Cit9CisKK2ludCBtYm94Ml9za2lwX3NldHRpbmdfcXVpcmsoc3RydWN0IHNuZF91c2Jf
YXVkaW8gKmNoaXAsCisJCQkJCWludCBpZmFjZSwgaW50IGFsdG5vKQoreworCXU4IHNyYXRlWzNd
OworCXU4IHRlbXBbMTJdOworCisJLyogUmVzZXQgaWZhY2VzIDIsNCB0byAwIGFsdHNldHRpbmcg
bGlrZSB0aGUgV2luZG93cyBkcml2ZXIgZG9lcyAqLworCXVzYl9zZXRfaW50ZXJmYWNlKGNoaXAt
PmRldiwgaWZhY2UsIDApOworCisJLyogQ2hvb3NlIDQ4MDAwSHogcGVybWFuZW50bHkgKi8KKwlz
cmF0ZVswXT0weDgwOworCXNyYXRlWzFdPTB4YmI7CisJc3JhdGVbMl09MHgwMDsKKworCS8qIFNl
bmQgdGhlIG1hZ2ljISAqLworCXNuZF91c2JfY3RsX21zZyhjaGlwLT5kZXYsIHVzYl9yY3ZjdHJs
cGlwZShjaGlwLT5kZXYsIDApLAorCQkweDAxLCAweDIyLCAweDAxMDAsIDB4MDA4NSwgJnRlbXAs
IDB4MDAwMyk7CisJc25kX3VzYl9jdGxfbXNnKGNoaXAtPmRldiwgdXNiX3NuZGN0cmxwaXBlKGNo
aXAtPmRldiwgMCksCisJCTB4ODEsIDB4YTIsIDB4MDEwMCwgMHgwMDg1LCAmc3JhdGUsIDB4MDAw
Myk7CisJc25kX3VzYl9jdGxfbXNnKGNoaXAtPmRldiwgdXNiX3NuZGN0cmxwaXBlKGNoaXAtPmRl
diwgMCksCisJCTB4ODEsIDB4YTIsIDB4MDEwMCwgMHgwMDg2LCAmc3JhdGUsIDB4MDAwMyk7CisJ
c25kX3VzYl9jdGxfbXNnKGNoaXAtPmRldiwgdXNiX3NuZGN0cmxwaXBlKGNoaXAtPmRldiwgMCks
CisJCTB4ODEsIDB4YTIsIDB4MDEwMCwgMHgwMDAzLCAmc3JhdGUsIDB4MDAwMyk7CisKKwlpZiAo
YWx0bm8gIT0gMykgcmV0dXJuIDE7CisKKwlyZXR1cm4gMDsKK30KKwogdm9pZCBzbmRfdXNiX2Vu
ZHBvaW50X3N0YXJ0X3F1aXJrKHN0cnVjdCBzbmRfdXNiX2VuZHBvaW50ICplcCkKIHsKIAkvKgpk
aWZmIC0tZ2l0IGEvc291bmQvdXNiL3F1aXJrcy5oIGIvc291bmQvdXNiL3F1aXJrcy5oCmluZGV4
IDBjYTllOTEuLjA4N2E1YjYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3VzYi9xdWlya3MuaAorKysgYi9z
b3VuZC91c2IvcXVpcmtzLmgKQEAgLTI0LDYgKzI0LDExIEBAIHZvaWQgc25kX3VzYl9zZXRfZm9y
bWF0X3F1aXJrKHN0cnVjdCBzbmRfdXNiX3N1YnN0cmVhbSAqc3VicywKIGludCBzbmRfdXNiX2lz
X2JpZ19lbmRpYW5fZm9ybWF0KHN0cnVjdCBzbmRfdXNiX2F1ZGlvICpjaGlwLAogCQkJCSBzdHJ1
Y3QgYXVkaW9mb3JtYXQgKmZwKTsKIAoraW50IG1ib3gyX3NraXBfc2V0dGluZ19xdWlyayhzdHJ1
Y3Qgc25kX3VzYl9hdWRpbyAqY2hpcCwKKwkJCQkgICAgaW50IGlmYWNlLCBpbnQgYWx0bm8pOwor
CitpbnQgc25kX3VzYl9tYm94Ml9ib290X3F1aXJrKHN0cnVjdCB1c2JfZGV2aWNlICpkZXYpOwor
CiB2b2lkIHNuZF91c2JfZW5kcG9pbnRfc3RhcnRfcXVpcmsoc3RydWN0IHNuZF91c2JfZW5kcG9p
bnQgKmVwKTsKIAogdm9pZCBzbmRfdXNiX2N0bF9tc2dfcXVpcmsoc3RydWN0IHVzYl9kZXZpY2Ug
KmRldiwgdW5zaWduZWQgaW50IHBpcGUsCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvdXNiYXVkaW8u
aCBiL3NvdW5kL3VzYi91c2JhdWRpby5oCmluZGV4IDFhYzNmZDkuLmE4MTcyYzEgMTAwNjQ0Ci0t
LSBhL3NvdW5kL3VzYi91c2JhdWRpby5oCisrKyBiL3NvdW5kL3VzYi91c2JhdWRpby5oCkBAIC03
Niw2ICs3Niw3IEBAIGVudW0gcXVpcmtfdHlwZSB7CiAJUVVJUktfTUlESV9ZQU1BSEEsCiAJUVVJ
UktfTUlESV9NSURJTUFOLAogCVFVSVJLX01JRElfTk9WQVRJT04sCisJUVVJUktfTUlESV9NQk9Y
MiwKIAlRVUlSS19NSURJX1JBV19CWVRFUywKIAlRVUlSS19NSURJX0VNQUdJQywKIAlRVUlSS19N
SURJX0NNRSwK
--bcaec550b544ccc9d504d0bb9e87
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--bcaec550b544ccc9d504d0bb9e87--

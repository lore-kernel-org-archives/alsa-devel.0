From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Fri, 04 May 2012 00:54:44 -0400
Message-ID: <4FA36114.2030305@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
	<4F9CB0D7.5060401@rauros.net>
	<CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
	<4F9D4291.6060803@rauros.net>
	<CAFz=ag5HWp-BW4ZyymR7F60ahtzttyoBk6ZwdSRVKBXepHyn1w@mail.gmail.com>
	<4FA19CAC.7070704@rauros.net>
	<CAFz=ag624FsOhyRSKY=cO5+fZtLhCKMsox4_HhFooor_B5OQ8g@mail.gmail.com>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------070008060704020904040205
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173005pub.verizon.net (vms173005pub.verizon.net
	[206.46.173.5]) by alsa0.perex.cz (Postfix) with ESMTP id 74BD724587
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2012 06:55:28 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173005.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M3H00CFHEZ8GDV1@vms173005.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Thu, 03 May 2012 23:54:49 -0500 (CDT)
In-reply-to: <CAFz=ag624FsOhyRSKY=cO5+fZtLhCKMsox4_HhFooor_B5OQ8g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070008060704020904040205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached are logs from win7 vm unplug/replug and my ubuntu 12.04 dev vm 
with alsa mods.

I've also included a patch of my current set of modifications



--------------070008060704020904040205
Content-Type: text/x-patch;
 name="changes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="changes.diff"

diff --git a/usb/mixer.c b/usb/mixer.c
index 3d70245..4e42458 100644
--- a/usb/mixer.c
+++ b/usb/mixer.c
@@ -702,7 +702,8 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 			struct uac_processing_unit_descriptor *d = p1;
 			if (d->bNrInPins) {
 				id = d->baSourceID[0];
-				break; /* continue to parse */
+				//break; /* continue to parse */
+				return 0;
 			}
 			term->type = d->bDescriptorSubtype << 16; /* virtual type */
 			term->channels = uac_processing_unit_bNrChannels(d);
diff --git a/usb/mixer_quirks.c b/usb/mixer_quirks.c
index 12125ca..a2a1ef5 100644
--- a/usb/mixer_quirks.c
+++ b/usb/mixer_quirks.c
@@ -925,6 +925,53 @@ static int snd_ftu_create_mixer(struct usb_mixer_interface *mixer)
 }
 
 
+/* Try to create mixer controls for M-Audio C400 */
+static int snd_c400_create_vol_ctls(struct usb_mixer_interface *mixer)
+{
+	char name[64];
+	unsigned int cmask;
+	int in, out, err;
+
+	const unsigned int id = 0x40;
+	const int val_type = USB_MIXER_S16;
+	const control = 1;
+
+	for (in = 0; in < 10; in++) {
+		for (out = 0; out < 6; out++) {
+			/* Give it a name */
+			if(in < 6) {
+				snprintf(name, sizeof(name),
+					"DIn%d - Out%d Playback Volume",
+					in + 1, out + 1);
+			} else {
+				snprintf(name, sizeof(name),
+					"AIn%d - Out%d Playback Volume",
+					in - 6, out + 1);				
+			}
+			/* Create as many controls as possible a.t.m. */
+			if (in * 6 + out < MAX_CHANNELS) {
+				cmask = 1 << (in * 6 + out);
+				printk(KERN_DEBUG "out = %d, in = %d, cmask=%x\n", out, in, cmask);
+				err = snd_create_std_mono_ctl(mixer, id, control,
+							cmask, val_type, name,
+							&snd_usb_mixer_vol_tlv);
+				if (err < 0)
+					return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int snd_c400_create_mixer(struct usb_mixer_interface *mixer)
+{
+	int err = 0;
+	err = snd_c400_create_vol_ctls(mixer);
+
+	return err;
+}
+
 /*
  * Create mixer for Electrix Ebox-44
  *
@@ -1025,6 +1072,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_ftu_create_mixer(mixer);
 		break;
 
+	case USB_ID(0x0763, 0x2030): /* M-Audio C400 */
+		err = snd_c400_create_mixer(mixer);
+		break;
+
 	case USB_ID(0x0b05, 0x1739):
 	case USB_ID(0x0b05, 0x1743):
 		err = snd_xonar_u1_controls_create(mixer);
diff --git a/usb/quirks-table.h b/usb/quirks-table.h
index d89ab4c..9114f8c 100644
--- a/usb/quirks-table.h
+++ b/usb/quirks-table.h
@@ -2266,7 +2266,73 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-
+{
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2030),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		/* .vendor_name = "M-Audio", */
+		/* .product_name = "Fast Track C400", */
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 4,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x01,
+					.ep_attr = 0x09,
+					.rates = SNDRV_PCM_RATE_44100 |
+						 SNDRV_PCM_RATE_48000 |
+						 SNDRV_PCM_RATE_88200 |
+						 SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+							44100, 48000, 88200, 96000
+					}
+				}
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 6,
+					.iface = 3,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x81,
+					.ep_attr = 0x05,
+					.rates = SNDRV_PCM_RATE_44100 |
+						 SNDRV_PCM_RATE_48000 |
+						 SNDRV_PCM_RATE_88200 |
+						 SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200, 96000
+					}
+				}
+			},
+			/* interface 4 (MIDI) is standard compliant */	
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 /* Casio devices */
 {
 	USB_DEVICE(0x07cf, 0x6801),

--------------070008060704020904040205
Content-Type: text/plain; charset=UTF-8;
 name="ubuntu1204.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ubuntu1204.txt"

Unplug (Ubuntu 12.04 VM)

ffff880369405a80 1193301105 S Co:2:011:0 s 00 09 0001 0000 0000 0
ffff880369405a80 1193301470 C Co:2:011:0 0 0
ffff880369405f00 1193301609 S Co:2:011:0 s 21 0a 0000 0005 0000 0
ffff880369405f00 1193301929 C Co:2:011:0 0 0


Replug (Ubuntu 12.04 VM)

ffff8803fccb4a80 1037234014 S Co:2:011:0 s 01 0b 0000 0002 0000 0
ffff8803fccb4a80 1037234345 C Co:2:011:0 0 0
ffff8803fccb4a80 1037236029 S Co:2:011:0 s 01 0b 0000 0003 0000 0
ffff8803fccb4a80 1037236365 C Co:2:011:0 0 0
ffff8803fccb4240 1037247033 S Co:2:011:0 s 21 0a 0000 0005 0000 0
ffff8803fccb4240 1037247315 C Co:2:011:0 0 0

Followed by this in syslog:

ALSA mixer.c:352 cannot get ctl value: req = 0x83, wValue = 0x101, wIndex = 0x4001, type = 4
ALSA mixer.c:877 64:1: cannot get min/max values for control 1 (id 64)

alsamixer generates no "Co" when attempting to adjust values
alsamixer generates a "Ci" first (read current value?)

alsamixer start (Ci)

ffff880401422c00 1589115481 S Ci:2:011:0 s a1 01 0100 8001 0002 2 < //Checking clock?
ffff880401422c00 1589115869 C Ci:2:011:0 0 1 = 01
ffff880401422c00 1589120513 S Ci:2:011:0 s a1 01 0100 8001 0002 2 <
ffff880401422c00 1589120864 C Ci:2:011:0 0 1 = 01
ffff880401422c00 1589123541 S Ci:2:011:0 s a1 01 0100 8001 0002 2 <
ffff880401422c00 1589123866 C Ci:2:011:0 0 1 = 01
ffff880401422c00 1589126428 S Ci:2:011:0 s a1 01 0100 8001 0002 2 <
ffff880401422c00 1589126738 C Ci:2:011:0 0 1 = 01

alsamixer toggling clock works fine

alsamixer adjust "Din1 - Out1", windows never does this

ffff8803fccfacc0 1659629521 S Ci:2:011:0 s a1 01 0100 8001 0002 2 < //Checking clock?
ffff8803fccfacc0 1659629839 C Ci:2:011:0 0 1 = 01

alsamixer adjust "Din1 - Out2", windows never does this

ffff880369a2f300 1682163455 S Ci:2:011:0 s a1 01 0100 8001 0002 2 <
ffff880369a2f300 1682163797 C Ci:2:011:0 0 1 = 01



--------------070008060704020904040205
Content-Type: text/plain; charset=UTF-8;
 name="win7.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="win7.txt"

Unplug (Win7 VM)

ffff8803dec60240 736093195 S Co:2:011:0 s 01 0b 0000 0002 0000 0
ffff8803dec60240 736093553 C Co:2:011:0 0 0
ffff8803dec60240 736093622 S Co:2:011:0 s 01 0b 0000 0003 0000 0
ffff8803dec60240 736093952 C Co:2:011:0 0 0
ffff8803cf472600 736260912 S Co:2:011:0 s 00 09 0001 0000 0000 0
ffff8803cf472600 736261233 C Co:2:011:0 0 0
ffff8803cf472840 736261376 S Co:2:011:0 s 21 0a 0000 0005 0000 0
ffff8803cf472840 736261701 C Co:2:011:0 0 0

Replug (Win7 VM)

ffff8803fce97cc0 743034698 S Co:2:011:0 s 01 0b 0000 0002 0000 0
ffff8803fce97cc0 743035029 C Co:2:011:0 0 0
ffff8803fce97cc0 743036583 S Co:2:011:0 s 01 0b 0000 0003 0000 0
ffff8803fce97cc0 743036934 C Co:2:011:0 0 0
ffff8803f952c240 743084105 S Co:2:011:0 s 21 01 0100 8101 0004 4 = 80bb0000
ffff8803f952c240 743085580 C Co:2:011:0 0 4 >
ffff8804009ad300 743089186 S Co:2:011:0 s 21 01 0100 8001 0001 1 = 01
ffff8804009ad300 743090625 C Co:2:011:0 0 1 >
ffff8804009ad300 743093241 S Co:2:011:0 s 01 0b 0000 0002 0000 0
ffff8804009ad300 743093501 C Co:2:011:0 0 0
ffff8804009ad300 743095253 S Co:2:011:0 s 01 0b 0000 0003 0000 0
ffff8804009ad300 743095625 C Co:2:011:0 0 0
ffff8804009ad540 743232173 S Co:2:011:0 s 01 0b 0001 0002 0000 0
ffff8804009ad540 743232499 C Co:2:011:0 0 0
ffff8804017aca80 743234179 S Co:2:011:0 s 01 0b 0001 0003 0000 0
ffff8804017aca80 743234523 C Co:2:011:0 0 0
ffff8804017ac000 743238366 S Co:2:011:0 s 21 0a 0000 0005 0000 0
ffff8804017ac000 743238624 C Co:2:011:0 0 0
ffff8804017acd80 743601365 S Co:2:011:0 s 21 01 0124 4001 0002 2 = fefc
ffff8804017acd80 743601769 C Co:2:011:0 0 2 >
ffff8804017acd80 743604965 S Co:2:011:0 s 21 01 0125 4001 0002 2 = fefc
ffff8804017acd80 743605371 C Co:2:011:0 0 2 >
ffff8804017acd80 743609211 S Co:2:011:0 s 21 01 012a 4001 0002 2 = fefc
ffff8804017acd80 743609620 C Co:2:011:0 0 2 >
ffff8804017acd80 743612110 S Co:2:011:0 s 21 01 012b 4001 0002 2 = fefc
ffff8804017acd80 743612495 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743615146 S Co:2:011:0 s 21 01 0130 4001 0002 2 = fefc
ffff8804009ad9c0 743615620 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743618179 S Co:2:011:0 s 21 01 0131 4001 0002 2 = fefc
ffff8804009ad9c0 743618619 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743621437 S Co:2:011:0 s 21 01 0136 4001 0002 2 = fefc
ffff8804009ad9c0 743621871 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743629171 S Co:2:011:0 s 21 01 0137 4001 0002 2 = fefc
ffff8804009ad9c0 743629621 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743634913 S Co:2:011:0 s 21 01 0100 4001 0002 2 = fefc
ffff8804009ad9c0 743635372 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743642915 S Co:2:011:0 s 21 01 0101 4001 0002 2 = fefc
ffff8804009ad9c0 743643370 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743647332 S Co:2:011:0 s 21 01 0106 4001 0002 2 = fefc
ffff8804009ad9c0 743647745 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743652820 S Co:2:011:0 s 21 01 0107 4001 0002 2 = fefc
ffff8804009ad9c0 743653244 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743656848 S Co:2:011:0 s 21 01 010c 4001 0002 2 = fefc
ffff8804009ad9c0 743657247 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743659883 S Co:2:011:0 s 21 01 010d 4001 0002 2 = fefc
ffff8804009ad9c0 743660246 C Co:2:011:0 0 2 >
ffff8804009adf00 743662799 S Co:2:011:0 s 21 01 0112 4001 0002 2 = fefc
ffff8804009adf00 743663247 C Co:2:011:0 0 2 >
ffff8804009adf00 743665814 S Co:2:011:0 s 21 01 0113 4001 0002 2 = fefc
ffff8804009adf00 743666246 C Co:2:011:0 0 2 >
ffff8804009adf00 743668909 S Co:2:011:0 s 21 01 0118 4001 0002 2 = fefc
ffff8804009adf00 743669370 C Co:2:011:0 0 2 >
ffff8804009adf00 743671816 S Co:2:011:0 s 21 01 0119 4001 0002 2 = fefc
ffff8804009adf00 743672246 C Co:2:011:0 0 2 >
ffff8804009adf00 743674776 S Co:2:011:0 s 21 01 011e 4001 0002 2 = fefc
ffff8804009adf00 743675245 C Co:2:011:0 0 2 >
ffff8803fce976c0 743677811 S Co:2:011:0 s 21 01 011f 4001 0002 2 = fefc
ffff8803fce976c0 743678269 C Co:2:011:0 0 2 >
ffff8803fce976c0 743680845 S Co:2:011:0 s 21 01 013c 4001 0002 2 = 0000
ffff8803fce976c0 743681245 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743683873 S Co:2:011:0 s 21 01 013d 4001 0002 2 = 0080
ffff8804009ad9c0 743684259 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743686870 S Co:2:011:0 s 21 01 0142 4001 0002 2 = 0080
ffff8804009ad9c0 743687261 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743689816 S Co:2:011:0 s 21 01 0143 4001 0002 2 = 0000
ffff8804009ad9c0 743690250 C Co:2:011:0 0 2 >
ffff8804009ad9c0 743692872 S Co:2:011:0 s 21 01 0100 4201 0002 2 = 0080
ffff8804009ad9c0 743693246 C Co:2:011:0 0 2 >
ffff8803fce976c0 743695781 S Co:2:011:0 s 21 01 0101 4201 0002 2 = 0080
ffff8803fce976c0 743696249 C Co:2:011:0 0 2 >
ffff8803fce976c0 743698783 S Co:2:011:0 s 21 01 0102 4201 0002 2 = fbb5
ffff8803fce976c0 743699259 C Co:2:011:0 0 2 >
ffff8803fce976c0 743701810 S Co:2:011:0 s 21 01 0103 4201 0002 2 = e5b7
ffff8803fce976c0 743702266 C Co:2:011:0 0 2 >
ffff8803fce976c0 743704846 S Co:2:011:0 s 21 01 0104 4201 0002 2 = e5b7
ffff8803fce976c0 743705260 C Co:2:011:0 0 2 >
ffff8803fce976c0 743707883 S Co:2:011:0 s 21 01 0105 4201 0002 2 = 0080
ffff8803fce976c0 743708393 C Co:2:011:0 0 2 >
ffff8803fce976c0 743710775 S Co:2:011:0 s 21 01 0106 4201 0002 2 = 03b4
ffff8803fce976c0 743711260 C Co:2:011:0 0 2 >
ffff8803fce976c0 743713809 S Co:2:011:0 s 21 01 0107 4201 0002 2 = fbb5
ffff8803fce976c0 743714259 C Co:2:011:0 0 2 >
ffff8803fce976c0 743727362 S Co:2:011:0 s 21 01 0108 4201 0002 2 = e5b7
ffff8803fce976c0 743727760 C Co:2:011:0 0 2 >
ffff8803fce976c0 743730412 S Co:2:011:0 s 21 01 0109 4201 0002 2 = c2b9
ffff8803fce976c0 743730869 C Co:2:011:0 0 2 >
ffff8803fce976c0 743733367 S Co:2:011:0 s 21 03 0000 2001 0001 1 = 02
ffff8803fce976c0 743733760 C Co:2:011:0 0 1 >
ffff8803fce976c0 743736356 S Co:2:011:0 s 21 01 0126 4001 0002 2 = fefc
ffff8803fce976c0 743736759 C Co:2:011:0 0 2 >
ffff8803fce976c0 743739345 S Co:2:011:0 s 21 01 0127 4001 0002 2 = fefc
ffff8803fce976c0 743739759 C Co:2:011:0 0 2 >
ffff8803fce976c0 743742384 S Co:2:011:0 s 21 01 012c 4001 0002 2 = fefc
ffff8803fce976c0 743742885 C Co:2:011:0 0 2 >
ffff8803fce976c0 743745275 S Co:2:011:0 s 21 01 012d 4001 0002 2 = fefc
ffff8803fce976c0 743745760 C Co:2:011:0 0 2 >
ffff8803fce976c0 743748365 S Co:2:011:0 s 21 01 0132 4001 0002 2 = fefc
ffff8803fce976c0 743748760 C Co:2:011:0 0 2 >
ffff8803fce976c0 743751366 S Co:2:011:0 s 21 01 0133 4001 0002 2 = fefc
ffff8803fce976c0 743751759 C Co:2:011:0 0 2 >
ffff8803fce976c0 743754396 S Co:2:011:0 s 21 01 0138 4001 0002 2 = fefc
ffff8803fce976c0 743754870 C Co:2:011:0 0 2 >
ffff8803fce976c0 743759321 S Co:2:011:0 s 21 01 0139 4001 0002 2 = fefc
ffff8803fce976c0 743759743 C Co:2:011:0 0 2 >
ffff8803fce976c0 743766405 S Co:2:011:0 s 21 01 0102 4001 0002 2 = fefc
ffff8803fce976c0 743766893 C Co:2:011:0 0 2 >
ffff8803fce976c0 743768821 S Co:2:011:0 s 21 01 0103 4001 0002 2 = fefc
ffff8803fce976c0 743769296 C Co:2:011:0 0 2 >
ffff8803fce976c0 743771915 S Co:2:011:0 s 21 01 0108 4001 0002 2 = fefc
ffff8803fce976c0 743772394 C Co:2:011:0 0 2 >
ffff8803fce976c0 743774882 S Co:2:011:0 s 21 01 0109 4001 0002 2 = fefc
ffff8803fce976c0 743775395 C Co:2:011:0 0 2 >
ffff8803fce976c0 743777971 S Co:2:011:0 s 21 01 010e 4001 0002 2 = fefc
ffff8803fce976c0 743778396 C Co:2:011:0 0 2 >
ffff8803fce976c0 743780800 S Co:2:011:0 s 21 01 010f 4001 0002 2 = fefc
ffff8803fce976c0 743781244 C Co:2:011:0 0 2 >
ffff8804009adb40 743783861 S Co:2:011:0 s 21 01 0114 4001 0002 2 = fefc
ffff8804009adb40 743784245 C Co:2:011:0 0 2 >
ffff8804009adb40 743786897 S Co:2:011:0 s 21 01 0115 4001 0002 2 = fefc
ffff8804009adb40 743787370 C Co:2:011:0 0 2 >
ffff8804009adb40 743789903 S Co:2:011:0 s 21 01 011a 4001 0002 2 = fefc
ffff8804009adb40 743790368 C Co:2:011:0 0 2 >
ffff8804009adb40 743792798 S Co:2:011:0 s 21 01 011b 4001 0002 2 = fefc
ffff8804009adb40 743793251 C Co:2:011:0 0 2 >
ffff8804009ad180 743795837 S Co:2:011:0 s 21 01 0120 4001 0002 2 = fefc
ffff8804009ad180 743796243 C Co:2:011:0 0 2 >
ffff8804009ad180 743798896 S Co:2:011:0 s 21 01 0121 4001 0002 2 = fefc
ffff8804009ad180 743799368 C Co:2:011:0 0 2 >
ffff8804017acd80 743801916 S Co:2:011:0 s 21 01 013e 4001 0002 2 = 0000
ffff8804017acd80 743802368 C Co:2:011:0 0 2 >
ffff8804009ad180 743804823 S Co:2:011:0 s 21 01 013f 4001 0002 2 = 0080
ffff8804009ad180 743805245 C Co:2:011:0 0 2 >
ffff8804009adb40 743807841 S Co:2:011:0 s 21 01 0144 4001 0002 2 = 0080
ffff8804009adb40 743808243 C Co:2:011:0 0 2 >
ffff8804009adb40 743810874 S Co:2:011:0 s 21 01 0145 4001 0002 2 = 0000
ffff8804009adb40 743811247 C Co:2:011:0 0 2 >
ffff8804017ac240 743813968 S Co:2:011:0 s 21 01 0128 4001 0002 2 = fefc
ffff8804017ac240 743814376 C Co:2:011:0 0 2 >
ffff8804017ac240 743816823 S Co:2:011:0 s 21 01 0129 4001 0002 2 = fefc
ffff8804017ac240 743817249 C Co:2:011:0 0 2 >
ffff8804017ac240 743819836 S Co:2:011:0 s 21 01 012e 4001 0002 2 = fefc
ffff8804017ac240 743820245 C Co:2:011:0 0 2 >
ffff8804017ac240 743822948 S Co:2:011:0 s 21 01 012f 4001 0002 2 = fefc
ffff8804017ac240 743823370 C Co:2:011:0 0 2 >
ffff8804017ac240 743825911 S Co:2:011:0 s 21 01 0134 4001 0002 2 = fefc
ffff8804017ac240 743826369 C Co:2:011:0 0 2 >
ffff8804017ac240 743828804 S Co:2:011:0 s 21 01 0135 4001 0002 2 = fefc
ffff8804017ac240 743829244 C Co:2:011:0 0 2 >
ffff8804017ac240 743831839 S Co:2:011:0 s 21 01 013a 4001 0002 2 = fefc
ffff8804017ac240 743832245 C Co:2:011:0 0 2 >
ffff8804017ac240 743834880 S Co:2:011:0 s 21 01 013b 4001 0002 2 = fefc
ffff8804017ac240 743835371 C Co:2:011:0 0 2 >
ffff8804017ac240 743837921 S Co:2:011:0 s 21 01 0104 4001 0002 2 = fefc
ffff8804017ac240 743838370 C Co:2:011:0 0 2 >
ffff8804017ac240 743840855 S Co:2:011:0 s 21 01 0105 4001 0002 2 = fefc
ffff8804017ac240 743841243 C Co:2:011:0 0 2 >
ffff8804017ac240 743844021 S Co:2:011:0 s 21 01 010a 4001 0002 2 = fefc
ffff8804017ac240 743844493 C Co:2:011:0 0 2 >
ffff8804017ac240 743846987 S Co:2:011:0 s 21 01 010b 4001 0002 2 = fefc
ffff8804017ac240 743847379 C Co:2:011:0 0 2 >
ffff8804017ac240 743849920 S Co:2:011:0 s 21 01 0110 4001 0002 2 = fefc
ffff8804017ac240 743850370 C Co:2:011:0 0 2 >
ffff8804017ac240 743852797 S Co:2:011:0 s 21 01 0111 4001 0002 2 = fefc
ffff8804017ac240 743853242 C Co:2:011:0 0 2 >
ffff8804017ac240 743855832 S Co:2:011:0 s 21 01 0116 4001 0002 2 = fefc
ffff8804017ac240 743856242 C Co:2:011:0 0 2 >
ffff8804017ac240 743858874 S Co:2:011:0 s 21 01 0117 4001 0002 2 = fefc
ffff8804017ac240 743859242 C Co:2:011:0 0 2 >
ffff8804009ada80 743861920 S Co:2:011:0 s 21 01 011c 4001 0002 2 = fefc
ffff8804009ada80 743862394 C Co:2:011:0 0 2 >
ffff880401333480 743864815 S Co:2:011:0 s 21 01 011d 4001 0002 2 = fefc
ffff880401333480 743865268 C Co:2:011:0 0 2 >
ffff880401333480 743867849 S Co:2:011:0 s 21 01 0122 4001 0002 2 = fefc
ffff880401333480 743868246 C Co:2:011:0 0 2 >
ffff880401333480 743870896 S Co:2:011:0 s 21 01 0123 4001 0002 2 = fefc
ffff880401333480 743871384 C Co:2:011:0 0 2 >
ffff880401333480 743873910 S Co:2:011:0 s 21 01 0140 4001 0002 2 = 0080
ffff880401333480 743874383 C Co:2:011:0 0 2 >
ffff880401333480 743876798 S Co:2:011:0 s 21 01 0141 4001 0002 2 = 0080
ffff880401333480 743877261 C Co:2:011:0 0 2 >
ffff880401333480 743879830 S Co:2:011:0 s 21 01 0146 4001 0002 2 = 0080
ffff880401333480 743880254 C Co:2:011:0 0 2 >
ffff880401333480 743882875 S Co:2:011:0 s 21 01 0147 4001 0002 2 = 0080
ffff880401333480 743883274 C Co:2:011:0 0 2 >
ffff880401333480 743885900 S Co:2:011:0 s 21 01 0200 4301 0001 1 = 00
ffff880401333480 743886509 C Co:2:011:0 0 1 >
ffff880401333480 743888798 S Co:2:011:0 s 21 01 0400 4301 0002 2 = c81b
ffff880401333480 743889242 C Co:2:011:0 0 2 >
ffff880401333480 743891884 S Co:2:011:0 s 21 01 0500 4301 0001 1 = 19
ffff880401333480 743892379 C Co:2:011:0 0 1 >
ffff880401333480 743895571 S Co:2:011:0 s 21 01 0300 4301 0001 1 = 31
ffff880401333480 743896005 C Co:2:011:0 0 1 >
ffff880401333480 743902756 S Co:2:011:0 s 21 03 0005 2001 0001 1 = 00
ffff880401333480 743903242 C Co:2:011:0 0 1 >
ffff880401333480 743910190 S Co:2:011:0 s 21 03 0004 2001 0010 16 = 005b002c 00000000 00000000 00000000
ffff880401333480 743910631 C Co:2:011:0 0 16 >
ffff880401333480 743913084 S Co:2:011:0 s 21 03 0006 2001 0001 1 = 03
ffff880401333480 743913587 C Co:2:011:0 0 1 >
ffff8804009ada80 744272081 S Co:2:011:0 s 21 09 0200 0005 0001 1 = 00
ffff8804009ada80 744272491 C Co:2:011:0 0 1 >

--------------070008060704020904040205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070008060704020904040205--

From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: sound: usb-audio: full capture/playback/spdif
 support for Digidesign Mbox 2
Date: Tue, 14 Dec 2010 20:57:40 +1100
Message-ID: <AANLkTi=Y6tA=1CW6Yu0rpAm7=JyLLjA1A-4cL-JFaBrP@mail.gmail.com>
References: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>
	<4CEED787.9050504@gmail.com>
	<AANLkTimjaYMaqA3fFqWKi0+8nsaqENe8oWj=hph1Hv09@mail.gmail.com>
	<s5hfwukp4k4.wl%tiwai@suse.de>
	<AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
	<4CF517BF.4020706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id A00C02458C
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 10:57:41 +0100 (CET)
Received: by qwj8 with SMTP id 8so535003qwj.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 01:57:40 -0800 (PST)
In-Reply-To: <4CF517BF.4020706@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

My previous patch did not enable capture, this patch works and duplex
mode is flawless.

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 25bce7e..5dace7e 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2122,6 +2122,18 @@ int snd_usbmidi_create(struct snd_card *card,
 		umidi->usb_protocol_ops =3D &snd_usbmidi_novation_ops;
 		err =3D snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
+	case QUIRK_MIDI_MBOX2:
+		/* Digidesign Mbox 2 uses MIDIMAN MIDI protocol */
+		umidi->usb_protocol_ops =3D &snd_usbmidi_midiman_ops;
+		/*
+		 * We have to make sure that the USB core looks
+		 * again at interface 6 by calling usb_set_interface() on it.
+		 */
+		usb_set_interface(umidi->dev, 6, 0);
+		memcpy(&endpoints[0], quirk->data,
+			sizeof(struct snd_usb_midi_endpoint_info));
+		err =3D 0;
+		break;
 	case QUIRK_MIDI_RAW_BYTES:
 		umidi->usb_protocol_ops =3D &snd_usbmidi_raw_ops;
 		/*
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index ad7079d..2ea3636 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2477,6 +2477,58 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },

+/* DIGIDESIGN MBOX 2 */
+{
+       USB_DEVICE(0x0dba, 0x3000),
+       .driver_info =3D (unsigned long) & (const struct snd_usb_audio_quir=
k) {
+               .vendor_name =3D "Digidesign",
+               .product_name =3D "Mbox 2",
+               .ifnum =3D QUIRK_ANY_INTERFACE,
+               .type =3D QUIRK_COMPOSITE,
+               .data =3D (const struct snd_usb_audio_quirk[]) {
+                       {
+                               .ifnum =3D 0,
+                               .type =3D QUIRK_IGNORE_INTERFACE
+                       },
+                       {
+                               .ifnum =3D 1,
+                               .type =3D QUIRK_IGNORE_INTERFACE
+                       },
+                       {
+                               .ifnum =3D 2,
+                               .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
+                       },
+                       {
+                               .ifnum =3D 3,
+                               .type =3D QUIRK_IGNORE_INTERFACE
+                       },
+                       {
+                                .ifnum =3D 4,
+                               .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
+                       },
+                       {
+                                .ifnum =3D 5,
+                               .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
+                       },
+                       {
+                               .ifnum =3D 6,
+                               .type =3D QUIRK_MIDI_MBOX2,
+                               .data =3D & (const struct
snd_usb_midi_endpoint_info) {
+                                       .out_ep =3D  0x02,
+                                       .out_cables =3D 0x0001,
+                                       .in_ep =3D 0x81,
+                                       .in_interval =3D 0x01,
+                                       .in_cables =3D 0x0001
+                               }
+
+                       },
+                       {
+                               .ifnum =3D -1
+                       }
+               }
+       }
+},
+
 {
 	/*
 	 * Some USB MIDI devices don't have an audio control interface,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index cf8bf08..fe4b8e2 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -287,6 +287,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_YAMAHA] =3D create_any_midi_quirk,
 		[QUIRK_MIDI_MIDIMAN] =3D create_any_midi_quirk,
 		[QUIRK_MIDI_NOVATION] =3D create_any_midi_quirk,
+		[QUIRK_MIDI_MBOX2] =3D create_any_midi_quirk,
 		[QUIRK_MIDI_RAW_BYTES] =3D create_any_midi_quirk,
 		[QUIRK_MIDI_EMAGIC] =3D create_any_midi_quirk,
 		[QUIRK_MIDI_CME] =3D create_any_midi_quirk,
@@ -479,6 +480,9 @@ int snd_usb_apply_interface_quirk(struct
snd_usb_audio *chip,
 	if (chip->usb_id =3D=3D USB_ID(0x0763, 0x2003))
 		return audiophile_skip_setting_quirk(chip, iface, altno);

+	if (chip->usb_id =3D=3D USB_ID(0x0dba, 0x3000))
+        	return mbox2_skip_setting_quirk(chip, iface, altno);
+
 	return 0;
 }

@@ -510,6 +514,10 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 	if (id =3D=3D USB_ID(0x133e, 0x0815))
 		return snd_usb_accessmusic_boot_quirk(dev);

+	/* Digidesign Mbox 2 */
+	if (id =3D=3D USB_ID(0x0dba, 0x3000))
+		return snd_usb_mbox2_boot_quirk(dev);
+
 	return 0;
 }

@@ -527,6 +535,9 @@ int snd_usb_is_big_endian_format(struct
snd_usb_audio *chip, struct audioformat
 		if (chip->setup =3D=3D 0x00 ||
 		    fp->altsetting=3D=3D1 || fp->altsetting=3D=3D2 || fp->altsetting=3D=
=3D3)
 			return 1;
+		break;	=

+	case USB_ID(0x0dba, 0x3000): /* Digidesign Mbox 2 */
+		return 1;
 	}
 	return 0;
 }
@@ -594,3 +605,170 @@ void snd_usb_set_format_quirk(struct
snd_usb_substream *subs,
 	}
 }

+#define MBOX2_FIRMWARE_SIZE    646
+#define MBOX2_BOOT_LOADING     0x01 /* Hard coded into the device */
+#define MBOX2_BOOT_READY       0x02 /* Hard coded into the device */
+
+static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
+{
+        struct usb_host_config *config =3D dev->actconfig;
+        int err;
+        u8 enablemagic[3];
+        u8 bootresponse;
+        u8 temp[12];
+        int fwsize;
+
+        if ((fwsize =3D
le16_to_cpu(get_cfg_desc(config)->wTotalLength)) =3D=3D
MBOX2_FIRMWARE_SIZE) {
+                snd_printdd("Sending Digidesign Mbox 2 boot sequence...\n"=
);
+
+                        /* From USB Snoop,
+                         *
+                         * SetupPacket =3D RT RQ VHVL INDX SIZE
+                         * RT =3D 0xRT Request Type
+                         * RQ =3D 0xRQ Request
+                         * VHVL =3D 0xVLVH Value in reverse byte order
+                         * INDX =3D 0xDXIN Index in reverse byte order
+                         * SIZE =3D 0xZESI Size in reverse byte order
+                         *
+                         * Magic boot code setup packet: c0 85 01 00
00 00 12 00
+                         *           RQ    RT    VLVH    DXIN
        ZESI
+                         * becomes 0x85, 0xc0, 0x0001, 0x0000,
&RETURNDATA, 0x0012, TIMEOUT
+                         * for snd_usb_ctl_msg()
+                         */
+
+mbox2_reboot:
+                snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+                        0x85, 0xc0, 0x0001, 0x0000, &bootresponse,
0x0012, 1000);
+
+                if (bootresponse =3D=3D MBOX2_BOOT_LOADING) {
+                        snd_printdd("device not ready, resending boot
sequence...\n");
+                        goto mbox2_reboot;
+                }
+
+                if (bootresponse =3D=3D MBOX2_BOOT_READY) {
+                        snd_printdd("device initialised!\n");
+
+                        err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0,
+                                &dev->descriptor, sizeof(dev->descriptor));
+                        config =3D dev->actconfig;
+                        if (err < 0) snd_printdd("error
usb_get_descriptor: %d\n", err);
+                        err =3D usb_reset_configuration(dev);
+                        if (err < 0) snd_printdd("error
usb_reset_configuration: %d\n", err);
+                        snd_printdd("mbox2_boot: new boot length =3D %d\n",
+                            le16_to_cpu(get_cfg_desc(config)->wTotalLength=
));
+
+                        /* Successful boot, (should reset all
altsettings to 0 like windows does, but works without it)
+                         * but now we will try sending
capture/playback enable magic
+                         *
+                         * 80 bb 00 =3D 48kHz
+                         * 44 ac 00 =3D 44.1kHz
+                         *
+                         */
+                        /* We want 48 kHz mode for now */
+                        enablemagic[0]=3D0x80;
+                        enablemagic[1]=3D0xbb;
+                        enablemagic[2]=3D0x00;
+
+                        /* Send the magic! */
+                        snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+                                0x01, 0x22, 0x0100, 0x0085, &temp,
0x0003, 1000);
+
+                        snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+                                0x81, 0xa2, 0x0100, 0x0085,
&enablemagic, 0x0003, 1000);
+
+                        snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+                                0x81, 0xa2, 0x0100, 0x0086,
&enablemagic, 0x0003, 1000);
+
+                        snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+                                0x81, 0xa2, 0x0100, 0x0003,
&enablemagic, 0x0003, 1000);
+
+                        return 0; /* Succesful boot */
+                }
+
+                snd_printdd("unknown bootresponse, ignoring device:
%d\n",bootresponse);
+                return -ENODEV;
+        }
+        snd_printk("Invalid firmware size: %d\n",fwsize);
+        return -ENODEV;
+}
+
+#define MBOX2_SET_48K_SPDIF            0
+#define MBOX2_SET_44K_SPDIF            1
+#define MBOX2_SET_48K_ANALOG           2
+#define MBOX2_SET_44K_ANALOG           3
+
+static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
+                                        int iface, int altno)
+{
+        u8 srate[3];
+        u8 temp[12];
+
+        /* Reset ifaces 2-5 to 0 altsetting. */
+        usb_set_interface(chip->dev, iface, 0);
+
+        if (chip->setup =3D=3D MBOX2_SET_48K_SPDIF ||
+            chip->setup =3D=3D MBOX2_SET_48K_ANALOG) {
+                //setup 48k
+                srate[0]=3D0x80;
+                srate[1]=3D0xbb;
+                srate[2]=3D0x00;
+
+                /* Send the magic! */
+                snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
+                        0x01, 0x22, 0x0100, 0x0085, &temp, 0x0003, 1000);
+
+                snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+                        0x81, 0xa2, 0x0100, 0x0085, &srate, 0x0003, 1000);
+
+                snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+                        0x81, 0xa2, 0x0100, 0x0086, &srate, 0x0003, 1000);
+
+                snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+                        0x81, 0xa2, 0x0100, 0x0003, &srate, 0x0003, 1000);
+
+		snd_printk(KERN_INFO "Digidesign Mbox 2: 24 Bit 48000Hz");
+
+                if (chip->setup =3D=3D MBOX2_SET_48K_SPDIF) {
+                        //setup spdif
+                        snd_printk(KERN_INFO ", SPDIF\n");
+                        if (altno !=3D 2) return 1;
+                } else {
+                        //setup analog
+                        snd_printk(KERN_INFO ", ANALOGUE\n");
+                        if (altno !=3D 3) return 1;
+                }
+        } else {
+                //setup 44k
+                srate[0]=3D0x44;
+                srate[1]=3D0xac;
+                srate[2]=3D0x00;
+
+                /* Send the magic! */
+                snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
+                        0x01, 0x22, 0x0100, 0x0085, &temp, 0x0003, 1000);
+
+                snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+                        0x81, 0xa2, 0x0100, 0x0085, &srate, 0x0003, 1000);
+
+                snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+                        0x81, 0xa2, 0x0100, 0x0086, &srate, 0x0003, 1000);
+
+                snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+                        0x81, 0xa2, 0x0100, 0x0003, &srate, 0x0003, 1000);
+
+                snd_printk(KERN_INFO "Digidesign Mbox 2: 24 Bit 44100Hz");
+                if (chip->setup =3D=3D MBOX2_SET_44K_SPDIF ||
+	            chip->setup =3D=3D MBOX2_SET_44K_ANALOG) {
+                        //setup spdif
+                        snd_printk(KERN_INFO ", SPDIF\n");
+                        if (altno !=3D 2) return 1;
+                } else {
+                        //setup analog
+                        snd_printk(KERN_INFO ", ANALOGUE\n");
+                        if (altno !=3D 3) return 1;
+                }
+        }
+        return 0;
+}
+
+
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 03e5e94..13fd3ad 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -20,4 +20,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *s=
ubs,
 int snd_usb_is_big_endian_format(struct snd_usb_audio *chip,
 				 struct audioformat *fp);

+static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
+                                       int iface, int altno);
+
+static int snd_usb_mbox2_boot_quirk(struct usb_device *dev);
+
 #endif /* __USBAUDIO_QUIRKS_H */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index db3eb21..128c3f4 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -70,6 +70,7 @@ enum quirk_type {
 	QUIRK_MIDI_YAMAHA,
 	QUIRK_MIDI_MIDIMAN,
 	QUIRK_MIDI_NOVATION,
+	QUIRK_MIDI_MBOX2,
 	QUIRK_MIDI_RAW_BYTES,
 	QUIRK_MIDI_EMAGIC,
 	QUIRK_MIDI_CME,


On Wed, Dec 1, 2010 at 2:26 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Damien Zammit wrote:
>> Unfortunately I am sending this email from gmail, so I'm not sure
>> about line formatting, yikes.
>
> Long lines are wrapped.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* We have to make sure that the USB core lo=
oks
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* again at interface 6 by calling usb_set_i=
nterface() on it.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 usb_set_interface(umidi->dev, 6, 0);
>
> Why? =A0Is this another duplicate endpoint number?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&endpoints[0], quirk->data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct snd_usb_midi_end=
point_info));
>
> I think you should be able to call snd_usbmidi_detect_per_port_endpoints
> here.
>
>> +/* DIGIDESIGN MBOX 2 */
>> +{
>> + =A0 =A0 =A0 /* Damien Zammit <damien.zammit@gmail.com> */
>
> This usually goes into the commit log.
>
>> + =A0 =A0 =A0 USB_DEVICE(0x0dba, 0x3000),
>
> The entries are supposed to be ordered by their IDs.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * but now we will try =
sending
>> capture/playback enable magic
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 80 bb 00 =3D 24bit m=
ode - S24_3BE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 44 ac 00 =3D 16bit m=
ode?
>
> Why the question mark?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//enablemagic[0]=3D0x44;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//enablemagic[1]=3D0xac;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//enablemagic[2]=3D0x00;
>
> Why is this commented out?
>
>> +#define MBOX2_SET_48K_SPDIF =A0 =A0 =A0 =A0 =A0 =A00
>> +#define MBOX2_SET_44K_SPDIF =A0 =A0 =A0 =A0 =A0 =A01
>> +#define MBOX2_SET_48K_ANALOG =A0 =A0 =A0 =A0 =A0 2
>> +#define MBOX2_SET_44K_ANALOG =A0 =A0 =A0 =A0 =A0 3
>
> In theory, this should be some control instead of a module parameter.
>
>> +static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0int iface, int altno)
>
> This function isn't consistently indented with tabs.
>
>
> Regards,
> Clemens
>

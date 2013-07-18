From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fwd: Re: Alsa USB Audio regression
Date: Fri, 19 Jul 2013 06:33:32 +0800
Message-ID: <CAN8cciaTmWv-gOWD2ttHQZm88UMnPcX7qUVQfnbP8SRxEX0r=Q@mail.gmail.com>
References: <51E5745E.2090209@gmx.at>
	<51E5A096.1050001@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 351792655EE
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 00:33:34 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c10so8428185ieb.10
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 15:33:33 -0700 (PDT)
In-Reply-To: <51E5A096.1050001@gmx.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Ulrich_G=C3=BCnther?= <ulrich.guenther@gmx.at>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> >>

> > >> control.6 {
> > >> comment.access 'read write'
> > >> comment.type INTEGER
> > >> comment.count 1 comment.range '0 - 37'
> > >> comment.dbmin 0 comment.dbmax 14
> > >> iface MIXER
> > >> name 'Speaker Playback Volume' value 30 }
> > >>
> > >>
> > >>  In 12.04 pulseaudio did not provide software volume attenuation
> > and use the speaker playback volume control
> > >
> > >
> > > So does that mean that the bug is in pulseaudio, or could it be even
> > deeper like in the kernel or something?
> >
> > Are there any significant change in volume when you use "alsamixer
> > -c0" to change speaker playback volume from min 0dB to 0.14dB ?
> >
> > Did pulseaudio provide software attuentation -1.61dB when the range of
> > hardware volume control is only 0.14dB ?
> >
> > * index: 0
> > name: <alsa_output.usb-0d8c_USB_Audio-00-Audio.analog-surround-71>
> > driver: <module-alsa-card.c>
> > flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY
> > DYNAMIC_LATENCY
> > state: SUSPENDED
> > suspend cause: IDLE
> > priority: 9049
> > volume: 0:  94% 1:  94% 2:  94% 3:  94% 4:  94% 5:  94% 6:  94% 7:  94%
> >         0: -1,61 dB 1: -1,61 dB 2: -1,61 dB 3: -1,61 dB 4: -1,61 dB 5:
> > -1,61 dB 6: -1,61 dB 7: -1,61 dB
> >         balance 0,00
> > base volume:  99%
> >              -0,14 dB
> > volume steps: 65537
> > muted: no
> >
> > It is strange that 5.1 headset only support 8 channels playback
> >
> Okay i did try "alsamixer -c0" in Ubuntu 12.04 LTS, i selected the Usb
> Headset, Speaker was at 0 using the remote control from the headset i
> could bring the value to 86, so if the volume is turned down the value
> goes immideatly to 0.
> With the alsamixer i was able to regulate the value between 0 and 100,
> db-change is 0,01 at lowest and 0,14 at highest.
> I could increment/decrement the db-change in steps of 0,01 (with the
> up/down keys from the keyboard), the volume from the headset-speakers
> follows accordingly.
>

Do you mean volume at max is much louder than volume at min ? (i.e. the
range should be more than 0.14 dB )



> When using anything besides the "alsamixer -c0" the volume can only be 0
> or 86.
> I was able to play the test sounds for: front center, front left, front
> right, rear left,rear right and subwoofer every thing came from the
> right direction, as expected from a 5.1 headset.
> I was really surprised,  thank you for pointing this out, it really
> didn't occur to me, maybe i saw the alsamixer some years ago but i
> really couldn't remember that it was there.
>
>
you are not using latest alsa driver since this patch should change the
speaker playback volume to headphone playback volume

ALSA: usb - Don't create "Speaker" mixer controls on headphones and headsets


https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb/mixer.c?id=9b4ef97757953c6071563b7cbfc689e3dd771603



https://launchpadlibrarian.net/145274104/pulseverbose%28ubuntu13.04-linux-3.10.1%29.log

( 0.906| 0.000) I: [pulseaudio] source.c: device.product.name = "Storm
HP-USB500 5.1 Headset"
( 0.906| 0.000) I: [pulseaudio] source.c: device.serial = "0d8c_USB_Audio"
( 0.906| 0.000) I: [pulseaudio] source.c: device.form_factor = "headset"
( 0.906| 0.000) I: [pulseaudio] source.c: device.string = "1"
( 0.906| 0.000) I: [pulseaudio] source.c: module-udev-detect.discovered =
"1"
( 0.906| 0.000) I: [pulseaudio] source.c: device.icon_name =
"audio-headset-usb"
( 0.906| 0.000) I: [pulseaudio] source.c: device.intended_roles = "phone"
( 0.907| 0.001) I: [pulseaudio] alsa-sink.c: Using 2.0 fragments of size
524288 bytes (743.04ms), buffer size is 1048576 bytes (1486.08ms)
( 0.908| 0.000) I: [pulseaudio] alsa-sink.c: Time scheduling watermark is
5.03ms
( 0.908| 0.000) D: [pulseaudio] alsa-sink.c: hwbuf_unused=0
( 0.908| 0.000) D: [pulseaudio] alsa-sink.c: setting avail_min=65314
( 0.908| 0.000) D: [pulseaudio] alsa-mixer.c: Activating path
analog-output-speaker
( 0.908| 0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-speaker
(Speakers), direction=1, priority=100, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=37,
min_dB=0, max_dB=0.14
( 0.908| 0.000) D: [pulseaudio] alsa-mixer.c: Element Speaker, direction=1,
switch=1, volume=1, volume_limit=-1, enumeration=0, required=0,
required_any=4, required_absent=0, mask=0x7ffffffffffff, n_channels=1,
override_map=yes
( 0.908| 0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone,
alsa_name='Headphone Jack', detection unavailable
( 0.908| 0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Headphone,
alsa_name='Front Headphone Jack', detection unavailable
( 0.908| 0.000) D: [pulseaudio] alsa-mixer.c: Jack Speaker Phantom,
alsa_name='Speaker Phantom Jack', detection unavailable
( 0.908| 0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled deferred
volume.
( 0.908| 0.000) I: [pulseaudio] alsa-sink.c: Hardware volume ranges from
0.00 dB to 0.14 dB.
( 0.908| 0.000) I: [pulseaudio] alsa-sink.c: Fixing base volume to -0.14 dB
( 0.908| 0.000) I: [pulseaudio] alsa-sink.c: Using hardware volume control.
Hardware dB scale supported.
( 0.908| 0.000) I: [pulseaudio] alsa-sink.c: Using hardware mute control.


https://launchpadlibrarian.net/145274349/lusb-vvv-ubuntu13.04-linux3.10.1.txt

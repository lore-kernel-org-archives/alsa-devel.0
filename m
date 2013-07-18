From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fwd: Re: Alsa USB Audio regression
Date: Thu, 18 Jul 2013 08:55:18 +0800
Message-ID: <CAN8cciagY09se1HqdAo1b0Q=+C-a-XBk94-zG-5f+6TDR4yjSw@mail.gmail.com>
References: <51E5745E.2090209@gmx.at> <51E5A096.1050001@gmx.at>
 <s5hhafttciy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id C788826553F
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 02:55:19 +0200 (CEST)
Received: by mail-ie0-f177.google.com with SMTP id aq17so5601032iec.36
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 17:55:18 -0700 (PDT)
In-Reply-To: <s5hhafttciy.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, =?UTF-8?Q?Ulrich_G=C3=BCnther?= <ulrich.guenther@gmx.at>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

> > >>>

> > > >>> After Ubuntu 10.04 LTS (Ubuntu 10.10 works, Ubuntu 11.04 doesn't
> > > work at
> > > >>> all, Ubuntu 11.10 and newer have the bug), the headset only plays
> > > sound
> > > >>> at maximum volume level if the volume is turned down just a little
> no
> > > >>> sound is being played.
> > > >>>
> > > >>> I have filled a Ubuntu bug for 12.04 LTS at:
> > > >>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1200925.
> > > >>>
> > > >>> AlsaInfo for Ubuntu 12.04 LTS with the bug:
> > > >>>
> > >
> http://www.alsa-project.org/db/?f=3bde76b15a15f585418a6a4a4703ca67fd4cdf42
> > > .
> > > >>> AlsaInfo for Ubuntu 10.04 LTS without the bug:
> > > >>>
> > >
> http://www.alsa-project.org/db/?f=5824e55345c3f7128937405254485a489886b9dc
> > > >>
> > > >>
> > > >>
> > > >> It is strange that dB range of your usb audio is 0 to 0.14 (only
> > > small gain and no attenuation)
> > > >>
> > > >> In 10.04 LTS pulseaudio provide software volume control
> > > >>
> > > >>
> > > >> ( 1.095| 0.000) I: alsa-sink.c: Driver does not support hardware
> > > volume control, falling back to software volume control.
> > > >>
> > > >>
> > > >> control.6 {
> > > >> comment.access 'read write'
> > > >> comment.type INTEGER
> > > >> comment.count 1 comment.range '0 - 37'
> > > >> comment.dbmin 0 comment.dbmax 14
> > > >> iface MIXER
> > > >> name 'Speaker Playback Volume' value 30 }
> > > >>
> > > >>
> > > >>  In 12.04 pulseaudio did not provide software volume attenuation
> > > and use the speaker playback volume control
> > > >
> > > >
> > > > So does that mean that the bug is in pulseaudio, or could it be even
> > > deeper like in the kernel or something?
> > >
> > > Are there any significant change in volume when you use "alsamixer
> > > -c0" to change speaker playback volume from min 0dB to 0.14dB ?
> > >
> > > Did pulseaudio provide software attuentation -1.61dB when the range of
> > > hardware volume control is only 0.14dB ?
> > >
> > > * index: 0
> > > name: <alsa_output.usb-0d8c_USB_Audio-00-Audio.analog-surround-71>
> > > driver: <module-alsa-card.c>
> > > flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY
> > > DYNAMIC_LATENCY
> > > state: SUSPENDED
> > > suspend cause: IDLE
> > > priority: 9049
> > > volume: 0:  94% 1:  94% 2:  94% 3:  94% 4:  94% 5:  94% 6:  94% 7:  94%
> > >         0: -1,61 dB 1: -1,61 dB 2: -1,61 dB 3: -1,61 dB 4: -1,61 dB 5:
> > > -1,61 dB 6: -1,61 dB 7: -1,61 dB
> > >         balance 0,00
> > > base volume:  99%
> > >              -0,14 dB
> > > volume steps: 65537
> > > muted: no
> > >
> > > It is strange that 5.1 headset only support 8 channels playback
> > >
> > Okay i did try "alsamixer -c0" in Ubuntu 12.04 LTS, i selected the Usb
> > Headset, Speaker was at 0 using the remote control from the headset i
> > could bring the value to 86, so if the volume is turned down the value
> > goes immideatly to 0.
> > With the alsamixer i was able to regulate the value between 0 and 100,
> > db-change is 0,01 at lowest and 0,14 at highest.
> > I could increment/decrement the db-change in steps of 0,01 (with the
> > up/down keys from the keyboard), the volume from the headset-speakers
> > follows accordingly.
> > When using anything besides the "alsamixer -c0" the volume can only be 0
> > or 86.
> > I was able to play the test sounds for: front center, front left, front
> > right, rear left,rear right and subwoofer every thing came from the
> > right direction, as expected from a 5.1 headset.
> > I was really surprised,  thank you for pointing this out, it really
> > didn't occur to me, maybe i saw the alsamixer some years ago but i
> > really couldn't remember that it was there.
>
> The reason it doesn't work with PulseAudio is that the dB information
> obtained from the hardware is pretty bogus, thus it confuses the PA
> mixer which relies purely on dB level.
>
> Have you tried any newer kernels, 3.9.x or 3.10.x, at least?
> 3.2.x is really old for debugging such a device-specific problem.
>
>
   AudioControl Interface Descriptor:
        bLength 25


 bDescriptorType 36
        bDescriptorSubtype 4 (MIXER_UNIT)
        bUnitID 12
        bNrInPins 3
        baSourceID( 0) 1
        baSourceID( 1) 9
        baSourceID( 2) 11
        bNrChannels 8
        wChannelConfig 0x063f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
          Side Left (SL)
          Side Right (SR)
        iChannelNames 0
        bmControls 0x00
        bmControls 0x00
        bmControls 0x00
        iMixer 0
        junk at descriptor end: 00 00 00 00 00 00 00 00 00

( 0.229| 0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-speaker
(Speakers), direction=1, priority=100, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=37,
min_dB=0, max_dB=0.14

( 0.229| 0.000) D: [pulseaudio] alsa-mixer.c: Element Speaker, direction=1,
switch=1, volume=1, volume_limit=-1, enumeration=0, required=0,
required_any=4, required_absent=0, mask=0x7ffffffffffff, n_channels=1,
override_map=yes

( 0.229| 0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone,
alsa_name='Headphone Jack', detection unavailable ( 0.229| 0.000) D:
[pulseaudio] alsa-mixer.c: Jack Front Headphone, alsa_name='Front Headphone
Jack', detection unavailable

( 0.229| 0.000) D: [pulseaudio] alsa-mixer.c: Jack Speaker Phantom,
alsa_name='Speaker Phantom Jack', detection unavailable

( 0.229| 0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled
synchronous volume.

( 0.229| 0.000) I: [pulseaudio] alsa-sink.c: Hardware volume ranges from
0.00 dB to 0.14 dB.

( 0.230| 0.000) I: [pulseaudio] alsa-sink.c: Fixing base volume to -0.14 dB

( 0.230| 0.000) I: [pulseaudio] alsa-sink.c: Using hardware volume control.
Hardware dB scale supported.

( 0.230| 0.000) I: [pulseaudio] alsa-sink.c: Using hardware mute control.


For your notebook , pulseaudio just add the ranges of softvol PCM, virtual
master and speaker playback volume to get the hardware volume range
-178.00 dB to 1.00 dB


( 0.497| 0.000) D: alsa-mixer.c: Activating path analog-output-speaker

( 0.497| 0.000) D: alsa-mixer.c: Path analog-output-speaker (Analog
Speakers), direction=1, priority=100, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=64,
min_dB=-178, max_dB=1

( 0.497| 0.000) D: alsa-mixer.c: Element Master, direction=1, switch=1,
volume=1, enumeration=0, required=0, required_absent=0,
mask=0x7ffffffffffff, n_channels=1, override_map=yes

( 0.497| 0.000) D: alsa-mixer.c: Element Headphone, direction=1, switch=1,
volume=3, enumeration=0, required=0, required_absent=0,
mask=0x3ff0000000000006, n_channels=2, override_map=no

( 0.497| 0.000) D: alsa-mixer.c: Element Speaker, direction=1, switch=1,
volume=1, enumeration=0, required=4, required_absent=0,
mask=0x3ff3600000000f66, n_channels=2, override_map=yes

( 0.498| 0.000) D: alsa-mixer.c: Element PCM, direction=1, switch=0,
volume=1, enumeration=0, required=0, required_absent=0,
mask=0x3600000000f66, n_channels=2, override_map=yes

( 0.498| 0.000) I: alsa-sink.c: Hardware volume ranges from -178.00 dB to
1.00 dB.

( 0.498| 0.000) I: alsa-sink.c: Fixing base volume to -1.00 dB



control.2 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 64'
comment.dbmin -6300
comment.dbmax 100
iface MIXER
name 'Speaker Playback Volume'
value.0 52 value.1 52 }

control.4 {
comment.access 'read write'
comment.type INTEGER
comment.count 2
comment.range '0 - 64'
comment.dbmin -6300
comment.dbmax 100
iface MIXER
name 'Headphone Playback Volume'
value.0 63 value.1 63 }

control.10 {
comment.access 'read write'
comment.type INTEGER
comment.count 1 comment.range '0 - 64'
comment.dbmin -6400
comment.dbmax 0
iface MIXER
name 'Master Playback Volume'
value 52 }

control.12 {
comment.access 'read write user'
comment.type INTEGER
comment.count 2
comment.range '0 - 255'
comment.tlv '0000000100000008ffffec1400000014'
comment.dbmin -5100
comment.dbmax 0
iface MIXER
name 'PCM Playback Volume'
value.0 255 value.1 255

it is strange that virtual master playback volume have a different dbmin
and dbmax from the slaves (speaker and headphone)

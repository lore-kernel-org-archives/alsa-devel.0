From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: [RFC/RFT v2 0/4] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Fri, 04 Oct 2013 03:06:11 -0400
Message-ID: <1380870371.875.14.camel@Wailaba2>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound-ss-1435.hostmonster.com
 (outbound-ss-1435.hostmonster.com [67.222.49.102])
 by alsa0.perex.cz (Postfix) with SMTP id 483EF260859
 for <alsa-devel@alsa-project.org>; Fri,  4 Oct 2013 09:06:20 +0200 (CEST)
In-Reply-To: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, linux-kernel@vger.kernel.org, Peter =?ISO-8859-1?Q?Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Anssi,

Your patch has been applied on 3.11.3


> 
> I'm especially interested in testers with:
> 
> - Older codecs other than 0x1002aa01. My best guess still is that the
>   new code works on them as well.
>   o On these I'd like to know if multichannel and the new formats
>     work, i.e. e.g.
>     speaker-test -D hdmi:CARD=Generic,DEV=0 -c8 -r192000 -F S32_LE

This is working with Codec 0x1002aa01 revisions 0x100300 (Rev ID 3)
except for a small detail. I cannot tell if it is a regression from v1
of the patch or it was there and I did not noticed when I tested.

Rear left and rear right channels are flipped.

> 
> - Codec 0x1002aa01 revisions 0x100300 (Rev ID 3) or later (see
>   /proc/asound/cardX/codec#Y). These are HD7750+ I think. Stuff to be
>   tested on these:
>   o The ramp up/down stuff, i.e. patch 4. Is there any difference seen
>     with these, in the beginning/end (i.e. fade-out/in):
>     speaker-test -D hdmi:CARD=Generic,DEV=0,AES0=0x04 -c2 -r48000

No noticeable difference than when it is run without the AES0 param

>     speaker-test -D hdmi:CARD=Generic,DEV=0,AES0=0x06 -c2 -r48000

>From the application the sound is sent normally but no sound at all is
outputed from the speakers.

>     Also, is there a difference in the beginning of these
>     (maybe garbage sound and/or slightly slower startup?):
>     aplay -Dhdmi:CARD=Generic,DEV=0,AES0=4 -r44100 -f s16_le -c2 testi.dts.cut.spdif
>     aplay -Dhdmi:CARD=Generic,DEV=0,AES0=6 -r44100 -f s16_le -c2 testi.dts.cut.spdif

Both works. No garbage is heard from neither of them. maybe maybe AES04
starts playing few ms earlier but if there is a difference, it is
extremely subtle.
> 
>   o Contents of /proc/asound/cardX/eld#0. I'd like to see the contents
>     both with radeon and with the proprietary fglrx driver in use
> 
With fglrx 13.10 Beta 2:

lano1106@whippet2 /proc/asound/card0 $ cat codec#0 
Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100300
No Modem Function Group found
Default PCM:
    rates [0x70]: 32000 44100 48000
    bits [0x2]: 16
    formats [0x5]: PCM AC3
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0, Clock-stop-OK
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=1, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x02
Node 0x04 [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x05 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x04
Node 0x06 [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x07 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Connection: 1
     0x06
Node 0x08 [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x09 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=9 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=3, device=0
  Control: name="IEC958 Playback Pro Mask", index=3, device=0
  Control: name="IEC958 Playback Default", index=3, device=0
  Control: name="IEC958 Playback Switch", index=3, device=0
  Control: name="ELD", index=0, device=9
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Connection: 1
     0x08
Node 0x0a [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x0b [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=10 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=4, device=0
  Control: name="IEC958 Playback Pro Mask", index=4, device=0
  Control: name="IEC958 Playback Default", index=4, device=0
  Control: name="IEC958 Playback Switch", index=4, device=0
  Control: name="ELD", index=0, device=10
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x0a
Node 0x0c [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x0d [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=11 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=5, device=0
  Control: name="IEC958 Playback Pro Mask", index=5, device=0
  Control: name="IEC958 Playback Default", index=5, device=0
  Control: name="IEC958 Playback Switch", index=5, device=0
  Control: name="ELD", index=0, device=11
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=06, enabled=1
  Connection: 1
     0x0c

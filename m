From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: max channels of 3 jacks 6 channels motherboard
 using model=auto realtek codec
Date: Thu, 20 Oct 2011 20:42:11 +0800
Message-ID: <CAN8ccia0V6v2fYSE3cD=9APZdm1ANr+5PYDigyfCW1MQXT=PdA@mail.gmail.com>
References: <CAN8cciZ58WH+sctP0DsaHsEBgkCpPPEHDpf3J=tVMaxvk+RRkg@mail.gmail.com>
	<s5hy60cdln2.wl%tiwai@suse.de>
	<CAN8cciZimvz1MnnWKXoaq+hNTwO8BcSoWyq7ga12EGE-KNBt-w@mail.gmail.com>
	<s5h4o2uiqct.wl%tiwai@suse.de> <s5h4o2onco4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6496E24789
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 14:42:13 +0200 (CEST)
Received: by bkbzs8 with SMTP id zs8so3407485bkb.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2011 05:42:11 -0700 (PDT)
In-Reply-To: <s5h4o2onco4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/7/14 Takashi Iwai <tiwai@suse.de>:
> At Sun, 10 Jul 2011 08:47:46 +0200,
> Takashi Iwai wrote:
>>
>> At Sun, 10 Jul 2011 11:31:44 +0800,
>> Raymond Yau wrote:
>> >
>> > 2011/7/6 Takashi Iwai <tiwai@suse.de>:
>
> The smart51 case is a bit different (we prefer DAC unused because of
> independent HP control), but the 3stack-6ch case is a regression,
> indeed.  This was just because of dropped code snippet.
>

How about SIgmatel/IDT codecs ? e.g Intel Desktop Board D946GZIS

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/820092

Why there is no "channel mode" switch ?

How does PA server change from "stereo" to "surround40" or
"surround51" profile ?

Refer to Documentation/alsa/HD-Audio-Controls.txt

SIgmatel/IDT codecs

* Mic Jack Mode, Line Jack Mode, etc
  These enum controls the direction and the bias of the input jack
  pins.  Depending on the jack type, it can set as "Mic In" and "Line
  In", for determining the input bias, or it can be set to "Line Out"
  when the pin is a multi-I/O jack for surround channels.



http://www.intel.com/support/motherboards/desktop/d946gzis/sb/CS-022973.htm

Refer to Intel Desktop Board D946GZIS Product Guide

* Front panel audio connector, including functionality for:
  -- Line out
  -- Microphone in

Back panel audio connectors that are configurable through the audio device
drivers:
-- Line in/retasking jack
-- Line out/retasking jack
-- Mic in/retasking jack


using hda-emu

hda-emu codecs/stac9227-intel-d946gzis-mobo

hda_codec: STAC9227: BIOS auto-probing.
autoconfig: line_outs=3 (0xd/0xf/0xe/0x0/0x0) type:speaker
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   inputs: Mic=0xb


CTRL: add: Speaker Playback Volume:0
CTRL: add: Speaker Playback Switch:0
CTRL: add: Speaker Playback Volume:1
CTRL: add: Speaker Playback Switch:1
CTRL: add: Center Playback Volume:0
CTRL: add: Center Playback Switch:0
CTRL: add: LFE Playback Volume:0
CTRL: add: LFE Playback Switch:0
CTRL: add: Swap Center/LFE Playback Switch:0
CTRL: add: Front Mic Jack Mode:0
CTRL: add: Beep Playback Volume:0
CTRL: add: Beep Playback Switch:0
CTRL: add: Headphone Playback Volume:0
CTRL: add: Headphone Playback Switch:0
CTRL: add: Capture Volume:0
CTRL: add: Capture Switch:0
CTRL: add: Capture Volume:1
CTRL: add: Capture Switch:1
CTRL: add: Capture Volume:2
CTRL: add: Capture Switch:2
CTRL: add: Mux Capture Volume:0
CTRL: add: Mux Capture Volume:1
CTRL: add: Mux Capture Volume:2
CTRL: add: IEC958 Playback Source:0
CTRL: add: Master Playback Volume:0
Cannot find slave Front Playback Volume, skipped
Cannot find slave Surround Playback Volume, skipped
Cannot find slave Side Playback Volume, skipped
CTRL: add: Master Playback Switch:0
Cannot find slave Front Playback Switch, skipped
Cannot find slave Surround Playback Switch, skipped
Cannot find slave Side Playback Switch, skipped
Cannot find slave IEC958 Playback Switch, skipped
JACK created Headphone, type 1
JACK created Line-out, type 4
JACK created Line-out, type 4
JACK created Line-out, type 4
JACK created Mic, type 2


> get 10
send: NID=0xb, VERB=0xf07(get_pin_ctl), PARM=0x0
receive: 0x24
10 Front Mic Jack Mode:0
ITEM: 0:Mic In, 1:Line In, VAL: [Mic In]

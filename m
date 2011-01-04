From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: VIA VT1708 bugs
Date: Tue, 4 Jan 2011 22:15:17 +0800
Message-ID: <AANLkTikFn_=ahsZQWf=KBvTxjvzZWMgtfMoM_J7nkG-=@mail.gmail.com>
References: <4D22C24A.1080302@canonical.com>
	<AANLkTik8uKj97GOOOtPuftePUDcs01nP8aAHsOtAmiZE@mail.gmail.com>
	<4D22E69E.1000101@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 504311038FC
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 15:15:18 +0100 (CET)
Received: by eyg24 with SMTP id 24so5957867eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 04 Jan 2011 06:15:17 -0800 (PST)
In-Reply-To: <4D22E69E.1000101@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/4 David Henningsson <david.henningsson@canonical.com>

> On 2011-01-04 08:43, Raymond Yau wrote:
> > 2011/1/4 David Henningsson<david.henningsson@canonical.com>
> >
> >> Hi,
> >>
> >> the state of VIA VT1708 in the current kernel is far from optimal. It
> >> would be good to improve the situation, at least for 2.6.38. On the
> >> machine here, I experience at least these bugs:
> >> 3) Several users report headphones output being broken
> >>
> >> * Symptoms vary a little and some might be due to bug 2), but some
> >> however report the headphones volume being "grayed out" in alsamixer. I
> >> haven't seen that in particular on the hardware here.
> >>
> >> 4) All these extra controls - "Independent HP", "Jack Detect", "Smart
> 5.1"
> >>
> >
> > Independent headphone
> >
> > http://www.viaarena.com/forums/showthread.php?t=41015
>
> Ok, that makes some sense. It translates to me as
> * With independent HP turned off - activates auto-mute between
> speaker-out/line-out and headphone out. Note the difference between VIA
> and Realtek/Sigmatel here as line-out are auto-muted as well.
>

Those video about realtek and IDT codec are all Intel DESKTOP motherboard

line out does not auto mute because of multi streaming playback

For example, you can listen to one audio source through the back panel
speakers and a second audio source through front panel headphones or
speakers.


> * With independent HP turned on - headphone out and speaker-out/line-out
> should take output from different PCM subdevices.
>
> > "Smart 5.1"  similar to switch "channel mode" from 2 to 6 in intedl
> > desktop motherboard with 3 audio jacks in rear panel
>
> But does turning "Smart 5.1" on, mean that mic-in and line-in are always
> turned into C/LFE and Back L/R jacks, or is it trying to do some kind of
> autodetection of the current thing plugged in?
>

"Smart 5.1" is not specific to VIA HDA codec, it first appear in those
onboard ac97 motherboard

http://www.viaarena.com/via-mainboards-smart-51.aspx?ID=76&MCatID=1

smart 5.1

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=1564b2878f5cf160f60af99d4dbca1dd7809ee8a


http://www.via.com.tw/en/products/audio/codecs/vt1708b/index.jsp

To support 7.1 using 8 channels dac require retask headphone as side (I
guess the motherboard only has 5 audio jacks in rear panel )


Jack detect

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=1f2e99febd5dd0c91f0d0752674029a4376649e5

I think the default value of "smart5.1" switch should be :"no" instead of
"Yes"

This mean that the driver should not create "smart5.1" for those 10 channels
dac hda codec

May be the best way is  "Gnome Sound Preference" should check whether the
user can select surround 51 profile if rear mic/line  is selected as input
source whenever the sound card has "Smart5.1" switch or "channel mode"
switch and vice versa


All those micro ATX size motherboard has only 3 audio jacks in the rear
panel

on-board sound drivers use ac97 codec (e.g ATIIXP, ICH, ICH4 , VIA8233,
VIA8233A , VIA8237 , NFORCE ) have the "channel mode" switch in surround40
or surround51

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/<http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/ATIIXP.con>

From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Headphone output problems with HP ProDesk 600 G1
	(Realtek ALC221)
Date: Thu, 20 Feb 2014 09:41:24 +0800
Message-ID: <CAN8ccia3a2_Eau4hoLAN6xXFogdXZZx8o=J=Z_1hYunn=8QzqQ@mail.gmail.com>
References: <CAN8cciabECOHSBC0N0WP1nb17+HsLRDD9xEUn8LcmuuBsVH+3w@mail.gmail.com>
 <CADLC3L2B_osxvrVaT-MEbGrPWf99C7eHyzw6NZZvB8ayFxJgfg@mail.gmail.com>
 <CAN8ccia-cja=_Qh1cwtpvwoxB21F1MVAWYD9reefOn5z7Z0szQ@mail.gmail.com>
 <CADLC3L0PEC_sVrw-+PpQkodvFKOFNicvdL3M5LbiO1Ok8yKkbQ@mail.gmail.com>
 <CAN8ccibdTiSp+-=C6TLPsAbwXmZ=iABAK4Hh9hXALsZAauArdg@mail.gmail.com>
 <CADLC3L3mOfpmAUhrDuo0esCvJ2_VYMyCU2dp_1c7vOcuyWxS2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
 [209.85.216.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D3F926537D
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:41:27 +0100 (CET)
Received: by mail-qa0-f50.google.com with SMTP id cm18so1935364qab.23
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:41:24 -0800 (PST)
In-Reply-To: <CADLC3L3mOfpmAUhrDuo0esCvJ2_VYMyCU2dp_1c7vOcuyWxS2Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2014-02-20 0:31 GMT+08:00 Robert Hancock <hancockrwd@gmail.com>:

> On Tue, Feb 18, 2014 at 8:58 PM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
> >> > autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> >> >     speaker_outs=1 (0x17/0x0/0x0/0x0/0x0)
> >> >     hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> >> >     mono: mono_out=0x0
> >> >     inputs:
> >> >       Mic=0x1a
> >> >       Line=0x1b
> >> >
> >> > do you mean one of the front panel jacks support TRRS headset ?
> >>
> >> I think that is what the labelling is indicating, yes.
> >
> >
> >
> http://h20566.www2.hp.com/portal/site/hpsc/public/psi/manualsResults/?sp4ts.oid=5387447
> >
> > refer to the maintenance and service guide
> >
> > When a device is plugged into the Microphone/Headph
> > one Connector, a dialog box will pop up asking if
> > you want to use the connector for a microphone Line-In
> > device or a headphone. You can reconfigure the connector
> > at any time by double-clicking the Audio Manager icon in the Windows
> taskbar
> >
> >
> >  the hardware reference guide and Illustrated Parts and Service map
> >  microphone jack and headphone jack
> >
> > it seem not support TRRS headset
> >
> > Do the icon really show a headset ( headphone with mic) ?
>
> I suppose not, it just has a headphone and a microphone. I assume it's
> quite possible that it only supports one at a time.
>

headphone mic jack mode is supported for those computer with only one jack
and alsa driver use special sequencer number to identify

the pinctl of a retasktable jack is changed from OUT to IN and vice/versa

the pin complex is retaskable when the pincap support both IN and OUT


https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ced4cefc75fdb8be95eaee325ad0f6b2fc0a484b

>>
>> >
>> > use hda-jack-sense-test to find the nodes of front panel jacks and rear
>> > panel jacks
>>
>> From what I can tell:
>>
>> When the headphone-only jack is plugged into, nothing happens with jack
>> sensing
>> When the headphone/mic jack is plugged into, both Pin 0x1a (Black Mic)
>> and Pin 0x21 (Black HP Out) show present
>> When the rear line out jack is plugged into, Pin 0x14 (Green Line Out)
>> shows present
>> When the rear line in jack is plugged into, nothing happens with jack
>> sensing
>
>
> did you use "-a" option for hda-jack-sense-test ?

That did give one more result: when plugging in the headphone-only
> jack, 0x18 (Not connected) reports present. I'm not sure if node 0x18
> is actually related to the headphone for anything other than the jack
> sensing, though, as none of the settings for that node in hda_analyzer
> have any effect on the audio output on that jack (even the mute).
>

did you set pin ctl to OUT HP of node 0x18 ?


>
> As I mentioned in the Bugzilla report, as it turns out, with default
> settings I can get audio to play out from the headphone jack with the
> "Analog Output" mode selected in PulseAudio. The big problem is that
> the audio is distorted with hiss and popping noises, which I haven't
> been able to figure out at all. Any suggestions?
>

do pulseaudio log show any path is removed since you don't have headphone
playback volume or front playback volume , front playback switch?

try hint jack_detect=0 to disable all jack detection of all jacks

and use hda-analyzer to mute /unmute the pin complex of line out and
headphone

the other thing you can try is use hda-jack-retask to change internal
speaker as [N/A] , this allow line out and headphone get it own volume
control and audio output

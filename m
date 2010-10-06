From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixertest
Date: Wed, 6 Oct 2010 12:08:14 +0800
Message-ID: <AANLkTinQu27XEaohOER-RkV3sm_rMPfRrhxisX0psgcg@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru> <i7qltg$bph$1@dough.gmane.org>
	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
	<4CA306CB.1090305@canonical.com>
	<AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
	<4CA9877F.7060009@canonical.com> <4CA9C22A.2010104@ladisch.de>
	<4CA9C7BE.7020804@canonical.com> <4CA9C9E6.7070706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 048C724362
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 06:08:15 +0200 (CEST)
Received: by eye27 with SMTP id 27so2761585eye.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Oct 2010 21:08:15 -0700 (PDT)
In-Reply-To: <4CA9C9E6.7070706@ladisch.de>
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

2010/10/4 David Henningsson <david.henningsson@canonical.com>

> On 2010-10-02 04:11, Raymond Yau wrote:
> > 2010/9/29 David Henningsson<david.henningsson@canonical.com>
> >
> >> On 2010-09-28 06:07, Raymond Yau wrote:
> >>> 2010/9/28 Colin Guthrie<gmane@colin.guthr.ie>
> >>>
> >>>>
> >>>>
> >>>> And today, one of the Canonical guys published his version of a tool
> to
> >>>> help here:
> >>>> http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/7542
> >>>>
> >>>> Hope this helps.
> >>>>
> >>>> Col
> >>>>
> >>>>
> >>>>
> >>> why did runtest.sh use a format  FLOAT64_LE which was not supported by
> PA
> >> ?
> >>
> >> runtest.sh isn't meant to be used directly in that way, you're supposed
> >> to run "alsamixertest". Try "alsamixertest -r" and "alsamixertest -h" to
> >> get started. (Perhaps I should rename the .sh file to something else.)
> >>
> >> That said, if you find a good use case where you want to use it directly
> >> and need a different sample format - patches welcome (as long as they
> >> don't break something else).
>

if it can be used to test the dB scale of the hardware, it can also be used
to verify the dB reported by Gnome Sound Preference and Kmix



> >>
> >>
> > I just try to see whether this tool can help me to calibrate the 10 band
> > gain/atten controls of the hardware equalizer of au8830.
>
> Hmm...there is currently no way to specify control name(s) manually,
> perhaps I should add such a test/switch.
>

Do I need to use same sine wave file or sine wave of different frequency for
the different bands (31Hz, 63Hz, 125Hz, 250Hz, 500Hz, 1KHz, 2KHz, 4 KHz,
8KHz and 16KHz) when testing the 10 bands gain/atten controls of the graphic
equalizer

Do I need to use "speaker-test -t sine -f " instead of  "aplay sine.wav" for
generating sine wave of different frequency?

Any special requirement (e.g. amplitude, frequency, duration of the
recording) of the signal for powerfft to calculate the data on a 32bit
machine?

There is an un-calibrated "EQ peak" control which can obtain the peak value
of 10 bands from au8830 chip at any time.



>
> > Have anyone test your tool on the sound card with ac97 codec ?
>
> I don't think so, no.
>

Why the program only test the volume below 0 dB ?

The dB range of "PCM" volume control of ac97 is  -34.5dB to +12dB



>
> > It seem that the program keep complain about those controls without dB
> scale
> > (e.g. AC97 3D Control - depth and rear depth , .) with the emulated
> intel8x0
> > driver  and no volume control with the emulated sb16 in virtualbox
>
> It's a righteous warning if you ask me - all volume controls should
> provide dB information, or we don't know what they actually do. It
> doesn't disturb the rest of the test as long as you have set the value
> manually to something that does not destroy the audio.
>

Those are 3D effect defined in AC97 codec specification ,  I guess they have
some effect on your calculation if they are not disabled

if you are using the same card for playback/recording , you have to mute
those "Mic", "Video", "CD", "Aux" , "Phone" and "Line" playback volume
controls for a clean playback.
Especially "Line" Playback Volume if the test is done by connecting "Line
Out" to "Line In" with an loopback cable.

Some codec may has specific feature which affect the volume of the output

(e.g. STAC9708 has a "Sigmatel Surround" control which act as "Front/Rear"
balance and the name of this control is "Front/Rear Fader" in windows)
When this "Sigmatel Surround" playback switch is unmuted, you can still hear
sound even if you mute the "PCM" Playback switch


>
> > Your program seem really behave as same as pulseaudio server , set the dB
> > value of control but don't verify the dB value can be set by re-reading
> the
> > value since dB ->  volume conversion
>
> Yes, I do verify: I read back the set value because it is not always the
> same as the actual value I tried to set.
>
> > Even though your program start at 0dB  , ac97 volume controls are in
> 1.5dB
> > per step but your program use 2 dB step
>
> I just released a new version where you can set the step size at the
> command line:
>
>
> https://edge.launchpad.net/~diwic/+archive/maverick/+files/alsamixertest_48.11.tar.gz<https://edge.launchpad.net/%7Ediwic/+archive/maverick/+files/alsamixertest_48.11.tar.gz>
>
>

 Are you sure that the approach of your program is correct ?



 If 1.5 dB is pretty standard in both HDA and AC'97, I should probably
> change it to 1.5 dB by default.
>


No, there are four type of dB info

a) SNDRV_CTL_TLVT_DB_SCALE
b) SNDRV_CTL_TLVT_DB_LINEAR
c) SNDRV_CTL_TLVT_DB_MINMAX

http://thread.gmane.org/gmane.linux.alsa.devel/64055

d) SNDRV_CTL_TLVT_DB_RANGE

http://thread.gmane.org/gmane.linux.alsa.devel/73114


those controls of hda-intel codec and ac97 codec have fixed dB per step
because they belong to TLV_DB_SCALE, but there are sound cards with controls
belong TLV_DB_LINEAR which does not have fixed dB per step (e.g. emu10k1,
....)


1) curr_dB -= stepdB

amixer -D hw:0 -- sset 'Master' -2.0dB
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 29 [94%] [-3.00dB] [on]
  Front Right: Playback 29 [94%] [-3.00dB] [on]

amixer -D hw:0 -- sset 'PCM' 2.0dB
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 24 [77%] [1.50dB] [on]
  Front Right: Playback 24 [77%] [1.50dB] [on]

Are you sure that your program 48-11 does read back the dB value -3 or 1.5
for calculation when it try to set dB to -2 or 2 ?


The ALSA volume control allow you to change the volume between the Limits
e.g. The limits of the AC97 Master is  0 - 31 and PCM is 0 - 31
The dB scale is only defined at those 32 points only

The "Master" and "PCM" volume control provide  32+32=64 level of playback
volume

it is just total 64 discrete points if you plotted dB and volume step on a
graph but your program and PA seem expect it is a continuous line

e.g. The number of step of PA 's Master is 65536 ,
how did PA map 65536 steps to 64 steps of AC97 "Master" and "PCM" controls?
PA need to provide software atten (65536-64) out of 65536 times since the
internal format is FLOAT


Should the program test from the max volume to min volume and use
ask_volume_dB() for each step to compare the result of the test ?


2) While True:
        if cond:
            break;

the cause of the infiinte loop is due to the "While True:" loop

if the control has fixed number of step(e.g.   Limits: Playback 0 - 31) ,

why do your program  need to run the test inside a while True loop since the
ALSA control api does not allow your program to set dB outside the allowed
range ?

unless your program can write value to ac97 registers using /proc and
compiled the driver in debug mode

e.g. https://bugs.kde.org/show_bug.cgi?id=249508

when the driver limit the min db to -60 dB , you are unlikely to set dB
value below -60dB
unless you revert the patch

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=eacbb9dba6b4c982a0217ea2c7d15db88d4fda37;hp=d91b424d6d7bda0773b6b6b606d48d089c4f5115



> > Still finding why the program running into infinite loop and try to set
> dB
> > to -7xx dB , however amixer does output the min dB when 0%
>
> If you're still having an infinite loop in the 48.11 version, could you
> please send the output of the tool with the -v (verbose) switch to me
> privately? Thanks!
>
> --
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic <http://launchpad.net/%7Ediwic>
>

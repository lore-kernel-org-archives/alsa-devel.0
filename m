From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA: Sound mutes when combination is below -48 dB
Date: Mon, 27 Dec 2010 13:56:16 +0800
Message-ID: <AANLkTi=pbDovm9vjA1Je0dOC7ezZNA67OnwFs67sCOLL@mail.gmail.com>
References: <4CF8D4BA.8080904@canonical.com> <s5hlj47ukx2.wl%tiwai@suse.de>
	<4CF90DF6.7020008@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 381B110381C
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 06:56:17 +0100 (CET)
Received: by eyg24 with SMTP id 24so3790895eyg.38
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2010 21:56:16 -0800 (PST)
In-Reply-To: <4CF90DF6.7020008@canonical.com>
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

2010/12/3 David Henningsson <david.henningsson@canonical.com>

> On 2010-12-03 12:59, Takashi Iwai wrote:
> > At Fri, 03 Dec 2010 12:30:02 +0100,
> > David Henningsson wrote:
> >>
> >> I'm trying to nail down a strange behaviour. I have one "Master" and one
> >> "Speaker" (or "Headphone") volume control, each ranging from -48 dB to 0
> >> dB. Whenever the sum of "Master" and "Speaker" is below -48 dB, the
> >> output mutes. Codec is attached.
> >>
> >> "Master" is a "Virtual master" control, and both "Master" and "Speaker"
> >> control amp-out on nid 0x13. Nid 0x13 does not have amp-out caps, but
> >> the AFG specifies a range of -96 dB to 0 dB in 0.75 dB steps.
> >>
> >> There is some strange things here. First, in
> >> patch_sigmatel:create_controls_idx, there is this comment:
> >>
> >>              /* if dB scale is over -64dB, and finer enough,
> >>               * let's reduce it to half
> >>               */
> >> Hmm? Removing half of the volume slider?
> >>
> >> Second, assuming we actually buy this decision, wouldn't it make sense
> >> for people to be able to combine Master and Speaker to get the full -96
> >> to 0 dB range? Instead, "Master" is just working over the range defined
> >> by "Speaker".
> >
> > Well, the problem was fairly old.  You must think of the world before
> > anything dB evaluation was introduced in the mixer apps.  They just
> > took a percentage value, so we got to cut it off to give some "usable"
> > interface for them.
> >
> > The biggest problem right now is that you can't take it back so easily
> > "just for PA".  The PCM softvol is also the same.  There is no perfect
> > solution, and PA isn't by 100% people here.  However, we must not give
> > a regression in 100% manner.
>
> Ok. I'm not certain I agree, but I see your point.
>

Seem that softvol plugin "PCM playback volume" really follow the OSS
emulation "PCM" volume which mute at 0% , so is this a bug which report
-51dB to the alsa application ?

Do softvol plugin need to use TLV_DB_SCALE_MUTE too ?


>
> >
> > OK, let's back to the bug point...
> >
> >> Third, there is an interesting condition in
> hda_codec.c:update_amp_value:
> >>
> >>      if (val>  0)
> >>              val += ofs;
> >>
> >> Now this is in practice turning all volume controls which have ofs (e g
> >> those being "reduced to half") to a minimum-is-mute error: I can set the
> >> amp value to either 0 (-96 dB) or the 65 - 127 range (~ -48 dB - 0 dB).
> >> So it isn't really mute, it's -96 dB signal, but I can't hear that
> anyway.
> >
> > OK, this looks really like a bug that the driver gives min-mute flag.
> > The min-mute flag should be given only for the STAC codecs with lower
> > resolution, such as STAC9200.  It seems that STAC925x (and STAC9202)
> > are also in this category, while STAC9205 and other IDT codecs have
> > higher resolutions.
> >
> > Since both STAC9200 and STAC925x have own Master definition, the
> > simplest solution is to remove TLV_DB_SCALE_MUTE for vmaster like
> > below...
>
> I've tried it, but it doesn't help. Test case is simple: run the codec
> attached to the previous mail in hda-emu [1]. Then turn "Master" down
> from 64 to 60, or anything that makes the combination of "Master" and
> "Speaker" less than -48 dB, and notice that the amp value sent to the
> codec is 0x0 (i e -96 dB).
>
> [1] If I never thanked you for that program, I do so now, it is a really
> great tool!
>
>
Just using your alsamixertest-48.11 to test hda sound card

When using -i plughw:1

INFO:root:Running test for mixer PCM, level -3.000000 dB
INFO:root:Running test for mixer PCM, level -6.000000 dB
INFO:root:Running test for mixer PCM, level -9.000000 dB
INFO:root:Running test for mixer PCM, level -12.000000 dB
INFO:root:Running test for mixer PCM, level -15.000000 dB
INFO:root:Running test for mixer PCM, level -18.000000 dB
INFO:root:Running test for mixer PCM, level -21.000000 dB
INFO:root:Running test for mixer PCM, level -24.000000 dB
INFO:root:Running test for mixer PCM, level -27.000000 dB
INFO:root:Running test for mixer PCM, level -30.000000 dB
INFO:root:Running test for mixer PCM, level -33.000000 dB
INFO:root:Running test for mixer PCM, level -36.000000 dB
INFO:root:Running test for mixer PCM, level -39.000000 dB
INFO:root:Running test for mixer PCM, level -42.000000 dB
INFO:root:Running test for mixer PCM, level -45.000000 dB
INFO:root:Running test for mixer PCM, level -48.000000 dB
ERROR:root:Error 5: Mixer PCM mutes the signal at -51.000000 dB.


using -i plug:front as the same way as  PA server

The dB value  measured by your program is double of the value and this
proves that the softvol control "PCM Playback Volume" has effect on both
playback stream and capture stream to get this kind of result

why PA server still use "front" device for capture when the most common
sound card have these problem ?

 ./alsamixertest.py -i plug:front:1 -o plug:front:1 -m hw:1  --step=3
set(['Front', 'Master Front', 'Master', 'Hardware Master', 'PCM'])
...
INFO:root:Running initial test signal.
INFO:root:Testing that Master actually mutes the signal
INFO:root:Testing that Front actually mutes the signal
INFO:root:Running test for mixer Master, level -3.000000 dB
INFO:root:Running test for mixer Master, level -6.000000 dB
INFO:root:Running test for mixer Master, level -9.000000 dB
INFO:root:Running test for mixer Master, level -12.000000 dB
INFO:root:Running test for mixer Master, level -15.000000 dB
INFO:root:Running test for mixer Master, level -18.000000 dB
INFO:root:Running test for mixer Master, level -21.000000 dB
INFO:root:Running test for mixer Master, level -24.000000 dB
INFO:root:Running test for mixer Master, level -27.000000 dB
INFO:root:Running test for mixer Master, level -30.000000 dB
INFO:root:Running test for mixer Master, level -33.000000 dB
INFO:root:Running test for mixer Master, level -36.000000 dB
INFO:root:Running test for mixer Master, level -39.000000 dB
INFO:root:Running test for mixer Master, level -42.000000 dB
INFO:root:Running test for mixer Master, level -45.000000 dB
INFO:root:Running test for mixer Master, level -48.000000 dB
INFO:root:Running test for mixer Master, level -51.000000 dB
INFO:root:Running test for mixer Master, level -54.000000 dB
INFO:root:Running test for mixer Master, level -57.000000 dB
INFO:root:Running test for mixer Master, level -58.500000 dB
ERROR:root:Error 5: Mixer Master mutes the signal at -60.000000 dB.
INFO:root:Running test for mixer PCM, level -3.000000 dB
WARNING:root:Mixer PCM is 2.991528 dB off at -3.000000 dB.
INFO:root:Running test for mixer PCM, level -6.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-6.000000, expected
-9.726178 dB but measured -15.716394 dB.
INFO:root:Running test for mixer PCM, level -9.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-9.000000, expected
-12.726178 dB but measured -21.838096 dB.
INFO:root:Running test for mixer PCM, level -12.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-12.000000,
expected -15.726178 dB but measured -27.715342 dB.
INFO:root:Running test for mixer PCM, level -15.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-15.000000,
expected -18.726178 dB but measured -33.712999 dB.
INFO:root:Running test for mixer PCM, level -18.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-18.000000,
expected -21.726178 dB but measured -39.919739 dB.
INFO:root:Running test for mixer PCM, level -21.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-21.000000,
expected -24.726178 dB but measured -45.718424 dB.
INFO:root:Running test for mixer PCM, level -24.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-24.000000,
expected -27.726178 dB but measured -51.824640 dB.
INFO:root:Running test for mixer PCM, level -27.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-27.000000,
expected -30.726178 dB but measured -57.709120 dB.
INFO:root:Running test for mixer PCM, level -30.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-30.000000,
expected -33.726178 dB but measured -63.726170 dB.
INFO:root:Running test for mixer PCM, level -33.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-33.000000,
expected -36.726178 dB but measured -69.971399 dB.
INFO:root:Running test for mixer PCM, level -36.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-36.000000,
expected -39.726178 dB but measured -75.738969 dB.
INFO:root:Running test for mixer PCM, level -39.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-39.000000,
expected -42.726178 dB but measured -81.733219 dB.
INFO:root:Running test for mixer PCM, level -42.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-42.000000,
expected -45.726178 dB but measured -87.774599 dB.
INFO:root:Running test for mixer PCM, level -45.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-45.000000,
expected -48.726178 dB but measured -93.806418 dB.
INFO:root:Running test for mixer PCM, level -48.000000 dB
ERROR:root:Error 6: Mixer PCM has invalid dB data for dB=-48.000000,
expected -51.726178 dB but measured -99.685773 dB.
INFO:root:Running test for mixer PCM, level -51.000000 dB

From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Codec VIA VT2020/VT1718S and questions about commit
	4ab2d53a99b6dcee86837d2a9739bfb9f468db45
Date: Thu, 16 Jun 2011 20:35:52 +0200
Message-ID: <BANLkTiky0K_Tx=jB4+sY4-d9Lk=ZghRHJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D275B2444B
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 20:35:56 +0200 (CEST)
Received: by wwf26 with SMTP id 26so1397226wwf.20
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 11:35:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lydiawang@viatech.com.cn
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I've been looking into the code of alsa drivers (mainly hda and
patch_via.c), with help by Raymond Yau (many thanks to him) after a
problem making my system work with a sound driver newer than version
1.0.21 (at last, I fixed it by recompiling alsa-lib to use device
files in /dev as created by udev with correct minor numbers - original
subject of that discussion on alsa-devel mailing list is "Via VT2020:
issues with kernel 2.6.38.{2, 3} (alsa 1.0.23) - working with 2.6.33.2
(alsa 1.0.21)").

My system is a no-brand desktop, with an asrock motherbord (model
890GX Extreme3) embedding an audio codec VIA VT2020 (beside ATI HDMI).
That should support 7.1 speaker systems, plus eventually a headset
connected to a front audio panel in multistream mode (since VT1718S
seems to support as much as 10 playback channles, as per channels_max
field in static const struct hda_pcm_stream
vt1718S_pcm_analog_playback, file patch_via.c). Though, my motherboard
holds no grey (side) jack (would be nid 0x27), and it would seem that
blue (line-in) jack (0x2a) should be retasked as side output (it would
use AOW 0x0c, actually used for Independent HP mode, but I've tested,
with help by Raymond Yau, and can confirm 0x0b can be used instead by
front panel line-out - it's in the connection list for nid 0x34,
labeled "Independent HP", which connects to 0x1b and thus to 0x28,
"Headphone Playback Switch"). We were trying to fix it (most of the
code, about all the code about that, coming from him, I'm just
testing/reviewing it and looking into some other, perhaps more general
and maybe minor, issues). But now we'd have a concern about a piece of
code within struct hda_verb vt1718S_volume_init_verbs[], as modified
by you in commit 4ab2d53a99b6dcee86837d2a9739bfb9f468db45,
specifically the following part:


@@ -4264,7 +4265,7 @@ static struct hda_verb vt1718S_volume_init_verbs[] = {
        {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
        {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
        {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
-       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
+       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},

        /* Setup default input of Front HP to MW9 */
        {0x28, AC_VERB_SET_CONNECT_SEL, 0x1},


My system (codec vt2020) has only 5 connections to nid 0x21:


Node 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Rear Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Rear Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x1f 0x1f] [0x1f 0x1f] [0x1f 0x1f] [0x97 0x97]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 5
     0x2c 0x2b 0x2a 0x29 0x28


and that seems to be the same for other vt1718s codec implementations
(by asrock): https://launchpadlibrarian.net/70606587/Card0.Codecs.codec.0.txt
 (motherboard ASRock H55M Pro, more info at
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/772638 ),
therefore your code seems to access a non-existing connection. Since
such looks like not very safe/correct, Raymond Yau had suggested to
change it into:


-       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},
+       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},


which seems to work (or at least to cause no problem) on my system.
However, after finding your commit, we wonder if that could be
necessary for the machine (e.g. because of internal functioning, I'm
_not_ asking you to disclose, of course), so I'm writing you to ask
for some clarification, as far as possible.

Moreover, I have some doubts about the rest of that patch:


@@ -4255,7 +4255,8 @@ static struct hda_verb vt1718S_volume_init_verbs[] = {
        {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
        {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},

-
+       /* Enable MW0 adjust Gain 5 */
+       {0x1, 0xfb2, 0x10},
        /* Mute input amps (CD, Line In, Mic 1 & Mic 2) of the analog-loopback
         * mixer widget
         */


In my system, MW0 (first audio mixer widget) seems to be nid 0x18 (0x1
being AFG Function Id) and I haven't been able to find infos about
verb 0xfb2; commenting it out seems to cause no problem, however that
may look like an implementation-specific verb to be sent to a special
connection (as a part of VIA internals I'll never ask you to
disclose), so I'll be grateful to you if you can just tell me if
that's specifically needed and must be there.

Furthermore:


        /* Setup default input of Front HP to MW9 */
        {0x28, AC_VERB_SET_CONNECT_SEL, 0x1},


(this part not created by that commit of yours)

My system seems to have only 6 Audio Mixer Widgets (0x18, 0x19, 0x1a,
0x1b, 0x1c and 0x21 - unless any Vendor Defined Widget is taken into
account), as it seems to be for vt1718S codec as described in links
above; in both cases 0x28 has one only connection:

vt2020 (mine):

Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=21, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1b


vt1718s (linked above):

Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=05, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1b


Thus, it would seem (to me, at least) more natural (and correct) to
initialize it by selecting connection 0 (the only existing one - or
none at all, since the only one should be selected by the hardware by
default), unless there's some specific reason for that (e.g. other
codec implementations with more than one connection to 0x28, or
internal need for that).

Could there be the need to create different initialization verb arrays
for different flavours of VT1718S?

Many thanks in advance for your answers.
Best regards.

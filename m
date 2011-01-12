From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_hda_intel: regression from kernel 2.6.36 ->
	.37 (Microphone)
Date: Wed, 12 Jan 2011 14:10:43 +0800
Message-ID: <AANLkTinQkbqJ-eRO9LCVsPVewgWCYBMBLjsDyFtwjhTu@mail.gmail.com>
References: <ighq3i$9b8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8194724402
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 07:10:49 +0100 (CET)
Received: by eyg24 with SMTP id 24so80597eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 22:10:46 -0800 (PST)
In-Reply-To: <ighq3i$9b8$1@dough.gmane.org>
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

2011/1/11 Wolfgang Scheicher <wolfgang.scheicher@gmail.com>

>
> I used kernel 2.6.36 from debian experimental for quite some time now,
> without any problem:
> http://www.alsa-project.org/db/?f=11290fe50066e9bcd6a244f2c83b1c66c9dd201b
>
> Upgrading to 2.6.37 from debian experimental left me unable to use my
> microphone:
> http://www.alsa-project.org/db/?f=0f29e6de98ea9fefae5c6e2adb43ff8f8eede697
>
> I also noticed some (inconsisitent?) changes in the mixer channel names,
> like "Mic" became "Rear Mic", while "Mic Boost" remained.
>
> Wolfgang Scheicher
>
> Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Front Mic Boost Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Smart 5.1", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x02a19137: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x7
    Misc = NO_PRESENCE
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1c

Node 0x2b [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Mic Boost Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00002334: IN OUT Detect
    Vref caps: HIZ 50 100
  Pin Default 0x01a19036: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x6
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x0a* 0x0c


Codec: VIA VT2020
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11060441
Subsystem Id: 0x18492620
Revision Id: 0x100100


         { .id = 0x11060441, .name = "VT2020",
           .patch = patch_vt1718S},

It seem that node 0x2b and 0x29 of your vt2020 does not has any boost since
vt2020 is using patch_vt1718s()


static struct snd_kcontrol_new vt1718S_capture_mixer[] = {

         HDA_CODEC_VOLUME("Mic Boost Capture Volume", 0x2b, 0x0, HDA_INPUT),
         HDA_CODEC_VOLUME("Front Mic Boost Capture Volume", 0x29, 0x0,
                        HDA_INPUT),





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
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x8f 0x8f]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 5
     0x2c 0x2b 0x2a 0x29 0x28

Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x0221411f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=05, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1b


Node 0x21 has only 5 connections but the driver use AMP_IN_MUTE(5) instead
of AMP_IN_MUTE(4)

node 0x28 only has one connection to 0x1b

static struct hda_verb vt1718S_volume_init_verbs[] = {



         /* Setup default input of Front HP to MW9 */
         {0x28, AC_VERB_SET_CONNECT_SEL, 0x1},


         /* Mute input amps (CD, Line In, Mic 1 & Mic 2) of the
analog-loopback
          * mixer widget
          */

         /* Amp Indices: CD = 1, Mic1 = 2, Line = 3, Mic2 = 4 */
         {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
         {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
         {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
         {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
         {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},

if if is regression , you may need to check those patches

sticky PCM stream assignment
smart5.1 mode
<http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=0e7adbe263f89ea2ef15b5af5e80a812b2a85025>

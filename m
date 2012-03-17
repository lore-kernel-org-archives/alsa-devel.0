From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Internal speaker output from Sony Vaio Z (2010
 model) lost somewhere between 3.1.0 and 3.2.6
Date: Sat, 17 Mar 2012 11:10:42 +0800
Message-ID: <CAN8cciZCV9f_MLLygK-SAmatCBGMAXwzUTKxRdxNLXZcMZXtpA@mail.gmail.com>
References: <1331939409.22414.29.camel@adam>
	<CAN8ccibZfNEd05FDwcb2XENaW7VFkkun2GFJ2xxGmLyKgzdw-g@mail.gmail.com>
	<1331950527.1841.1.camel@adam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DDAB924572
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 04:10:43 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so1346268wib.2
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:10:42 -0700 (PDT)
In-Reply-To: <1331950527.1841.1.camel@adam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Williamson <awilliam@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/17, Adam Williamson <awilliam@redhat.com>:
> On Sat, 2012-03-17 at 10:04 +0800, Raymond Yau wrote:

>
>> Does the laptop surround51 by retasking two mic jacks and headphone ?
>
> I don't _think_ so. AFAICS it only has two jacks - one
> headphone/speaker, one mic. There's no third jack anywhere that I can
> see.
> --

you may need to use hda-analyzer to find out which ext mic is correct ?

does the internal mic work or not ?


[   31.866570] ALSA sound/pci/hda/hda_codec.c:4927 autoconfig:
line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   31.866575] ALSA sound/pci/hda/hda_codec.c:4931    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   31.866579] ALSA sound/pci/hda/hda_codec.c:4935    hp_outs=1
(0x15/0x0/0x0/0x0/0x0)
[   31.866583] ALSA sound/pci/hda/hda_codec.c:4936    mono: mono_out=0x0
[   31.866587] ALSA sound/pci/hda/hda_codec.c:4940    inputs:
[   31.866591] ALSA sound/pci/hda/hda_codec.c:4944  Internal Mic=0x12
[   31.866595] ALSA sound/pci/hda/hda_codec.c:4944  Mic=0x18
[   31.866598] ALSA sound/pci/hda/hda_codec.c:4944  Mic=0x19
[   31.866601] ALSA sound/pci/hda/hda_codec.c:4946


Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x04a1102e: [Jack] Mic at Ext Right
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*



Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Mic Boost Volume", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Jack", index=1, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x04a11030: [Jack] Mic at Ext Right
    Conn = 1/8, Color = Black
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*

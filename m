From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Sun, 10 Oct 2010 21:41:23 +0200
Message-ID: <AANLkTinUWD9Oq2iAbn_nc5E+M=y4yXx4u0Eff9jYSGyk@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
	<AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
	<AANLkTinYcRqMwH2FSUjXiOxZg4x09q673FL9m15YvXEa@mail.gmail.com>
	<AANLkTik8HayTEADWn74PJ0NgjGunamsSAZpy_GanuZo3@mail.gmail.com>
	<AANLkTimz3iiXPhEarEUY1Gw5GxrTuv+UXgKKZS3ObzuS@mail.gmail.com>
	<AANLkTi=S20cpKy-CObvKB-OLDKbQ7FBhFrbnd448B+sO@mail.gmail.com>
	<AANLkTikyjZvD+ptCcgBrN2av-jQmKWOekbzvfXYAdpOV@mail.gmail.com>
	<AANLkTim_A5m2MryxmkEHtcc3gNFWTaRW8J3=dZC6wd67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CF3B10381F
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 21:41:46 +0200 (CEST)
Received: by iwn35 with SMTP id 35so121369iwn.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 12:41:45 -0700 (PDT)
In-Reply-To: <AANLkTim_A5m2MryxmkEHtcc3gNFWTaRW8J3=dZC6wd67@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 10, 2010 at 3:19 PM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> 2010/10/10 Mark Goldstein <goldstein.mark@gmail.com>
>
...
>>
>> Now, I did another additional experiment. I installed latest git
>> version of alsa driver from openSUSE =A011.3 multimedia repository and
>> got the same issue I had with 11.1 before: Line In control did not
>> work while Front Mic control actually controls Line In. So at least
>> this is consistent :-(
>>
>
> Do you mean you have already tested this patch ?
>
> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommit;h=3D0c038a076=
7e71dcda4477479b9085853e6b4cd8b
>

It is possible. The binary RPM from openSUSE multimedia repository is
called git20101007, that is dated by Oct 7th and this patch was
committed on Oct 6th.

I noticed one visible change: Input Source had "Rear Mic" instead of "Mic".

>
> Node 0x16 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
> =A0Control: name=3D"Master Front Playback Volume", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
> =A0Control: name=3D"Master Front Playback Switch", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
> =A0Control: name=3D"Mic Playback Volume", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
> =A0Control: name=3D"Mic Playback Switch", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
> =A0Control: name=3D"Line Playback Volume", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D2, ofs=3D0
> =A0Control: name=3D"Line Playback Switch", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D2, ofs=3D0
> =A0Control: name=3D"Front Mic Playback Volume", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D3, ofs=3D0
> =A0Control: name=3D"Front Mic Playback Switch", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D3, ofs=3D0
> =A0Control: name=3D"CD Playback Volume", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
> =A0Control: name=3D"CD Playback Switch", index=3D0, device=3D0
> =A0 =A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
> =A0Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
> =A0Amp-In vals: =A0[0x16 0x16] [0x19 0x19] [0x10 0x10] [0x1c 0x1c] [0x00 =
0x00]
> [0x97 0x97] [0x97 0x97]
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 7
> =A0 =A0 0x10 0x1f 0x1a 0x1b 0x1e 0x1d 0x25
>
>
> Node 0x17 [Audio Selector] wcaps 0x300501: Stereo
> =A0Control: name=3D"Input Source", index=3D0, device=3D0
> =A0Power states: =A0D0 D1 D2 D3
> =A0Power: setting=3DD0, actual=3DD0
> =A0Connection: 6
> =A0 =A0 0x1f 0x1a 0x1b 0x1e* 0x1d 0x16
>
>
> Simple mixer control 'Input Source',0
> =A0Capabilities: cenum
> =A0Items: 'Stereo Mixer' 'Mic' 'Line' 'Front Mic' 'CD'
> =A0Item0: 'Front Mic'
>
>
>>
>> What is hda-emu you mentioned? I tried searching alsa site and got nothi=
ng.
...
>
> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dblob;f=3DDocumentati=
on/sound/alsa/HD-Audio.txt
>
> hda-emu is a tool which just dumps the codec register changes and the
> ALSA-driver internal changes at probing and operating the HD-audio driver
>
> You can easily know any difference in codec register changes in the worki=
ng
> version/non working version
>
> e.g. the codec read/write when you change "input source" from mic to front
> mic or line in
>

Thanks, I downloaded it. Will read the document and try the hda-emu later.

>
> The driver deactivate "Headphone Playback Volume" and "Headphone Playback
> Mute" control if "Independent HP" mode is OFF.
>
>
>
> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommit;h=3D0713efebf=
a1a1878feeeb17cbadc3d2d2c9e9ed2
>
> control.13 {
> =A0 =A0 =A0 =A0iface MIXER
> =A0 =A0 =A0 =A0name 'Headphone Playback Volume'
> =A0 =A0 =A0 =A0value.0 33
> =A0 =A0 =A0 =A0value.1 33
> =A0 =A0 =A0 =A0comment {
> =A0 =A0 =A0 =A0 =A0 =A0access 'read write inactive'
> =A0 =A0 =A0 =A0 =A0 =A0type INTEGER
> =A0 =A0 =A0 =A0 =A0 =A0count 2
> =A0 =A0 =A0 =A0 =A0 =A0range '0 - 42'
> =A0 =A0 =A0 =A0 =A0 =A0dbmin -6300
> =A0 =A0 =A0 =A0 =A0 =A0dbmax 0
> =A0 =A0 =A0 =A0 =A0 =A0dbvalue.0 -1350
> =A0 =A0 =A0 =A0 =A0 =A0dbvalue.1 -1350
> =A0 =A0 =A0 =A0}
> =A0 =A0}
> =A0 =A0control.14 {
> =A0 =A0 =A0 =A0iface MIXER
> =A0 =A0 =A0 =A0name 'Headphone Playback Switch'
> =A0 =A0 =A0 =A0value.0 true
> =A0 =A0 =A0 =A0value.1 true
> =A0 =A0 =A0 =A0comment {
> =A0 =A0 =A0 =A0 =A0 =A0access 'read write inactive'
> =A0 =A0 =A0 =A0 =A0 =A0type BOOLEAN
> =A0 =A0 =A0 =A0 =A0 =A0count 2
> =A0 =A0 =A0 =A0}
> =A0 =A0}
>
>
> Does alsamixer or amixer allow you to change the value of headphone
> volume/switch when they are inactive ?

No. The Headphone name is grayed and though it can be selected, the
volume can't be changed.

Thanks & regards,
-- =

Mark Goldstein

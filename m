From: Colin Kincaid Williams <discord@uw.edu>
Subject: Re: poor sound from ALC 850/880 in alsa 1.0.21 and
	1.0.23
Date: Sat, 27 Nov 2010 10:58:27 -0800
Message-ID: <AANLkTi=GJgmYcDd-d6hqOW2uYwJ0i5KYOviv4Dx+JVg_@mail.gmail.com>
References: <AANLkTikE8tMisXQZfmKA_VqureL3iLU7gJhA4-L0p4HV@mail.gmail.com>
	<AANLkTikWLaEomZBVSd5iGo8D5rz51aFiA6waMw6JqpUh@mail.gmail.com>
	<AANLkTikvN5TqtB5RgXSd5A2FMDsDgD9ywo0P9-HJ=q9C@mail.gmail.com>
	<AANLkTikNgxUxicx31x_kD-Taj6+Hue_orb_vN67vbG8z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E2822244FA
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 19:58:31 +0100 (CET)
Received: by bwz8 with SMTP id 8so2815752bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 10:58:31 -0800 (PST)
In-Reply-To: <AANLkTikNgxUxicx31x_kD-Taj6+Hue_orb_vN67vbG8z@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

no, the motherboard has 6 plugs, but no digital outputs on the back.
Furthermore, I muted the CD channel, the line in was already muted,
but I still have crap sound compared to my $20 mp3 player. Something
else is wrong!

On Fri, Nov 26, 2010 at 11:48 PM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> 2010/11/27 Colin Kincaid Williams <discord@uw.edu>
>
>> On Fri, Nov 26, 2010 at 8:35 PM, Daniel Chen <seven.steps@gmail.com>
>> wrote:
>> > Please use http://www.alsa-project.org/alsa-info.sh
>> >
>>
>
>
>
> Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
> =A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0Amp-Out vals: =A0[0x00 0x00]
> =A0Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
> =A0Pin Default 0x01012014: [Jack] Line Out at Ext Rear
> =A0 =A0Conn =3D 1/8, Color =3D Grey
> =A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x4
> =A0Pin-ctls: 0x40: OUT
> =A0Unsolicited: tag=3D00, enabled=3D0
> =A0Connection: 1
> =A0 =A0 0x0f
>
> if your motherboard have 6 audio jacks (pink, blue , green , black , oran=
ge
> and grey ) and digital output at rear panel, you should try model=3D6stac=
k-dig
>
> Simple mixer control 'CD',0
> =A0Capabilities: pvolume pswitch penum
> =A0Playback channels: Front Left - Front Right
> =A0Limits: Playback 0 - 65
> =A0Mono:
> =A0Front Left: Playback 0 [0%] [-35.00dB] [on]
> =A0Front Right: Playback 0 [0%] [-35.00dB] [on]
>
> Make sure that you have muted those playback volume control of "CD"
> ,"Line" to reduce noise from those input to your output
>
>
>
>>> Simple mixer control 'Channel Mode',0
>>> =A0Capabilities: enum
>>> =A0Items: '8ch'
>>> =A0Item0: '8ch'
>>>
>
>
> only those motherboard with less than 4 output jacks need the "channel mo=
de"
> control to retask some input jacks as output jacks
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

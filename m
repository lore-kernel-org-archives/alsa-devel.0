From: Colin Kincaid Williams <discord@uw.edu>
Subject: poor sound from ALC 850/880 in alsa 1.0.21 and 1.0.23
Date: Wed, 1 Dec 2010 15:48:21 -0800
Message-ID: <AANLkTinqeXqn6V89M6XXEEqEwNqm7QgBAMbw1j8UOu9K@mail.gmail.com>
References: <AANLkTikE8tMisXQZfmKA_VqureL3iLU7gJhA4-L0p4HV@mail.gmail.com>
	<AANLkTikWLaEomZBVSd5iGo8D5rz51aFiA6waMw6JqpUh@mail.gmail.com>
	<AANLkTikvN5TqtB5RgXSd5A2FMDsDgD9ywo0P9-HJ=q9C@mail.gmail.com>
	<AANLkTikNgxUxicx31x_kD-Taj6+Hue_orb_vN67vbG8z@mail.gmail.com>
	<AANLkTi=GJgmYcDd-d6hqOW2uYwJ0i5KYOviv4Dx+JVg_@mail.gmail.com>
	<AANLkTi=Z1mzT70LSySZoY5W-j70p=AB=HJ5ezTYP=FLG@mail.gmail.com>
	<AANLkTimkqm5U=Zof48UuR7WR6cCOwaJ_9BLjKc=+iNyt@mail.gmail.com>
	<AANLkTimxEgzf6Pu5Kti2YC+9GyWDxw=sYv8i+DBdcw+b@mail.gmail.com>
	<AANLkTinPq7Kgbpey=STE0mapMXgWYpFrEv_UJVOsU7d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5444A24460
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 00:48:23 +0100 (CET)
Received: by bwz8 with SMTP id 8so6921111bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 15:48:23 -0800 (PST)
In-Reply-To: <AANLkTinPq7Kgbpey=STE0mapMXgWYpFrEv_UJVOsU7d8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Colin Kincaid Williams <discord@uw.edu>
Date: Wed, Dec 1, 2010 at 3:47 PM
Subject: Re: [alsa-devel] poor sound from ALC 850/880 in alsa 1.0.21 and 1.=
0.23
To: Raymond Yau <superquad.vortex2@gmail.com>


how do I mute them manually, without hdaanalyser?

On Wed, Dec 1, 2010 at 1:35 AM, Raymond Yau <superquad.vortex2@gmail.com> w=
rote:
> 2010/12/1 Colin Kincaid Williams <discord@uw.edu>
>
>> I selected node 0x0c in =A0hdaanalyzer and see audio mixer [OxOb] in the
>> Connection list, but I cannot select the radio button.
>>
>
> According to the block diagram of alc880 datasheet, it look like two mute
> switches for node 0x02 and 0x0b or checkbox in hda_analyzer
>
>> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>> =A0Amp-In vals: =A0[0x00 0x00] [0x00 0x00]
>
> Unfortunately hda_analyzer seem fail to parse your codec -info
>
> =A0File "./hda_analyzer.py", line 483, in <module>
> =A0 =A0sys.exit(main(sys.argv))
> =A0File "./hda_analyzer.py", line 460, in main
> =A0 =A0if read_nodes(sys.argv[1:]) =3D=3D 0:
> =A0File "./hda_analyzer.py", line 110, in read_nodes
> =A0 =A0read_nodes3(card, idx, i)
> =A0File "./hda_analyzer.py", line 77, in read_nodes3
> =A0 =A0c =3D HDACodecProc(card, codec, proc_file)
> =A0File "/home/raymond/hda-analyzer/hda_proc.py", line 474, in __init__
> =A0 =A0self.parse(proc_file)
> =A0File "/home/raymond/hda-analyzer/hda_proc.py", line 678, in parse
> =A0 =A0node.add_ampvals(line[15:], HDA_INPUT)
> =A0File "/home/raymond/hda-analyzer/hda_proc.py", line 353, in add_ampvals
> =A0 =A0self.wrongfile('amp vals ]')
> =A0File "/home/raymond/hda-analyzer/hda_proc.py", line 143, in wrongfile
> =A0 =A0raise ValueError, "wrong proc file format (%s)" % msg
> ValueError: wrong proc file format (amp vals ])
>
>
>
>
>>
>> On Sun, Nov 28, 2010 at 11:40 PM, Raymond Yau
>> <superquad.vortex2@gmail.com> wrote:
>> > 2010/11/28 Colin Kincaid Williams <discord@uw.edu>
>> >
>> >> no, the motherboard has 6 plugs, but no digital outputs on the back.
>> >> Furthermore, I muted the CD channel, the line in was already muted,
>> >> but I still have crap sound compared to my $20 mp3 player. Something
>> >> else is wrong!
>> >>
>> >>
>> > Take a look at the block diagram of alc880 datasheet
>> >
>> > does it help when you use hda-analyzer to mute the amp-in value from n=
ode
>> > 0x0b in 0x0c ?
>> >
>> >
>> > Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>> > =A0Control: name=3D"Front Playback Volume", index=3D0, device=3D0
>> > =A0 =A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
>> > =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>> > =A0Amp-In vals: =A0[0x00 0x00] [0x00 0x00]
>> > =A0Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
>> > =A0Amp-Out vals: =A0[0x33 0x33]
>> > =A0Connection: 2
>> > =A0 =A0 0x02 0x0b
>> >
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

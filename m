From: Colin Kincaid Williams <discord@uw.edu>
Subject: Re: poor sound from ALC 850/880 in alsa 1.0.21 and
	1.0.23
Date: Tue, 30 Nov 2010 22:40:19 -0800
Message-ID: <AANLkTiko2zf80JMRqQJFp+2ZPMUzYSYBmLLyLK0NiSYP@mail.gmail.com>
References: <AANLkTikE8tMisXQZfmKA_VqureL3iLU7gJhA4-L0p4HV@mail.gmail.com>
	<AANLkTikWLaEomZBVSd5iGo8D5rz51aFiA6waMw6JqpUh@mail.gmail.com>
	<AANLkTikvN5TqtB5RgXSd5A2FMDsDgD9ywo0P9-HJ=q9C@mail.gmail.com>
	<AANLkTikNgxUxicx31x_kD-Taj6+Hue_orb_vN67vbG8z@mail.gmail.com>
	<AANLkTi=GJgmYcDd-d6hqOW2uYwJ0i5KYOviv4Dx+JVg_@mail.gmail.com>
	<AANLkTi=Z1mzT70LSySZoY5W-j70p=AB=HJ5ezTYP=FLG@mail.gmail.com>
	<AANLkTimkqm5U=Zof48UuR7WR6cCOwaJ_9BLjKc=+iNyt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 94FB6103814
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 07:40:22 +0100 (CET)
Received: by bwz8 with SMTP id 8so6019451bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 22:40:20 -0800 (PST)
In-Reply-To: <AANLkTimkqm5U=Zof48UuR7WR6cCOwaJ_9BLjKc=+iNyt@mail.gmail.com>
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

I've tried model 6stack-digout and have no noticable improvment in
sound. An ubuntu live cd yields the same result. The sound is good in
Windows7. My friend says the audio sounds compressed. :(

On Tue, Nov 30, 2010 at 8:46 PM, Colin Kincaid Williams <discord@uw.edu> wr=
ote:
> I selected node 0x0c in =A0hdaanalyzer and see audio mixer [OxOb] in the
> Connection list, but I cannot select the radio button.
>
> On Sun, Nov 28, 2010 at 11:40 PM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
>> 2010/11/28 Colin Kincaid Williams <discord@uw.edu>
>>
>>> no, the motherboard has 6 plugs, but no digital outputs on the back.
>>> Furthermore, I muted the CD channel, the line in was already muted,
>>> but I still have crap sound compared to my $20 mp3 player. Something
>>> else is wrong!
>>>
>>>
>> Take a look at the block diagram of alc880 datasheet
>>
>> does it help when you use hda-analyzer to mute the amp-in value from node
>> 0x0b in 0x0c ?
>>
>>
>> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>> =A0Control: name=3D"Front Playback Volume", index=3D0, device=3D0
>> =A0 =A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
>> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>> =A0Amp-In vals: =A0[0x00 0x00] [0x00 0x00]
>> =A0Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
>> =A0Amp-Out vals: =A0[0x33 0x33]
>> =A0Connection: 2
>> =A0 =A0 0x02 0x0b
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>

From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Can't get Pulseadio to playback stream on
 Raspbian with HifiBerry DAC+
Date: Tue, 31 Mar 2015 09:08:33 +0800
Message-ID: <CAN8cciakUzqpk1eREx2oWUsfjM_aps9Gka4fFSkfHbCWsUutHQ@mail.gmail.com>
References: <CADzxsyKCCUEF6+vKr6SMoqU5S_X3BMgaRr81GyhZVYkqV7TySg@mail.gmail.com>
 <CAN8cciZV79fgAX2MejODf-fdMe5MdgJYVErYWa2H0VduwTMp3w@mail.gmail.com>
 <CADzxsyLSfFqt12fJF5Q=mmKxAoJJv52Uc_fZR95nm=KQCjPbyw@mail.gmail.com>
 <CAN8cciZwAxPdBLnij-OYPfyP1eJRa0d3BMS+upv=ciZCRoazFA@mail.gmail.com>
 <CADzxsyKNz6sh7SBdv-JOUX2NjsWyQGM8MxpDufbnqayen=MU9g@mail.gmail.com>
 <CAN8cciZiyy+nDg-pOauoMKBb2FCpyh7ORpTyUBiO-Ap2bHtgoA@mail.gmail.com>
 <CADzxsyLFYnoUztkwvqFdxqKa1xJeu6+VqfrC+eG9OiE=+Z20aQ@mail.gmail.com>
 <CAN8ccibGLsforRKE3r3=bdcPS3Nr+KP9_6ZhRGaseK8M96BBNA@mail.gmail.com>
 <CADzxsy+TS05PYqUMq40u3aAc+6Pj1c2RvuefW4OhO348z0w5Yw@mail.gmail.com>
 <CAN8cciYEu7CtNSChBz6kb+jd09eOOTATZRCGXnW9swzR0JdwBw@mail.gmail.com>
 <CADzxsyK4e3Hw2EYWWVtTqrN1L+CdoKQri_zcY0bQg66ffE82Og@mail.gmail.com>
 <CAN8cciYUaz0H9ZKNZV_kLnw-J1XsQ_NefV4FiwH43yYRV_zRBw@mail.gmail.com>
 <CADzxsyK07iAqUv=jHnP80vr70Z5xAp2C_gHH4kiXTrY_21TKcg@mail.gmail.com>
 <CAN8ccibcnQqycxf6Js_Dxucy43rEDXrb141p93bJ3J7jzjZcyg@mail.gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2066048449=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8ccibcnQqycxf6Js_Dxucy43rEDXrb141p93bJ3J7jzjZcyg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Martinez <david@sojournmusic.net>, hm@hmbedded.co.uk
Cc: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============2066048449==
Content-Type: multipart/alternative; boundary=089e01182362d668df05128b3cc6

--089e01182362d668df05128b3cc6
Content-Type: text/plain; charset=UTF-8

> >
> > Label says PiFi DAC+. v2.0
> >
> > I'll need to look up how to apply the patch. I'm not familiar with how
to do it.
>
> This look like driver bug since capabilities should be pvolume instead of
volume if your sound card are half duplex
>
> Simple mixer control 'PCM',0
> Capabilities: volume penum
> Playback channels: Front Left - Front Right
> Capture channels: Front Left - Front Right
> Limits: 0 - 215 Front Left: 172 [80%] Front Right: 172 [80%]
>
> Simple mixer control 'Playback',0 Capabilities: volume penum
> Playback channels: Front Left - Front Right
> Capture channels: Front Left - Front Right
> Limits: 0 - 1 Front Left: 0 [0%] [-6.00dB] Front Right: 0 [0%] [-6.00dB]
>
> Simple mixer control 'Playback Boost',0 Capabilities: volume penum
Playback channels: Front Left - Front Right
> Capture channels: Front Left - Front Right
> Limits: 0 - 1 Front Left: 0 [0%] [0.00dB] Front Right: 0 [0%] [0.00dB]
>
> >

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output.conf.common

http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/089106.html

> >>
> >> >
>
> >> > I'll check HiFiBerry's site and see if I can get it.
> >> >
> >>
> >> https://www.hifiberry.com/dacplus/
> >>
> >> What is the label on the black DAC chip ?
> >>
> >> Aplay/Arecord output
> >> !!--------------------
> >>
> >> APLAY
> >>
> >> **** List of PLAYBACK Hardware Devices ****
> >> card 0: sndrpihifiberry [snd_rpi_hifiberry_dacplus], device 0:
HiFiBerry DAC  HiFi pcm512x-hifi-0 []
> >>   Subdevices: 1/1
> >>   Subdevice #0: subdevice #0
> >>
> >> ARECORD
> >>
> >> **** List of CAPTURE Hardware Devices ****
> >>
> >> Seem half duplex
> >>
> >>

--089e01182362d668df05128b3cc6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p></p>
<p>&gt; &gt;<br>
&gt; &gt; Label says PiFi DAC+. v2.0<br>
&gt; &gt;<br>
&gt; &gt; I&#39;ll need to look up how to apply the patch. I&#39;m not fami=
liar with how to do it.<br>
&gt;<br>
&gt; This look like driver bug since capabilities should be pvolume instead=
 of volume if your sound card are half duplex<br>
&gt;<br>
&gt; Simple mixer control &#39;PCM&#39;,0 <br>
&gt; Capabilities: volume penum <br>
&gt; Playback channels: Front Left - Front Right <br>
&gt; Capture channels: Front Left - Front Right <br>
&gt; Limits: 0 - 215 Front Left: 172 [80%] Front Right: 172 [80%]<br>
&gt;<br>
&gt; Simple mixer control &#39;Playback&#39;,0 Capabilities: volume penum <=
br>
&gt; Playback channels: Front Left - Front Right <br>
&gt; Capture channels: Front Left - Front Right <br>
&gt; Limits: 0 - 1 Front Left: 0 [0%] [-6.00dB] Front Right: 0 [0%] [-6.00d=
B]<br>
&gt;<br>
&gt; Simple mixer control &#39;Playback Boost&#39;,0 Capabilities: volume p=
enum Playback channels: Front Left - Front Right <br>
&gt; Capture channels: Front Left - Front Right <br>
&gt; Limits: 0 - 1 Front Left: 0 [0%] [0.00dB] Front Right: 0 [0%] [0.00dB]=
<br>
&gt;<br>
&gt; &gt;<br></p>
<p><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/mo=
dules/alsa/mixer/paths/analog-output.conf.common">http://cgit.freedesktop.o=
rg/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output.co=
nf.common</a><br></p>
<p><a href=3D"http://mailman.alsa-project.org/pipermail/alsa-devel/2015-Mar=
ch/089106.html">http://mailman.alsa-project.org/pipermail/alsa-devel/2015-M=
arch/089106.html</a></p>
<p>&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt;<br>
&gt; &gt;&gt; &gt; I&#39;ll check HiFiBerry&#39;s site and see if I can get=
 it.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; <a href=3D"https://www.hifiberry.com/dacplus/">https://www.hi=
fiberry.com/dacplus/</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; What is the label on the black DAC chip ?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Aplay/Arecord output<br>
&gt; &gt;&gt; !!--------------------<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; APLAY<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; **** List of PLAYBACK Hardware Devices ****<br>
&gt; &gt;&gt; card 0: sndrpihifiberry [snd_rpi_hifiberry_dacplus], device 0=
: HiFiBerry DAC=C2=A0 HiFi pcm512x-hifi-0 []<br>
&gt; &gt;&gt; =C2=A0 Subdevices: 1/1<br>
&gt; &gt;&gt; =C2=A0 Subdevice #0: subdevice #0<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ARECORD<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; **** List of CAPTURE Hardware Devices ****<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Seem half duplex<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;</p>

--089e01182362d668df05128b3cc6--

--===============2066048449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============2066048449==--

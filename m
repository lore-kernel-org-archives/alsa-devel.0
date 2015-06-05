From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: (alsa-lib)pcm_hw.c: Invalid PCM state for
	chmap_get: OPEN
Date: Fri, 5 Jun 2015 16:34:01 +0800
Message-ID: <CAN8cciZTcA_fU5LjLak-3uFfLg84fW0uG8rB187fOxi38Fa5dg@mail.gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0749231997=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============0749231997==
Content-Type: multipart/alternative; boundary=001a1141bdce714f440517c1275e

--001a1141bdce714f440517c1275e
Content-Type: text/plain; charset=UTF-8

>>
>> Have you tested surround21?
>
> Yes, front speakers work fine, however LFE doesn't seem to work. Instead
when I try to test LFE (from sound UI) I have weird noise in one of rear
speakers. There are no such problems with any other mode though (I see that
officially only 5.1 mode is supported, however 4.1, 5.0 and 5.1 all work
fine), I decided to leave 2.1 mode for now, not sure whose fault is that.

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=3c4a22ea49a881cdbfe2d50eef94b17e38104734;hp=1ef1c5cdb4301898499c0391cdfac2117c7d4684#patch17

It is strange that pcm state is open

(   0.089|   0.001) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-21
(   0.089|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on
Analog Surround 2.1 (analog-surround-21)
(   0.089|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.089|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state
for chmap_get: OPEN

(   0.089|   0.000) D: [pulseaudio] alsa-util.c: Managed to open
surround21:1
(   0.089|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode
since BATCH flag is set
(   0.089|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is
1213 ms
(   0.090|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to
4797 samples), period size second (to 1199 samples).
(   0.090|   0.000) I: [pulseaudio] alsa-util.c: Device surround21:1
doesn't support 44100 Hz, changed to 48000 Hz.
(   0.090|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-21 supported.

--001a1141bdce714f440517c1275e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p>&gt;&gt;<br>
&gt;&gt; Have you tested surround21?<br>
&gt;<br>
&gt; Yes, front speakers work fine, however LFE doesn&#39;t seem to work. I=
nstead when I try to test LFE (from sound UI) I have weird noise in one of =
rear speakers. There are no such problems with any other mode though (I see=
 that officially only 5.1 mode is supported, however 4.1, 5.0 and 5.1 all w=
ork fine), I decided to leave 2.1 mode for now, not sure whose fault is tha=
t.</p>
<p><a href=3D"http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dcommitdiff;=
h=3D3c4a22ea49a881cdbfe2d50eef94b17e38104734;hp=3D1ef1c5cdb4301898499c0391c=
dfac2117c7d4684#patch17">http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3D=
commitdiff;h=3D3c4a22ea49a881cdbfe2d50eef94b17e38104734;hp=3D1ef1c5cdb43018=
98499c0391cdfac2117c7d4684#patch17</a></p>
<p>It is strange that pcm state is open<br><br></p>
<p>(=C2=A0=C2=A0 0.089|=C2=A0=C2=A0 0.001) D: [pulseaudio] alsa-mixer.c: Lo=
oking at profile output:analog-surround-21<br>
(=C2=A0=C2=A0 0.089|=C2=A0=C2=A0 0.000) D: [pulseaudio] alsa-mixer.c: Check=
ing for playback on Analog Surround 2.1 (analog-surround-21)<br>
(=C2=A0=C2=A0 0.089|=C2=A0=C2=A0 0.000) D: [pulseaudio] alsa-util.c: Trying=
 surround21:1 with SND_PCM_NO_AUTO_FORMAT ...<br>
(=C2=A0=C2=A0 0.089|=C2=A0=C2=A0 0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c:=
 Invalid PCM state for chmap_get: OPEN<br></p>
<p>(=C2=A0=C2=A0 0.089|=C2=A0=C2=A0 0.000) D: [pulseaudio] alsa-util.c: Man=
aged to open surround21:1<br>
(=C2=A0=C2=A0 0.089|=C2=A0=C2=A0 0.000) I: [pulseaudio] alsa-util.c: Disabl=
ing tsched mode since BATCH flag is set<br>
(=C2=A0=C2=A0 0.089|=C2=A0=C2=A0 0.000) D: [pulseaudio] alsa-util.c: Maximu=
m hw buffer size is 1213 ms<br>
(=C2=A0=C2=A0 0.090|=C2=A0=C2=A0 0.000) D: [pulseaudio] alsa-util.c: Set bu=
ffer size first (to 4797 samples), period size second (to 1199 samples).<br=
>
(=C2=A0=C2=A0 0.090|=C2=A0=C2=A0 0.000) I: [pulseaudio] alsa-util.c: Device=
 surround21:1 doesn&#39;t support 44100 Hz, changed to 48000 Hz.<br>
(=C2=A0=C2=A0 0.090|=C2=A0=C2=A0 0.000) D: [pulseaudio] alsa-mixer.c: Profi=
le output:analog-surround-21 supported.</p>

--001a1141bdce714f440517c1275e--

--===============0749231997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0749231997==--

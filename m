From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] Front speakers doesn't work
 in multichannel output, regression in ALC888
Date: Sun, 3 May 2015 15:53:47 +0800
Message-ID: <CAN8ccibMjud9MAbXhS=QxPTosYZOQjQLq-Zt1qSiJ9DF6BkLJQ@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <CAN8cciYUrzEKFNmKUJyyzJtTMZv0XBG71FyUKKAAjC1uZ3ca4Q@mail.gmail.com>
 <7993879.9dprRWFvNQ@luklap.workgroup>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687616487=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <7993879.9dprRWFvNQ@luklap.workgroup>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--===============0687616487==
Content-Type: multipart/alternative; boundary=e89a8fb1f344d392fd051528beaf

--e89a8fb1f344d392fd051528beaf
Content-Type: text/plain; charset=UTF-8

> > > My problem is that when I set channel output to "Analog output
surround
> > > 5.1"
> > > (or 2.1 or 4.1), I hear no sound in front speakers, but in case of
5.1 or
> > > 4.1

You need pulseaudio lfe-filter for 2.1

http://cgit.freedesktop.org/pulseaudio/pulseaudio/log/?qt=grep&q=lfe-filter

do you mean surround21 need 6 channel instead of channels with 5.1 internal
/external speaker ?

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=48f1b308cc66152eb6db66742dd0d08d888cda8d;hp=5c4cd46810cef8850b037fca9e38ffd43b0bff22


> > > I can hear sound in rear speakers. I use kernel 3.19.5 and it didn't
> > > happen in
> > > earlier kernels that is 3.18 and in 3.17 for sure.
> > >
> > > My configuration is:
> > > OS: Fedora 21 64 bit
> > > SoundCard: ALC888
> > > Model name: acer-aspire-4930g
> > > Laptop: Acer Aspire 5930g
> > > Speakers: external 5.1 with 3 jacks
> > > Sound channel configuration module is standard configuration module
from
> > > KDE.
> > >
> > > Additional info:
> > > 1) When channel output is 5.1 and I unplug green jack and leave two
others
> > > jacks connected then I can hear sound in laptop internal speakers.

auto mute only check headphone jack or line out jack but not those retasked
mio jacks


> > > 2) Earlier (kernel 3.18 and 3.17) I didn't have possibility to choose
2.1
> > > configuration and additionally to 4.1 configuration I could also
choose
> > > 4.0
> > > configuration.
> > >
> > > You need to switch "Channel mode" to "6 ch" if you need to use
external
> >
> > 5.1 speakers since you have 5.1 internal speakers
> >
> > this change pin-ctl of headphone jack, mic jack and line in to OUT
> >
> > post the output of alsa-info.sh
>
> I always switched to "6 ch" through alsamixer. It always worked as
expected,
> but recently I've got problems with it so it regressed somewhere.

>
>
> My alsa-info.sh with "6 ch" set through alsamixer and "Analog output
surround
> 5.1 + Analog input stereo" set through KDE configuration module.
> http://www.alsa-project.org/db/?f=ff3f5a1f7f3e4662c3fa9bcf0158474a076b4cc4
>
> With that I hear all channels except front left and front right.

autoconfig for ALC888: line_outs=3 (0x14/0x17/0x16/0x0/0x0) type:speaker
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   dig-out=0x1e/0x0
   inputs:
     Mic=0x18
     Internal Mic=0x12
     Line=0x1a


==> Best config: lo_type=2, wired=1, mio=1
multi_outs = 15/0/0/0 : 2/3/4/0 (type HP)
  out path: depth=3 '02:0c:15'
multi_ios(2) = 1a/18 : 3/4
  mio path: depth=3 '03:0d:1a'
  mio path: depth=3 '04:0e:18'
spk_outs = 14/17/16/0 : 5/25/4/0
  spk path: depth=3 '05:0f:14'
  spk path: depth=3 '25:26:17'
  spk path: depth=3 '04:0e:16'

Node 0x15 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Headphone Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
  EAPD 0x2: EAPD
  Pin Default 0x0221101f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26

it is still headphone jack with pin-ctl : 0xc0 OUT HP while mic jack and
line in jack 's pin ctl are changed to 0x40 OUT

channel mode only change two mio jacks from IN to OUT

May need to use add_out_jack_mode=1 instead of add_jack_modes=1 when there
are Mic and line in jacks

Use Headphone Jack Mode control to switch HP to Line Out for pin-ctl and
EAPD

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=f811c3cf8fae63ecc8a937ba7376490e2565f8f1

> To exclude that my speakers are broken or wrong connected: I get sound
from
> front left and front right if i switch in KDE configuration module to
"Analog
> duplex stereo", but then I get no sound from rest of my speakers.

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output-headphones.conf

pulseaudio mute external center/lfe controls when headphone jack is plugged
since pulseaudio not aware that the role of headphone has been changed


[Element Center]
switch = off
volume = off

[Element LFE]
switch = off
volume = off


>
>
> KDE configuration module lets me choose "connector" configuration but
only in
> stereo mode.
> In stereo mode I can choose between "headphones" and "speakers".
> If it is set to "headphones" I hear sound in front left and front right
> speakers.
> If it is set to "speakers" I hear sound in rear left and rear right
speakers.
>

you need to switch "channel mode" to "2 ch" if you want to use your 5.1
internal speaker


https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=786c51f9168cfd2d49250c6e5e60035cbb2fd5a1


There are difference between static model and generic parser

--e89a8fb1f344d392fd051528beaf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p><br>
&gt; &gt; &gt; My problem is that when I set channel output to &quot;Analog=
 output surround<br>
&gt; &gt; &gt; 5.1&quot;<br>
&gt; &gt; &gt; (or 2.1 or 4.1), I hear no sound in front speakers, but in c=
ase of 5.1 or<br>
&gt; &gt; &gt; 4.1</p><p>You need pulseaudio lfe-filter for 2.1 <br></p><p>=
<a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/log/?qt=3Dgrep=
&amp;q=3Dlfe-filter" target=3D"_blank">http://cgit.freedesktop.org/pulseaud=
io/pulseaudio/log/?qt=3Dgrep&amp;q=3Dlfe-filter</a></p><p>do you mean surro=
und21 need 6 channel instead of channels with 5.1 internal /external speake=
r ?<br></p><p><a href=3D"http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3D=
commitdiff;h=3D48f1b308cc66152eb6db66742dd0d08d888cda8d;hp=3D5c4cd46810cef8=
850b037fca9e38ffd43b0bff22" target=3D"_blank">http://git.alsa-project.org/?=
p=3Dalsa-lib.git;a=3Dcommitdiff;h=3D48f1b308cc66152eb6db66742dd0d08d888cda8=
d;hp=3D5c4cd46810cef8850b037fca9e38ffd43b0bff22</a><br></p><p><br>
&gt; &gt; &gt; I can hear sound in rear speakers. I use kernel 3.19.5 and i=
t didn&#39;t<br>
&gt; &gt; &gt; happen in<br>
&gt; &gt; &gt; earlier kernels that is 3.18 and in 3.17 for sure.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; My configuration is:<br>
&gt; &gt; &gt; OS: Fedora 21 64 bit<br>
&gt; &gt; &gt; SoundCard: ALC888<br>
&gt; &gt; &gt; Model name: acer-aspire-4930g<br>
&gt; &gt; &gt; Laptop: Acer Aspire 5930g<br>
&gt; &gt; &gt; Speakers: external 5.1 with 3 jacks<br>
&gt; &gt; &gt; Sound channel configuration module is standard configuration=
 module from<br>
&gt; &gt; &gt; KDE.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Additional info:<br>
&gt; &gt; &gt; 1) When channel output is 5.1 and I unplug green jack and le=
ave two others<br>
&gt; &gt; &gt; jacks connected then I can hear sound in laptop internal spe=
akers.</p><p>auto mute only check headphone jack or line out jack but not t=
hose retasked mio jacks<br></p><p><br>
&gt; &gt; &gt; 2) Earlier (kernel 3.18 and 3.17) I didn&#39;t have possibil=
ity to choose 2.1<br>
&gt; &gt; &gt; configuration and additionally to 4.1 configuration I could =
also choose<br>
&gt; &gt; &gt; 4.0<br>
&gt; &gt; &gt; configuration.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; You need to switch &quot;Channel mode&quot; to &quot;6 ch&qu=
ot; if you need to use external<br>
&gt; &gt;<br>
&gt; &gt; 5.1 speakers since you have 5.1 internal speakers<br>
&gt; &gt;<br>
&gt; &gt; this change pin-ctl of headphone jack, mic jack and line in to OU=
T<br>
&gt; &gt;<br>
&gt; &gt; post the output of alsa-info.sh<br>
&gt;<br>
&gt; I always switched to &quot;6 ch&quot; through alsamixer. It always wor=
ked as expected,<br>
&gt; but recently I&#39;ve got problems with it so it regressed somewhere.<=
/p>
<p>
&gt;<br>
&gt;<br>
&gt; My alsa-info.sh with &quot;6 ch&quot; set through alsamixer and &quot;=
Analog output surround<br>
&gt; 5.1 + Analog input stereo&quot; set through KDE configuration module.<=
br>
&gt;<a href=3D"http://www.alsa-project.org/db/?f=3Dff3f5a1f7f3e4662c3fa9bcf=
0158474a076b4cc4" target=3D"_blank"> http://www.alsa-project.org/db/?f=3Dff=
3f5a1f7f3e4662c3fa9bcf0158474a076b4cc4</a><br>
&gt;<br>
&gt; With that I hear all channels except front left and front right.</p><p=
>autoconfig for ALC888: line_outs=3D3 (0x14/0x17/0x16/0x0/0x0) type:speaker=
<br>=C2=A0=C2=A0 speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)<br>=C2=A0=C2=A0 hp_=
outs=3D1 (0x15/0x0/0x0/0x0/0x0)<br>=C2=A0=C2=A0 mono: mono_out=3D0x0<br>=C2=
=A0=C2=A0 dig-out=3D0x1e/0x0<br>=C2=A0=C2=A0 inputs:<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 Mic=3D0x18<br>=C2=A0=C2=A0=C2=A0=C2=A0 Internal Mic=3D0x12<br>=C2=A0=
=C2=A0=C2=A0=C2=A0 Line=3D0x1a<br></p><p><br></p><p>=3D=3D&gt; Best config:=
 lo_type=3D2, wired=3D1, mio=3D1<br>multi_outs =3D 15/0/0/0 : 2/3/4/0 (type=
 HP)<br>=C2=A0 out path: depth=3D3 &#39;02:0c:15&#39;<br>multi_ios(2) =3D 1=
a/18 : 3/4<br>=C2=A0 mio path: depth=3D3 &#39;03:0d:1a&#39;<br>=C2=A0 mio p=
ath: depth=3D3 &#39;04:0e:18&#39;<br>spk_outs =3D 14/17/16/0 : 5/25/4/0<br>=
=C2=A0 spk path: depth=3D3 &#39;05:0f:14&#39;<br>=C2=A0 spk path: depth=3D3=
 &#39;25:26:17&#39;<br>=C2=A0 spk path: depth=3D3 &#39;04:0e:16&#39;<br><br=
></p><p>Node 0x15 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out<br>=
=C2=A0 Control: name=3D&quot;Headphone Playback Switch&quot;, index=3D0, de=
vice=3D0<br>=C2=A0=C2=A0=C2=A0 ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=
=3D0<br>=C2=A0 Control: name=3D&quot;Front Headphone Jack&quot;, index=3D0,=
 device=3D0<br>=C2=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x=
27, mute=3D0<br>=C2=A0 Amp-In vals:=C2=A0 [0x00 0x00]<br>=C2=A0 Amp-Out cap=
s: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1<br>=C2=A0 Amp-Out v=
als:=C2=A0 [0x80 0x80]<br>=C2=A0 Pincap 0x0001003e: IN OUT HP EAPD Detect T=
rigger<br>=C2=A0 EAPD 0x2: EAPD<br>=C2=A0 Pin Default 0x0221101f: [Jack] HP=
 Out at Ext Front<br>=C2=A0=C2=A0=C2=A0 Conn =3D 1/8, Color =3D Black<br>=
=C2=A0=C2=A0=C2=A0 DefAssociation =3D 0x1, Sequence =3D 0xf<br>=C2=A0 Pin-c=
tls: 0xc0: OUT HP<br>=C2=A0 Unsolicited: tag=3D01, enabled=3D1<br>=C2=A0 Po=
wer states:=C2=A0 D0 D1 D2 D3 EPSS<br>=C2=A0 Power: setting=3DD0, actual=3D=
D0<br>=C2=A0 Connection: 5<br>=C2=A0=C2=A0=C2=A0=C2=A0 0x0c* 0x0d 0x0e 0x0f=
 0x26<br></p>
<p>it is still headphone jack with pin-ctl : 0xc0 OUT HP while mic jack and=
 line in jack &#39;s pin ctl are changed to 0x40 OUT</p><p>channel mode onl=
y change two mio jacks from IN to OUT<br></p><p>May need to use add_out_jac=
k_mode=3D1 instead of add_jack_modes=3D1 when there are Mic and line in jac=
ks</p><p>Use Headphone Jack Mode control to switch HP to Line Out for pin-c=
tl and EAPD<br></p>
<p><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/=
commit/?id=3Df811c3cf8fae63ecc8a937ba7376490e2565f8f1" target=3D"_blank">ht=
tps://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=3Df81=
1c3cf8fae63ecc8a937ba7376490e2565f8f1</a></p>
<p>&gt; To exclude that my speakers are broken or wrong connected: I get so=
und from<br>
&gt; front left and front right if i switch in KDE configuration module to =
&quot;Analog<br>
&gt; duplex stereo&quot;, but then I get no sound from rest of my speakers.=
</p>
<p><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/mo=
dules/alsa/mixer/paths/analog-output-headphones.conf" target=3D"_blank">htt=
p://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/=
paths/analog-output-headphones.conf</a><br></p><p>pulseaudio mute external =
center/lfe controls when headphone jack is plugged since pulseaudio not awa=
re that the role of headphone has been changed <br></p><p><br>[Element Cent=
er]<br>switch =3D off<br>volume =3D off<br><br>[Element LFE]<br>switch =3D =
off<br>volume =3D off<br></p><p><br>
&gt;<br>
&gt;<br>
&gt; KDE configuration module lets me choose &quot;connector&quot; configur=
ation but only in<br>
&gt; stereo mode.<br>
&gt; In stereo mode I can choose between &quot;headphones&quot; and &quot;s=
peakers&quot;.<br>
&gt; If it is set to &quot;headphones&quot; I hear sound in front left and =
front right<br>
&gt; speakers.<br>
&gt; If it is set to &quot;speakers&quot; I hear sound in rear left and rea=
r right speakers.<br>
&gt;</p><p>you need to switch &quot;channel mode&quot; to &quot;2 ch&quot; =
if you want to use your 5.1 internal speaker</p><p><br></p><p><a href=3D"ht=
tps://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=3D786=
c51f9168cfd2d49250c6e5e60035cbb2fd5a1" target=3D"_blank">https://git.kernel=
.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=3D786c51f9168cfd2d492=
50c6e5e60035cbb2fd5a1</a></p><p><br></p><p>There are difference between sta=
tic model and generic parser <br></p><br></div>

--e89a8fb1f344d392fd051528beaf--

--===============0687616487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0687616487==--

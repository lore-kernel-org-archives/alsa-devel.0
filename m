From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] Front speakers doesn't work
 in multichannel output, regression in ALC888
Date: Sun, 7 Jun 2015 20:44:24 +0800
Message-ID: <CAN8ccibhDdGcJMcZS60mjkGLN6igXeLop+oYU6DbUczT_XJNfQ@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0801813506=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <2927807.UsnFnTlWVL@luklap.workgroup>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, pulseaudio-discuss@lists.freedesktop.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============0801813506==
Content-Type: multipart/alternative; boundary=001a113de17697a5f70517ece29a

--001a113de17697a5f70517ece29a
Content-Type: text/plain; charset=UTF-8

>
> My problem is that when I set channel output to "Analog output surround
5.1"
> (or 2.1 or 4.1), I hear no sound in front speakers, but in case of 5.1 or
4.1
> I can hear sound in rear speakers. I use kernel 3.19.5 and it didn't
happen in
> earlier kernels that is 3.18 and in 3.17 for sure.
>
> My configuration is:
> OS: Fedora 21 64 bit
> SoundCard: ALC888
> Model name: acer-aspire-4930g
> Laptop: Acer Aspire 5930g
> Speakers: external 5.1 with 3 jacks
> Sound channel configuration module is standard configuration module from
KDE.
>
> Additional info:
> 1) When channel output is 5.1 and I unplug green jack and leave two others
> jacks connected then I can hear sound in laptop internal speakers.
> 2) Earlier (kernel 3.18 and 3.17) I didn't have possibility to choose 2.1
> configuration and additionally to 4.1 configuration I could also choose
4.0
> configuration.

You have to provide pulseaudio verbose log

If driver create channel mode which allow you to support surround5.1 with
your headphone,  line in and mic jack

It is possible for pulseaudio mute two of your external 5.1 speaker when
headphone jack is plugged

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output-headphones.conf

[Element Rear]
switch = off
volume = off

[Element Surround]
switch = off
volume = off

[Element Center]
switch = off
volume = off

[Element LFE]
switch = off
volume = off

--001a113de17697a5f70517ece29a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;<br>
&gt; My problem is that when I set channel output to &quot;Analog output su=
rround 5.1&quot;<br>
&gt; (or 2.1 or 4.1), I hear no sound in front speakers, but in case of 5.1=
 or 4.1<br>
&gt; I can hear sound in rear speakers. I use kernel 3.19.5 and it didn&#39=
;t happen in<br>
&gt; earlier kernels that is 3.18 and in 3.17 for sure.<br>
&gt;<br>
&gt; My configuration is:<br>
&gt; OS: Fedora 21 64 bit<br>
&gt; SoundCard: ALC888<br>
&gt; Model name: acer-aspire-4930g<br>
&gt; Laptop: Acer Aspire 5930g<br>
&gt; Speakers: external 5.1 with 3 jacks<br>
&gt; Sound channel configuration module is standard configuration module fr=
om KDE.<br>
&gt;<br>
&gt; Additional info:<br>
&gt; 1) When channel output is 5.1 and I unplug green jack and leave two ot=
hers<br>
&gt; jacks connected then I can hear sound in laptop internal speakers.<br>
&gt; 2) Earlier (kernel 3.18 and 3.17) I didn&#39;t have possibility to cho=
ose 2.1<br>
&gt; configuration and additionally to 4.1 configuration I could also choos=
e 4.0<br>
&gt; configuration.</p>
<p>You have to provide pulseaudio verbose log</p>
<p>If driver create channel mode which allow you to support surround5.1 wit=
h your headphone,=C2=A0 line in and mic jack</p>
<p>It is possible for pulseaudio mute two of your external 5.1 speaker when=
 headphone jack is plugged</p>
<p><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/mo=
dules/alsa/mixer/paths/analog-output-headphones.conf">http://cgit.freedeskt=
op.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-outpu=
t-headphones.conf</a></p>
<p>[Element Rear]<br>
switch =3D off<br>
volume =3D off</p>
<p>[Element Surround]<br>
switch =3D off<br>
volume =3D off</p>
<p>[Element Center]<br>
switch =3D off<br>
volume =3D off</p>
<p>[Element LFE]<br>
switch =3D off<br>
volume =3D off</p>

--001a113de17697a5f70517ece29a--

--===============0801813506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0801813506==--

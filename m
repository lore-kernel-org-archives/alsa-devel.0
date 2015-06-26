From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Need help with Behringer Firepower FCA610
	profile
Date: Fri, 26 Jun 2015 16:46:51 +0800
Message-ID: <CAN8ccian_we20vDfGCeSptH162xRU35WVW=ONKufgtFuQuTx7Q@mail.gmail.com>
References: <79505bab7a93f3676ffedd1f0e65089c@triangulum.uberspace.de>
 <CAHxcRzakVK-HyDb5So0-v6hx6vT0Ld4xVXAjy23RTsF6EHJmMw@mail.gmail.com>
 <bf0f25fb451fac849a2bb06c3ab95130@triangulum.uberspace.de>
 <CAN8ccibiviEQu0N-vZXzA=hH06etDs63ueMg+GE2cBLHj=yGhA@mail.gmail.com>
 <6340063374f1b0b013fb822345018b57@triangulum.uberspace.de>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0084512529=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <6340063374f1b0b013fb822345018b57@triangulum.uberspace.de>
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

--===============0084512529==
Content-Type: multipart/alternative; boundary=001a11407936037d26051967c849

--001a11407936037d26051967c849
Content-Type: text/plain; charset=UTF-8

>>  >
>>  > I'd prefer a multi-purpose configuration with multiple
>> sinks/sources:
>>  >
>>  > - Source 'DAW':                   aux1,aux2,aux3,aux4,aux5,aux6
>>  > - Source 'Mic/Instrument':        channel 0/1 = left/right
>>  > - Source 'Line':                  channel 2/3 = left/right
>>  > - Source 'S/PDIF'                 channel 4/5 = left/right
>>  > - Source 'TV'                     channel 4/5 = left/right
>> (=S/PDIF)
>>  >
>>  > - Sink   'DAW':
>> aux1,aux2,aux3,aux4,aux5,aux6,aux7,aux8,aux9,aux10
>>  > - Sink   'Stereo1/Headphone A':   channel 0/1 = left/right
>>  > - Sink   'Stereo2/Headphone B':   channel 2/3 = left/right
>>  > - Sink   'Stereo3':               channel 4/5 = left/right
>>  > - Sink   'Stereo4':               channel 6/7 = left/right
>>  > - Sink   'Stereo5/SPDIF':         channel 8/9 = left/right
>>  > - Sink   'Surround 7.1':          front-left, front-right,
>> rear-left, rear-right, center, lfe, side-left, side-right
>>  > - Sink   'Surround 7.1 -> 5.0':   front-left, front-right,
>> rear-left, rear-right, center, lfe -> front-left + front-right,
>> side-left -> front-left + rear-left, side-right -> front-right +
>> rear-right
>>
>>
http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain/src/modules/alsa/mixer/profile-sets/native-instruments-traktor-audio10.conf
>> [1]
>>
>>
>> Pulseaudio only support different device
>>
>> If your driver only have simgle device for 10 channel playback and 6
>> channel capture
>
>
> ALSA provides the following hardware-devices/plugs:
>
> - sysdefault:CARD=FCA610
> - front:CARD=FCA610,DEV=0
> - surround21:CARD=FCA610,DEV=0
> - surround40:CARD=FCA610,DEV=0
> - surround41:CARD=FCA610,DEV=0
> - surround50:CARD=FCA610,DEV=0
> - surround51:CARD=FCA610,DEV=0
> - surround71:CARD=FCA610,DEV=0
> - iec958:CARD=FCA610,DEV=0
> - dmix:CARD=FCA610,DEV=0
> - dsnoop:CARD=FCA610,DEV=0
> - hw:CARD=FCA610,DEV=0
> - plughw:CARD=FCA610,DEV=0

Are you sure that those devices really work ?

--001a11407936037d26051967c849
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt; =C2=A0&gt; I&#39;d prefer a multi-purpose configuration with multi=
ple<br>
&gt;&gt; sinks/sources:<br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt; =C2=A0&gt; - Source &#39;DAW&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aux1,aux2,aux3,aux4,aux5,aux6<br>
&gt;&gt; =C2=A0&gt; - Source &#39;Mic/Instrument&#39;:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 channel 0/1 =3D left/right<br>
&gt;&gt; =C2=A0&gt; - Source &#39;Line&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 channel 2/3 =3D left/right<br>
&gt;&gt; =C2=A0&gt; - Source &#39;S/PDIF&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0channel 4/5 =3D left/right<br>
&gt;&gt; =C2=A0&gt; - Source &#39;TV&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0channel 4/5 =3D left/right<br>
&gt;&gt; (=3DS/PDIF)<br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt; =C2=A0&gt; - Sink=C2=A0 =C2=A0&#39;DAW&#39;:<br>
&gt;&gt; aux1,aux2,aux3,aux4,aux5,aux6,aux7,aux8,aux9,aux10<br>
&gt;&gt; =C2=A0&gt; - Sink=C2=A0 =C2=A0&#39;Stereo1/Headphone A&#39;:=C2=A0=
 =C2=A0channel 0/1 =3D left/right<br>
&gt;&gt; =C2=A0&gt; - Sink=C2=A0 =C2=A0&#39;Stereo2/Headphone B&#39;:=C2=A0=
 =C2=A0channel 2/3 =3D left/right<br>
&gt;&gt; =C2=A0&gt; - Sink=C2=A0 =C2=A0&#39;Stereo3&#39;:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0channel 4/5 =3D left/right<br>
&gt;&gt; =C2=A0&gt; - Sink=C2=A0 =C2=A0&#39;Stereo4&#39;:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0channel 6/7 =3D left/right<br>
&gt;&gt; =C2=A0&gt; - Sink=C2=A0 =C2=A0&#39;Stereo5/SPDIF&#39;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0channel 8/9 =3D left/right<br>
&gt;&gt; =C2=A0&gt; - Sink=C2=A0 =C2=A0&#39;Surround 7.1&#39;:=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 front-left, front-right,<br>
&gt;&gt; rear-left, rear-right, center, lfe, side-left, side-right<br>
&gt;&gt; =C2=A0&gt; - Sink=C2=A0 =C2=A0&#39;Surround 7.1 -&gt; 5.0&#39;:=C2=
=A0 =C2=A0front-left, front-right,<br>
&gt;&gt; rear-left, rear-right, center, lfe -&gt; front-left + front-right,=
<br>
&gt;&gt; side-left -&gt; front-left + rear-left, side-right -&gt; front-rig=
ht +<br>
&gt;&gt; rear-right<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain=
/src/modules/alsa/mixer/profile-sets/native-instruments-traktor-audio10.con=
f">http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain/src/modules/alsa=
/mixer/profile-sets/native-instruments-traktor-audio10.conf</a><br>
&gt;&gt; [1]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Pulseaudio only support different device<br>
&gt;&gt;<br>
&gt;&gt; If your driver only have simgle device for 10 channel playback and=
 6<br>
&gt;&gt; channel capture<br>
&gt;<br>
&gt;<br>
&gt; ALSA provides the following hardware-devices/plugs:<br>
&gt;<br>
&gt; - sysdefault:CARD=3DFCA610<br>
&gt; - front:CARD=3DFCA610,DEV=3D0<br>
&gt; - surround21:CARD=3DFCA610,DEV=3D0<br>
&gt; - surround40:CARD=3DFCA610,DEV=3D0<br>
&gt; - surround41:CARD=3DFCA610,DEV=3D0<br>
&gt; - surround50:CARD=3DFCA610,DEV=3D0<br>
&gt; - surround51:CARD=3DFCA610,DEV=3D0<br>
&gt; - surround71:CARD=3DFCA610,DEV=3D0<br>
&gt; - iec958:CARD=3DFCA610,DEV=3D0<br>
&gt; - dmix:CARD=3DFCA610,DEV=3D0<br>
&gt; - dsnoop:CARD=3DFCA610,DEV=3D0<br>
&gt; - hw:CARD=3DFCA610,DEV=3D0<br>
&gt; - plughw:CARD=3DFCA610,DEV=3D0<br></p>
<p>Are you sure that those devices really work ?<br>
</p>

--001a11407936037d26051967c849--

--===============0084512529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0084512529==--

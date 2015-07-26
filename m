From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - surround 21 and
	surround40 pulseaudio bug
Date: Sun, 26 Jul 2015 10:17:50 +0800
Message-ID: <CAN8cciagP912voYwKYcQMJqKCo2yXVfxqqn8=DZfsy-OPVkeJQ@mail.gmail.com>
References: <CAN8ccia5WmnD8mcONVs8khQ6bg7zcKVDqMUq6m03-XL=yG3+pw@mail.gmail.com>
 <CAN8cciY=jvmo+PC8wfC_ji+5OQ5eqKwVGUnrAnrU-=+j204PKQ@mail.gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1060072265=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8cciY=jvmo+PC8wfC_ji+5OQ5eqKwVGUnrAnrU-=+j204PKQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: Arthur Borsboom <arthurborsboom@gmail.com>, pulseaudio-discuss@lists.freedesktop.org
Cc: =?UTF-8?B?xYF1a2FzeiBX?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1060072265==
Content-Type: multipart/alternative; boundary=047d7b33d34808b260051bbdd8ee

--047d7b33d34808b260051bbdd8ee
Content-Type: text/plain; charset=UTF-8

>
> Alsa-info patched kernel:
http://www.alsa-project.org/db/?f=cd23a3f0bb72e38d73224620e3e8ab57a73aa441
>
> Chmap results:
>
> Type = FIXED, Channels = 2
>   FL FR
> Type = FIXED, Channels = 4
>   FL FR NA LFE
>
> When unplugging the subwoofer, then chmap gives this and stays like this.
>
> Cannot open PCM stream hw:1 for PLAYBACK
>
> [Pavucontrol] -> [Configuration] -> [Built-in Audio] gives
>
> Analog Stereo Duplex
> Analog Stereo Output
> Analog Surround 2.1 Output + Analog Stereo Input
> Analog Surround 2.1 Output
> Analog Surround 4.0 Output + Analog Stereo Input
> Analog Surround 4.0 Output
> Analog Stereo Input
> Off

Seem pulseaudio bug since your laptop does not have surround40 chmap

It is not clear how pulseaudio's 21 channel-map match with alsa's 2.1 chmap

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/profile-sets/default.conf

[Mapping analog-surround-21]
device-strings = surround21:%f
channel-map = front-left,front-right,lfe
paths-output = analog-output analog-output-lineout analog-output-speaker
priority = 8
direction = output

[Mapping analog-surround-40]
device-strings = surround40:%f
channel-map = front-left,front-right,rear-left,rear-right
paths-output = analog-output analog-output-lineout analog-output-speaker
priority = 7
direction = output
>
> Pulseaudio verbose log while plugging in the subwoofer:
http://pastebin.com/Ya5u1qz6

https://bugs.freedesktop.org/enter_bug.cgi?product=PulseAudio

--047d7b33d34808b260051bbdd8ee
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;<br>
&gt; Alsa-info patched kernel:=C2=A0<a href=3D"http://www.alsa-project.org/=
db/?f=3Dcd23a3f0bb72e38d73224620e3e8ab57a73aa441">http://www.alsa-project.o=
rg/db/?f=3Dcd23a3f0bb72e38d73224620e3e8ab57a73aa441</a><br>
&gt;<br>
&gt; Chmap results:<br>
&gt;<br>
&gt; Type =3D FIXED, Channels =3D 2<br>
&gt; =C2=A0 FL FR<br>
&gt; Type =3D FIXED, Channels =3D 4<br>
&gt; =C2=A0 FL FR NA LFE<br>
&gt; =C2=A0<br>
&gt; When unplugging the subwoofer, then chmap gives this and stays like th=
is.<br>
&gt;<br>
&gt; Cannot open PCM stream hw:1 for PLAYBACK<br>
&gt;<br>
&gt; [Pavucontrol] -&gt; [Configuration] -&gt; [Built-in Audio] gives<br>
&gt;<br>
&gt; Analog Stereo Duplex<br>
&gt; Analog Stereo Output<br>
&gt; Analog Surround 2.1 Output + Analog Stereo Input<br>
&gt; Analog Surround 2.1 Output=C2=A0<br>
&gt; Analog Surround 4.0 Output + Analog Stereo Input<br>
&gt; Analog Surround 4.0 Output=C2=A0<br>
&gt; Analog Stereo Input<br>
&gt; Off</p>
<p>Seem pulseaudio bug since your laptop does not have surround40 chmap</p>
<p>It is not clear how pulseaudio&#39;s 21 channel-map match with alsa&#39;=
s 2.1 chmap </p>
<p><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/mo=
dules/alsa/mixer/profile-sets/default.conf">http://cgit.freedesktop.org/pul=
seaudio/pulseaudio/tree/src/modules/alsa/mixer/profile-sets/default.conf</a=
></p>
<p>[Mapping analog-surround-21]<br>
device-strings =3D surround21:%f<br>
channel-map =3D front-left,front-right,lfe<br>
paths-output =3D analog-output analog-output-lineout analog-output-speaker<=
br>
priority =3D 8<br>
direction =3D output</p>
<p>[Mapping analog-surround-40]<br>
device-strings =3D surround40:%f<br>
channel-map =3D front-left,front-right,rear-left,rear-right<br>
paths-output =3D analog-output analog-output-lineout analog-output-speaker<=
br>
priority =3D 7<br>
direction =3D output<br>
&gt;<br>
&gt; Pulseaudio verbose log while plugging in the subwoofer:=C2=A0<a href=
=3D"http://pastebin.com/Ya5u1qz6">http://pastebin.com/Ya5u1qz6</a></p>
<p><a href=3D"https://bugs.freedesktop.org/enter_bug.cgi?product=3DPulseAud=
io">https://bugs.freedesktop.org/enter_bug.cgi?product=3DPulseAudio</a><br>
</p>

--047d7b33d34808b260051bbdd8ee--

--===============1060072265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============1060072265==--

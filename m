From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 0/1] alsa: Make profiles'
 availability dynamic
Date: Fri, 19 Feb 2016 13:32:04 +0800
Message-ID: <CAN8ccibqKC5FmOkOHjieHGvLymbw6HeCOeK44j3MLexWuy+yPw@mail.gmail.com>
References: <cover.1455720208.git.bob.ham@collabora.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1562355497=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1455720208.git.bob.ham@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1562355497==
Content-Type: multipart/alternative; boundary=001a114020289f298f052c18cd7c

--001a114020289f298f052c18cd7c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2016-2-18 =E4=B8=8B=E5=8D=885:38=E6=96=BC "Bob Ham" <bob.ham@collabora.com>=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Make ALSA profiles stick around and update their availability if the
> HDMI ELD changes.  This alters the presence of card profiles quite
> dramatically.  Specifically, the existing autogeneration of profiles
> generates a large set of input/output mapping combinations and all of
> these combinations are reported by the API, marked as unavailable. To
> give an idea of the consequences, here is what pavucontrol looks like
> with this patch:
>
>   https://people.collabora.com/~rah/pavucontrol-unavailable-profiles.png
>
> Similarly, here is the output of "pactl list cards":
>
>   https://people.collabora.com/~rah/pactl-list-cards-output.txt
>

AFAIK,

1) mono is not supported by hda-intel
2) those desktop with three jacks at rear panel need retasking input jacks
to output jacks by changing control channel mode from 2ch to 6ch, you may
need to add hook for alsa devices to change the channel mode in alsa
HDA-Intel.conf
3) even HDMI codec support 8 channels, it still require your hdmi monitor
support multi channels

--001a114020289f298f052c18cd7c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
2016-2-18 =E4=B8=8B=E5=8D=885:38=E6=96=BC &quot;Bob Ham&quot; &lt;<a href=
=3D"mailto:bob.ham@collabora.com">bob.ham@collabora.com</a>&gt;=E5=AF=AB=E9=
=81=93=EF=BC=9A<br>
&gt;<br>
&gt; Make ALSA profiles stick around and update their availability if the<b=
r>
&gt; HDMI ELD changes.=C2=A0 This alters the presence of card profiles quit=
e<br>
&gt; dramatically.=C2=A0 Specifically, the existing autogeneration of profi=
les<br>
&gt; generates a large set of input/output mapping combinations and all of<=
br>
&gt; these combinations are reported by the API, marked as unavailable. To<=
br>
&gt; give an idea of the consequences, here is what pavucontrol looks like<=
br>
&gt; with this patch:<br>
&gt;<br>
&gt; =C2=A0 <a href=3D"https://people.collabora.com/~rah/pavucontrol-unavai=
lable-profiles.png">https://people.collabora.com/~rah/pavucontrol-unavailab=
le-profiles.png</a><br>
&gt;<br>
&gt; Similarly, here is the output of &quot;pactl list cards&quot;:<br>
&gt;<br>
&gt; =C2=A0 <a href=3D"https://people.collabora.com/~rah/pactl-list-cards-o=
utput.txt">https://people.collabora.com/~rah/pactl-list-cards-output.txt</a=
><br>
&gt;</p>
<p>AFAIK,</p>
<p>1) mono is not supported by hda-intel<br>
2) those desktop with three jacks at rear panel need retasking input jacks =
to output jacks by changing control channel mode from 2ch to 6ch, you may n=
eed to add hook for alsa devices to change the channel mode in alsa HDA-Int=
el.conf<br>
3) even HDMI codec support 8 channels, it still require your hdmi monitor s=
upport multi channels<br>
</p>

--001a114020289f298f052c18cd7c--

--===============1562355497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vcHVs
c2VhdWRpby1kaXNjdXNzCg==

--===============1562355497==--

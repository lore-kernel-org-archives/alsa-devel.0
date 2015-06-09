From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fwd: [alsa-devel] Front speakers doesn't
 work in multichannel output, regression in ALC888
Date: Tue, 9 Jun 2015 10:23:06 +0800
Message-ID: <CAN8ccibCat-9NKX0EwMMqQTKuSbjJFcSWd_ypprdSC2FMzvfuw@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <8386507.uauZCcniqC@luklap.workgroup>
 <CAN8cciaTZYOQAkaE2aquzcZ_a1QkJAz7u+ff2ceTyrXnKr50RQ@mail.gmail.com>
 <5853893.pVbPai8A2z@luklap.workgroup>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0185247093=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <5853893.pVbPai8A2z@luklap.workgroup>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

--===============0185247093==
Content-Type: multipart/alternative; boundary=001a11c338ec53919f05180c70b4

--001a11c338ec53919f05180c70b4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> > > No change.
> > >
http://www.alsa-project.org/db/?f=3D30b3f0087374b914a20dbe20a618fb892a5d6fd=
5
> >
> > Are there any  offical specificaion ?
> >
> > So far most review only mention stereo speakers and subwoofer, the
service
> > guide only show how to replace two internal speakers
>
> Service manual mentions
>  "Dolby=C2=AE-certified surround sound system with two built-in stereo
speakers and
> one subwoofer supporting low-frequency effects"
>
> so all additional channels what I'm hearing in Windows is emulated. I hop=
e
> that it is clear now that my laptop has two internal speakers and one
> subwoofer.
>

You have to determine which node 0x16 or 0x17 is your subwoofer and remove
the redundant speaker pin fixup

>Thanks. I know how to help myself, but I expected it by default. I wonder
how > many other users will manage to get their sound working good as
before > regression. > And wasn't "model=3Dacer-aspire-4930g" some sort of
early patching which was > thrown out of official code?

After remove the redundant internal speaker, 5.1 is only available after
you change the channel mode

Can  alsactl restore the channel mode before pulseaudio probe the sound
cards ?

Auto mic select is not enabled when the notebook has mic jack and line in
jack , internl mic

As jack retasking is specific to snd-hda-intel and some multi cjannel ac97
codecs

It is not easy to force pulseaudio to stop all client connection, reprobe
the profiles on board audio after jack retasking

hdajackretask also perform the same function
stop pulseaudio and using dynamic reconfiguration/early patching

For those notebook with headphone spdif combo jack, it need a customised
iec958.conf and you can use headphone jack to make iec958 unavailable

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mix=
er/paths/iec958-stereo-output.conf

[Jack Headphone]
state.plugged =3D no
state.unplugged =3D unknown

--001a11c338ec53919f05180c70b4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt; &gt; &gt; No change.<br>
&gt; &gt; &gt;<a href=3D"http://www.alsa-project.org/db/?f=3D30b3f0087374b9=
14a20dbe20a618fb892a5d6fd5"> http://www.alsa-project.org/db/?f=3D30b3f00873=
74b914a20dbe20a618fb892a5d6fd5</a><br>
&gt; &gt;<br>
&gt; &gt; Are there any=C2=A0 offical specificaion ?<br>
&gt; &gt;<br>
&gt; &gt; So far most review only mention stereo speakers and subwoofer, th=
e service<br>
&gt; &gt; guide only show how to replace two internal speakers<br>
&gt;<br>
&gt; Service manual mentions<br>
&gt; =C2=A0&quot;Dolby=C2=AE-certified surround sound system with two built=
-in stereo speakers and<br>
&gt; one subwoofer supporting low-frequency effects&quot;<br>
&gt;<br>
&gt; so all additional channels what I&#39;m hearing in Windows is emulated=
. I hope<br>
&gt; that it is clear now that my laptop has two internal speakers and one<=
br>
&gt; subwoofer.<br>
&gt;</p>
<p>You have to determine which node 0x16 or 0x17 is your subwoofer and remo=
ve the redundant speaker pin fixup</p>
<p>&gt;Thanks. I know how to help myself, but I expected it by default. I w=
onder how &gt; many other users will manage to get their sound working good=
 as before &gt; regression. &gt; And wasn&#39;t &quot;model=3Dacer-aspire-4=
930g&quot; some sort of early patching which was &gt; thrown out of officia=
l code?</p>
<p>After remove the redundant internal speaker, 5.1 is only available after=
 you change the channel mode</p>
<p>Can=C2=A0 alsactl restore the channel mode before pulseaudio probe the s=
ound cards ?</p>
<p>Auto mic select is not enabled when the notebook has mic jack and line i=
n jack , internl mic</p>
<p>As jack retasking is specific to snd-hda-intel and some multi cjannel ac=
97 codecs</p>
<p>It is not easy to force pulseaudio to stop all client connection, reprob=
e the profiles on board audio after jack retasking</p>
<p>hdajackretask also perform the same function <br>
stop pulseaudio and using dynamic reconfiguration/early patching<br><br></p=
>
<p>For those notebook with headphone spdif combo jack, it need a customised=
 iec958.conf and you can use headphone jack to make iec958 unavailable</p>
<p><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/mo=
dules/alsa/mixer/paths/iec958-stereo-output.conf">http://cgit.freedesktop.o=
rg/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/iec958-stereo-ou=
tput.conf</a></p>
<p>[Jack Headphone]<br>
state.plugged =3D no <br>
state.unplugged =3D unknown</p>

--001a11c338ec53919f05180c70b4--

--===============0185247093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0185247093==--

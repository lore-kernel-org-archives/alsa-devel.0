From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange hardware: XFX nForce 780i SLI MCP
Date: Wed, 8 Jul 2015 15:54:48 +0800
Message-ID: <CAN8ccibQe52v2WLLe5SFBxjo1oD4=MJqwJUck=D0hmhs2-6VAg@mail.gmail.com>
References: <559CA29B.90805@gmail.com>
 <CAN8cciaQkyxsQUbtF1cyVSwTRyYPy1MMiCe5Gb0kz71B-5v1JQ@mail.gmail.com>
 <559CB0B9.4040202@gmail.com>
 <CALe1tJ=8MpurUMGQpXfxMV=KzqdCzeBsGx7RhK10149Ur3VQbQ@mail.gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1219751880=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CALe1tJ=8MpurUMGQpXfxMV=KzqdCzeBsGx7RhK10149Ur3VQbQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1219751880==
Content-Type: multipart/alternative; boundary=001a1141bdeaf3414c051a5873ee

--001a1141bdeaf3414c051a5873ee
Content-Type: text/plain; charset=UTF-8

>
> I can confirm that there is no such setting in the BIOS.
>

Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital Control: name="HDMI
Phantom Jack", index=0, device=0 Pincap 0x00000010: OUT Pin Default
0x18567530: [Jack] Digital Out at Int HDMI Conn = Digital, Color = Yellow
DefAssociation = 0x3, Sequence = 0x0 Misc = NO_PRESENCE Pin-ctls: 0x40: OUT
Connection: 1
0x10

Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital Control: name="SPDIF
Phantom Jack", index=0, device=0 Pincap 0x00000010: OUT Pin Default
0x01441520: [Jack] SPDIF Out at Ext Rear Conn = RCA, Color = Black
DefAssociation = 0x2, Sequence = 0x0 Misc = NO_PRESENCE Pin-ctls: 0x40: OUT
Connection: 1
0x06

The easy workaround is use hdajackretask change the internal spdif
connector node 0x11 as not connected if you only use spdif out at rear
panel node 0x1e

Otherwise , you need to sort autocfg.dig_out_pins by def assoc or location
so the pin with  spdif out at ext instead of the internal spdif connector
digitak out at Int  is first digital pin

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/pci/hda/hda_auto_parser.c

--001a1141bdeaf3414c051a5873ee
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;<br>
&gt; I can confirm that there is no such setting in the BIOS.<br>
&gt;<br><br></p>
<p>Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital Control: name=3D&qu=
ot;HDMI Phantom Jack&quot;, index=3D0, device=3D0 Pincap 0x00000010: OUT Pi=
n Default 0x18567530: [Jack] Digital Out at Int HDMI Conn =3D Digital, Colo=
r =3D Yellow DefAssociation =3D 0x3, Sequence =3D 0x0 Misc =3D NO_PRESENCE =
Pin-ctls: 0x40: OUT Connection: 1 <br>
0x10</p>
<p>Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital Control: name=3D&qu=
ot;SPDIF Phantom Jack&quot;, index=3D0, device=3D0 Pincap 0x00000010: OUT P=
in Default 0x01441520: [Jack] SPDIF Out at Ext Rear Conn =3D RCA, Color =3D=
 Black DefAssociation =3D 0x2, Sequence =3D 0x0 Misc =3D NO_PRESENCE Pin-ct=
ls: 0x40: OUT Connection: 1 <br>
0x06</p>
<p>The easy workaround is use hdajackretask change the internal spdif conne=
ctor node 0x11 as not connected if you only use spdif out at rear panel nod=
e 0x1e</p>
<p>Otherwise , you need to sort autocfg.dig_out_pins by def assoc or locati=
on so the pin with=C2=A0 spdif out at ext instead of the internal spdif con=
nector digitak out at Int=C2=A0 is first digital pin</p>
<p><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/=
tree/sound/pci/hda/hda_auto_parser.c">https://git.kernel.org/cgit/linux/ker=
nel/git/tiwai/sound.git/tree/sound/pci/hda/hda_auto_parser.c</a></p>

--001a1141bdeaf3414c051a5873ee--

--===============1219751880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============1219751880==--

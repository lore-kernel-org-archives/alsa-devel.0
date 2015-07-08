From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange hardware: XFX nForce 780i SLI MCP
Date: Wed, 8 Jul 2015 14:08:16 +0800
Message-ID: <CAN8cciYH0biWwoAfC5DpRwV7vPLSsBCqwQVGEGD8s0D81xB1FQ@mail.gmail.com>
References: <559CA29B.90805@gmail.com>
 <CAN8cciaQkyxsQUbtF1cyVSwTRyYPy1MMiCe5Gb0kz71B-5v1JQ@mail.gmail.com>
 <559CB0B9.4040202@gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0405761329=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <559CB0B9.4040202@gmail.com>
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

--===============0405761329==
Content-Type: multipart/alternative; boundary=089e01538c5cf6f6e1051a56f6d4

--089e01538c5cf6f6e1051a56f6d4
Content-Type: text/plain; charset=UTF-8

>>
>>  >
>>  > Yesterday I got an interesting email related to dcaenc support.
>>  >
>>  > The person has an "XFX nForce 780i SLI" MCP board:
>> http://www.nvidia.com/object/product_nforce_780i_sli_us.html ,
>> http://www.evga.com/support/manuals/files/132-CK-NF78.pdf
>>  >
>>  > As you see on page 18 of the manual, this board has no HDMI output,
>> but there is an optical SPDIF. Strangely enough, this SPDIF is his
>> "hdmi:CARD=NVidia,DEV=0" device.
>>  >
>>  > Given the recent discussions related to dynamically creating PCM
>> devices for HDMI, I think you will be interested in this alsa-info
output.
>>  >
>>  > Is there anything here that would need special treatment by ALSA or
>> PulseAudio? Or, is this just a misnumbered/misnamed codec?
>>  >
>>
>> Check whether BIOS set the internal spdif as HDMI as pin default
>>
>> The alsa driver prefer HDMI  instead of SPDIF when there are two Digital
>> Outs
>>
>
> According to the manual, there is no such setting in the BIOS.
>
> (original reporter BCCed just in case)

Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital
Control: name="HDMI Phantom Jack", index=0, device=0
Pincap 0x00000010: OUT
Pin Default 0x18567530: [Jack] Digital Out at Int HDMI
Conn = Digital, Color = Yellow DefAssociation = 0x3, Sequence = 0x0
Misc = NO_PRESENCE
Pin-ctls: 0x40: OUT
Connection: 1 0x10

Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
Control: name="SPDIF Phantom Jack", index=0, device=0
Pincap 0x00000010: OUT
Pin Default 0x01441520: [Jack] SPDIF Out at Ext Rear
Conn = RCA, Color = Black DefAssociation = 0x2, Sequence = 0x0
Misc = NO_PRESENCE Pin-ctls: 0x40: OUT
Connection: 1 0x06

The driver use the first digital pin's type HDMI or SPDIF , you need to
modify the logic in hda_generic.c when type of two digital pins are
different

--089e01538c5cf6f6e1051a56f6d4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;&gt;<br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt; =C2=A0&gt; Yesterday I got an interesting email related to dcaenc =
support.<br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt; =C2=A0&gt; The person has an &quot;XFX nForce 780i SLI&quot; MCP b=
oard:<br>
&gt;&gt; <a href=3D"http://www.nvidia.com/object/product_nforce_780i_sli_us=
.html">http://www.nvidia.com/object/product_nforce_780i_sli_us.html</a> ,<b=
r>
&gt;&gt; <a href=3D"http://www.evga.com/support/manuals/files/132-CK-NF78.p=
df">http://www.evga.com/support/manuals/files/132-CK-NF78.pdf</a><br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt; =C2=A0&gt; As you see on page 18 of the manual, this board has no =
HDMI output,<br>
&gt;&gt; but there is an optical SPDIF. Strangely enough, this SPDIF is his=
<br>
&gt;&gt; &quot;hdmi:CARD=3DNVidia,DEV=3D0&quot; device.<br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt; =C2=A0&gt; Given the recent discussions related to dynamically cre=
ating PCM<br>
&gt;&gt; devices for HDMI, I think you will be interested in this alsa-info=
 output.<br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt; =C2=A0&gt; Is there anything here that would need special treatmen=
t by ALSA or<br>
&gt;&gt; PulseAudio? Or, is this just a misnumbered/misnamed codec?<br>
&gt;&gt; =C2=A0&gt;<br>
&gt;&gt;<br>
&gt;&gt; Check whether BIOS set the internal spdif as HDMI as pin default<b=
r>
&gt;&gt;<br>
&gt;&gt; The alsa driver prefer HDMI=C2=A0 instead of SPDIF when there are =
two Digital<br>
&gt;&gt; Outs<br>
&gt;&gt;<br>
&gt;<br>
&gt; According to the manual, there is no such setting in the BIOS.<br>
&gt;<br>
&gt; (original reporter BCCed just in case)</p>
<p>Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital <br>
Control: name=3D&quot;HDMI Phantom Jack&quot;, index=3D0, device=3D0 <br>
Pincap 0x00000010: OUT <br>
Pin Default 0x18567530: [Jack] Digital Out at Int HDMI <br>
Conn =3D Digital, Color =3D Yellow DefAssociation =3D 0x3, Sequence =3D 0x0=
 <br>
Misc =3D NO_PRESENCE <br>
Pin-ctls: 0x40: OUT <br>
Connection: 1 0x10</p>
<p>Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital <br>
Control: name=3D&quot;SPDIF Phantom Jack&quot;, index=3D0, device=3D0 <br>
Pincap 0x00000010: OUT <br>
Pin Default 0x01441520: [Jack] SPDIF Out at Ext Rear <br>
Conn =3D RCA, Color =3D Black DefAssociation =3D 0x2, Sequence =3D 0x0 <br>
Misc =3D NO_PRESENCE Pin-ctls: 0x40: OUT <br>
Connection: 1 0x06<br></p>
<p>The driver use the first digital pin&#39;s type HDMI or SPDIF , you need=
 to modify the logic in hda_generic.c when type of two digital pins are dif=
ferent</p>

--089e01538c5cf6f6e1051a56f6d4--

--===============0405761329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0405761329==--

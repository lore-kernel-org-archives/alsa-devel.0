From: Nick Orn <raptorthedk@gmail.com>
Subject: Re: Strange hardware: XFX nForce 780i SLI MCP
Date: Tue, 7 Jul 2015 23:28:05 -0700
Message-ID: <CALe1tJ=8MpurUMGQpXfxMV=KzqdCzeBsGx7RhK10149Ur3VQbQ@mail.gmail.com>
References: <559CA29B.90805@gmail.com>
 <CAN8cciaQkyxsQUbtF1cyVSwTRyYPy1MMiCe5Gb0kz71B-5v1JQ@mail.gmail.com>
 <559CB0B9.4040202@gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0801259080=="
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
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============0801259080==
Content-Type: multipart/alternative; boundary=f46d04138a9ddecd68051a573d12

--f46d04138a9ddecd68051a573d12
Content-Type: text/plain; charset=UTF-8

I can confirm that there is no such setting in the BIOS.

On Tue, Jul 7, 2015 at 10:10 PM, Alexander E. Patrakov <patrakov@gmail.com>
wrote:

> 08.07.2015 09:55, Raymond Yau wrote:
>
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
>> devices for HDMI, I think you will be interested in this alsa-info output.
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
>>
> According to the manual, there is no such setting in the BIOS.
>
> (original reporter BCCed just in case)
>
> --
> Alexander E. Patrakov
>

--f46d04138a9ddecd68051a573d12
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I can confirm that there is no such setting in the BIOS.<b=
r></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, J=
ul 7, 2015 at 10:10 PM, Alexander E. Patrakov <span dir=3D"ltr">&lt;<a href=
=3D"mailto:patrakov@gmail.com" target=3D"_blank">patrakov@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">08.07.2015 09:55, Raymond =
Yau wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0&gt;<br>
=C2=A0&gt; Yesterday I got an interesting email related to dcaenc support.<=
br>
=C2=A0&gt;<br>
=C2=A0&gt; The person has an &quot;XFX nForce 780i SLI&quot; MCP board:<br>
<a href=3D"http://www.nvidia.com/object/product_nforce_780i_sli_us.html" re=
l=3D"noreferrer" target=3D"_blank">http://www.nvidia.com/object/product_nfo=
rce_780i_sli_us.html</a> ,<br>
<a href=3D"http://www.evga.com/support/manuals/files/132-CK-NF78.pdf" rel=
=3D"noreferrer" target=3D"_blank">http://www.evga.com/support/manuals/files=
/132-CK-NF78.pdf</a><br>
=C2=A0&gt;<br>
=C2=A0&gt; As you see on page 18 of the manual, this board has no HDMI outp=
ut,<br>
but there is an optical SPDIF. Strangely enough, this SPDIF is his<br>
&quot;hdmi:CARD=3DNVidia,DEV=3D0&quot; device.<br>
=C2=A0&gt;<br>
=C2=A0&gt; Given the recent discussions related to dynamically creating PCM=
<br>
devices for HDMI, I think you will be interested in this alsa-info output.<=
br>
=C2=A0&gt;<br>
=C2=A0&gt; Is there anything here that would need special treatment by ALSA=
 or<br>
PulseAudio? Or, is this just a misnumbered/misnamed codec?<br>
=C2=A0&gt;<br>
<br>
Check whether BIOS set the internal spdif as HDMI as pin default<br>
<br>
The alsa driver prefer HDMI=C2=A0 instead of SPDIF when there are two Digit=
al<br>
Outs<br>
<br>
</blockquote>
<br>
According to the manual, there is no such setting in the BIOS.<br>
<br>
(original reporter BCCed just in case)<span class=3D"HOEnZb"><font color=3D=
"#888888"><br>
<br>
-- <br>
Alexander E. Patrakov<br>
</font></span></blockquote></div><br></div>

--f46d04138a9ddecd68051a573d12--

--===============0801259080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0801259080==--

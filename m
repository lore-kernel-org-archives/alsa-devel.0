From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange hardware: XFX nForce 780i SLI MCP
Date: Wed, 8 Jul 2015 12:55:38 +0800
Message-ID: <CAN8cciaQkyxsQUbtF1cyVSwTRyYPy1MMiCe5Gb0kz71B-5v1JQ@mail.gmail.com>
References: <559CA29B.90805@gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0072005873=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <559CA29B.90805@gmail.com>
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

--===============0072005873==
Content-Type: multipart/alternative; boundary=e89a8fb1ec2831695a051a55f3b9

--e89a8fb1ec2831695a051a55f3b9
Content-Type: text/plain; charset=UTF-8

>
> Yesterday I got an interesting email related to dcaenc support.
>
> The person has an "XFX nForce 780i SLI" MCP board:
http://www.nvidia.com/object/product_nforce_780i_sli_us.html ,
http://www.evga.com/support/manuals/files/132-CK-NF78.pdf
>
> As you see on page 18 of the manual, this board has no HDMI output, but
there is an optical SPDIF. Strangely enough, this SPDIF is his
"hdmi:CARD=NVidia,DEV=0" device.
>
> Given the recent discussions related to dynamically creating PCM devices
for HDMI, I think you will be interested in this alsa-info output.
>
> Is there anything here that would need special treatment by ALSA or
PulseAudio? Or, is this just a misnumbered/misnamed codec?
>

Check whether BIOS set the internal spdif as HDMI as pin default

The alsa driver prefer HDMI  instead of SPDIF when there are two Digital
Outs

--e89a8fb1ec2831695a051a55f3b9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p></p>
<p>&gt;<br>
&gt; Yesterday I got an interesting email related to dcaenc support.<br>
&gt;<br>
&gt; The person has an &quot;XFX nForce 780i SLI&quot; MCP board: <a href=
=3D"http://www.nvidia.com/object/product_nforce_780i_sli_us.html">http://ww=
w.nvidia.com/object/product_nforce_780i_sli_us.html</a> , <a href=3D"http:/=
/www.evga.com/support/manuals/files/132-CK-NF78.pdf">http://www.evga.com/su=
pport/manuals/files/132-CK-NF78.pdf</a><br>
&gt;<br>
&gt; As you see on page 18 of the manual, this board has no HDMI output, bu=
t there is an optical SPDIF. Strangely enough, this SPDIF is his &quot;hdmi=
:CARD=3DNVidia,DEV=3D0&quot; device.<br>
&gt;<br>
&gt; Given the recent discussions related to dynamically creating PCM devic=
es for HDMI, I think you will be interested in this alsa-info output.<br>
&gt;<br>
&gt; Is there anything here that would need special treatment by ALSA or Pu=
lseAudio? Or, is this just a misnumbered/misnamed codec?<br>
&gt;</p>
<p>Check whether BIOS set the internal spdif as HDMI as pin default </p>
<p>The alsa driver prefer HDMI=C2=A0 instead of SPDIF when there are two Di=
gital Outs<br>
</p>

--e89a8fb1ec2831695a051a55f3b9--

--===============0072005873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0072005873==--

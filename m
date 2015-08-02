From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange hardware: XFX nForce 780i SLI MCP
Date: Sun, 2 Aug 2015 09:44:51 +0800
Message-ID: <CAN8cciYatHgySGs+Rw2YeA1kxCZ6ugTavwAK7PwJEom8Pp1MdA@mail.gmail.com>
References: <559CA29B.90805@gmail.com>
 <CAN8ccib1FsRi95fMHbSpzzpUM05TLwC9zXB4zb3aXoHNpL2_hQ@mail.gmail.com>
 <CAN8cciYbt-h5RZ0Vs02vV=EJqjwKiVMXarvR0Q0RwfLFnNp6=w@mail.gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1931210643=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8cciYbt-h5RZ0Vs02vV=EJqjwKiVMXarvR0Q0RwfLFnNp6=w@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, tiwai@suse.de
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1931210643==
Content-Type: multipart/alternative; boundary=089e01537eb4eeac95051c4a3266

--089e01537eb4eeac95051c4a3266
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

This can also be regarded as bug of hda_auto_parser.c which does not
determine type of digital pin correctly

Those internal spdif connector which can connect to an optional spdif
headser or spdif input header of the graphic card for hdmi audio output

http://www.intel.com/support/motherboards/desktop/sb/CS-032871.htm

But the pincap of these kind of digital pin usually does not support DETECT
nor HDMI

--089e01537eb4eeac95051c4a3266
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
<p>This can also be regarded as bug of hda_auto_parser.c which does not det=
ermine type of digital pin correctly</p>
<p>Those internal spdif connector which can connect to an optional spdif he=
adser or spdif input header of the graphic card for hdmi audio output</p>
<p><a href=3D"http://www.intel.com/support/motherboards/desktop/sb/CS-03287=
1.htm">http://www.intel.com/support/motherboards/desktop/sb/CS-032871.htm</=
a></p>
<p>But the pincap of these kind of digital pin usually does not support DET=
ECT nor HDMI</p>

--089e01537eb4eeac95051c4a3266--

--===============1931210643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============1931210643==--

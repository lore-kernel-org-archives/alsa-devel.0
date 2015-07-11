From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange hardware: XFX nForce 780i SLI MCP
Date: Sat, 11 Jul 2015 10:25:39 +0800
Message-ID: <CAN8ccibpEkOPMH57tBQkTXBvf5Fcf3Jx0cCt3_v_rkt4RkkvTw@mail.gmail.com>
References: <559CA29B.90805@gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1031219300=="
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
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, raptorthedk@gmail.com
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1031219300==
Content-Type: multipart/alternative; boundary=089e01538c5c618b4a051a90345e

--089e01538c5c618b4a051a90345e
Content-Type: text/plain; charset=UTF-8

> Yesterday I got an interesting email related to dcaenc support.
>
> The person has an "XFX nForce 780i SLI" MCP board:
> http://www.nvidia.com/object/product_nforce_780i_sli_us.html ,
> http://www.evga.com/support/manuals/files/132-CK-NF78.pdf
>
> As you see on page 18 of the manual, this board has no HDMI output, but
> there is an optical SPDIF. Strangely enough, this SPDIF is his
> "hdmi:CARD=NVidia,DEV=0" device.
>
> Given the recent discussions related to dynamically creating PCM devices
> for HDMI, I think you will be interested in this alsa-info output.
>
> Is there anything here that would need special treatment by ALSA or
> PulseAudio? Or, is this just a misnumbered/misnamed codec?
>

swap dig_out_pins of autocfg when type are different

diff --git a/sound/pci/hda/hda_auto_parser.c
b/sound/pci/hda/hda_auto_parser.c
index 03b7399..3ff16e8 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -405,6 +405,19 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
     sort(cfg->inputs, cfg->num_inputs, sizeof(cfg->inputs[0]),
          compare_input_type, NULL);

+    if (cfg->dig_outs == 2) {
+        if (cfg->dig_out_type[0] != cfg->dig_out_type[1]) {
+            if (cfg->dig_out_type[0] == HDA_PCM_TYPE_HDMI) {
+                hda_nid_t temp = cfg->dig_out_pins[0];
+                int temp_type =    cfg->dig_out_type[0];
+                cfg->dig_out_pins[0] = cfg->dig_out_pins[1];
+                cfg->dig_out_type[0] = cfg->dig_out_type[1];
+                cfg->dig_out_pins[1] = temp;
+                cfg->dig_out_type[1] = temp_type;
+            }
+        }
+    }
+
     /*
      * debug prints of the parsed results
      */


>
>

--089e01538c5c618b4a051a90345e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Yesterday I got an interesting email related to dcaenc support.<br>
<br>
The person has an &quot;XFX nForce 780i SLI&quot; MCP board: <a href=3D"htt=
p://www.nvidia.com/object/product_nforce_780i_sli_us.html" rel=3D"noreferre=
r" target=3D"_blank">http://www.nvidia.com/object/product_nforce_780i_sli_u=
s.html</a> , <a href=3D"http://www.evga.com/support/manuals/files/132-CK-NF=
78.pdf" rel=3D"noreferrer" target=3D"_blank">http://www.evga.com/support/ma=
nuals/files/132-CK-NF78.pdf</a><br>
<br>
As you see on page 18 of the manual, this board has no HDMI output, but the=
re is an optical SPDIF. Strangely enough, this SPDIF is his &quot;hdmi:CARD=
=3DNVidia,DEV=3D0&quot; device.<br>
<br>
Given the recent discussions related to dynamically creating PCM devices fo=
r HDMI, I think you will be interested in this alsa-info output.<br>
<br>
Is there anything here that would need special treatment by ALSA or PulseAu=
dio? Or, is this just a misnumbered/misnamed codec?<span class=3D""><font c=
olor=3D"#888888"><br></font></span></blockquote><div><br></div><div>swap di=
g_out_pins of autocfg when type are different <br></div><div><br>diff --git=
 a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c<br>ind=
ex 03b7399..3ff16e8 100644<br>--- a/sound/pci/hda/hda_auto_parser.c<br>+++ =
b/sound/pci/hda/hda_auto_parser.c<br>@@ -405,6 +405,19 @@ int snd_hda_parse=
_pin_defcfg(struct hda_codec *codec,<br>=C2=A0=C2=A0=C2=A0=C2=A0 sort(cfg-&=
gt;inputs, cfg-&gt;num_inputs, sizeof(cfg-&gt;inputs[0]),<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compare_input_type, NULL);<br>=C2=A0<=
br>+=C2=A0=C2=A0=C2=A0 if (cfg-&gt;dig_outs =3D=3D 2) {<br>+=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 if (cfg-&gt;dig_out_type[0] !=3D cfg-&gt;dig_out_typ=
e[1]) {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (cf=
g-&gt;dig_out_type[0] =3D=3D HDA_PCM_TYPE_HDMI) {<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 hda_nid_t temp =3D=
 cfg-&gt;dig_out_pins[0];<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int temp_type =3D=C2=A0=C2=A0=C2=A0 cfg-&gt=
;dig_out_type[0];<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 cfg-&gt;dig_out_pins[0] =3D cfg-&gt;dig_out_pins[1];=
<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 cfg-&gt;dig_out_type[0] =3D cfg-&gt;dig_out_type[1];<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cfg-&gt;=
dig_out_pins[1] =3D temp;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cfg-&gt;dig_out_type[1] =3D temp_type;<br>+=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0 }<br>+<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* debug prints of the par=
sed results<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><span class=3D""><font color=3D"#888=
888">
</font></span><br></blockquote></div></div></div>

--089e01538c5c618b4a051a90345e--

--===============1031219300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============1031219300==--

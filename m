From: Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] FIXUP: FROMLIST: ASoC: amd: Report accurate hw_ptr
 during dma
Date: Wed, 8 Nov 2017 09:29:05 -0800
Message-ID: <CABXOdTdgxOFJb0B7VRivFaf1ihfKQWiyXRX9hFnKetTanmjd5w@mail.gmail.com>
References: <20171108172404.19118-1-alexander.deucher@amd.com>
 <20171108172404.19118-4-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1196391760=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108172404.19118-4-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============1196391760==
Content-Type: multipart/alternative; boundary="001a113edb763fde1f055d7c0634"

--001a113edb763fde1f055d7c0634
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 8, 2017 at 9:24 AM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> From: Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> ERROR: "__aeabi_uldivmod" [sound/soc/amd/snd-soc-acp-pcm.ko] undefined!
>
> 64-bit divides require special operations to avoid build errors on 32-bit
> systems.
>
> BUG=b:63121716
> TEST="Build i386:allmodconfig"
>
>
Is this an upstream submission ? Fine with me, but it should not include
any chromium specific tags, neither in the subject not in the description.

Guenter


> Signed-off-by: Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reviewed-on: https://chromium-review.googlesource.com/678919
> Reviewed-by: Jason Clinton <jclinton-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> (cherry picked from commit 7ca726e80f21abdbaed9a5a70def1c33a26f8533)
> Reviewed-on: https://chromium-review.googlesource.com/681618
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  sound/soc/amd/acp-pcm-dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 13d040a4d26f..ef7e98ad960c 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -856,12 +856,11 @@ static snd_pcm_uframes_t acp_dma_pointer(struct
> snd_pcm_substream *substream)
>         if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                 if (bytescount > rtd->renderbytescount)
>                         bytescount = bytescount - rtd->renderbytescount;
> -               pos =  bytescount % buffersize;
>         } else {
>                 if (bytescount > rtd->capturebytescount)
>                         bytescount = bytescount - rtd->capturebytescount;
> -               pos = bytescount % buffersize;
>         }
> +       pos = do_div(bytescount, buffersize);
>         return bytes_to_frames(runtime, pos);
>  }
>
> --
> 2.13.6
>
>

--001a113edb763fde1f055d7c0634
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Nov 8, 2017 at 9:24 AM, Alex Deucher <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">From: Guenter Roeck &lt;<=
a href=3D"mailto:groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
<br>
ERROR: &quot;__aeabi_uldivmod&quot; [sound/soc/amd/snd-soc-acp-<wbr>pcm.ko]=
 undefined!<br>
<br>
64-bit divides require special operations to avoid build errors on 32-bit<b=
r>
systems.<br>
<br>
BUG=3Db:63121716<br>
TEST=3D&quot;Build i386:allmodconfig&quot;<br>
<br></blockquote><div><br></div><div>Is this an upstream submission ? Fine =
with me, but it should not include any chromium specific tags, neither in t=
he subject not in the description.</div><div><br></div><div>Guenter</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">gro=
eck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
Reviewed-on: <a href=3D"https://chromium-review.googlesource.com/678919" re=
l=3D"noreferrer" target=3D"_blank">https://chromium-review.<wbr>googlesourc=
e.com/678919</a><br>
Reviewed-by: Jason Clinton &lt;<a href=3D"mailto:jclinton-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">jcl=
inton-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
(cherry picked from commit 7ca726e80f21abdbaed9a5a70def1c<wbr>33a26f8533)<b=
r>
Reviewed-on: <a href=3D"https://chromium-review.googlesource.com/681618" re=
l=3D"noreferrer" target=3D"_blank">https://chromium-review.<wbr>googlesourc=
e.com/681618</a><br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org=
">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0sound/soc/amd/acp-pcm-dma.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c<br>
index 13d040a4d26f..ef7e98ad960c 100644<br>
--- a/sound/soc/amd/acp-pcm-dma.c<br>
+++ b/sound/soc/amd/acp-pcm-dma.c<br>
@@ -856,12 +856,11 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_p=
cm_substream *substream)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (substream-&gt;stream =3D=3D SNDRV_PCM_STREA=
M_PLAYBACK) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytescount &gt;=
 rtd-&gt;renderbytescount)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bytescount =3D bytescount - rtd-&gt;renderbytescount;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pos =3D=C2=A0 bytes=
count % buffersize;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytescount &gt;=
 rtd-&gt;capturebytescount)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bytescount =3D bytescount - rtd-&gt;capturebytescount;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pos =3D bytescount =
% buffersize;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pos =3D do_div(bytescount, buffersize);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return bytes_to_frames(runtime, pos);<br>
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
2.13.6<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a113edb763fde1f055d7c0634--

--===============1196391760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1196391760==--

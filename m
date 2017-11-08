From: Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 11:13:50 -0800
Message-ID: <CABXOdTd6ptUM3E0V6B_hg9unh+na_XHK6AbyfREx5WiYwdckkA@mail.gmail.com>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
 <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
 <20171108184752.wff6qn6ssguaegkq@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0715699664=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108184752.wff6qn6ssguaegkq-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============0715699664==
Content-Type: multipart/alternative; boundary="001a1140c8e6e57998055d7d7c04"

--001a1140c8e6e57998055d7d7c04
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 8, 2017 at 10:47 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Wed, Nov 08, 2017 at 01:40:32PM -0500, Alex Deucher wrote:
> > On Wed, Nov 8, 2017 at 1:22 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> > > Like I said in reply to your other mail please don't resubmit already
> > > applied patches.  The current tip of my topic/amd branch appears to be
> > > this very patch, if there's anything needs changing please send an
> > > incremental patch.
>
> > I'm not seeing this one in your tree either.  This is just a resend of
> > Guenter's patch from an hour ago with the chromium stuff removed.
> > Maybe you already applied it in the interim?
>
> Is this different to "ASoC: amd: Report accurate hw_ptr during dma"
> which was applied at 16:07?
>

I suspect we may be getting hit by chromeos-isms again. In Chrome OS, we
don't use Fixes: tags but "FIXUP: <original description>" in the subject
(not that I like it, but it is what it is).

Guenter

--001a1140c8e6e57998055d7d7c04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Nov 8, 2017 at 10:47 AM, Mark Brown <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" target=3D"_blank">broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed, Nov 08,=
 2017 at 01:40:32PM -0500, Alex Deucher wrote:<br>
&gt; On Wed, Nov 8, 2017 at 1:22 PM, Mark Brown &lt;<a href=3D"mailto:broon=
ie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org">broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt; wrote:<br>
<br>
</span><span class=3D"">&gt; &gt; Like I said in reply to your other mail p=
lease don&#39;t resubmit already<br>
&gt; &gt; applied patches.=C2=A0 The current tip of my topic/amd branch app=
ears to be<br>
&gt; &gt; this very patch, if there&#39;s anything needs changing please se=
nd an<br>
&gt; &gt; incremental patch.<br>
<br>
&gt; I&#39;m not seeing this one in your tree either.=C2=A0 This is just a =
resend of<br>
&gt; Guenter&#39;s patch from an hour ago with the chromium stuff removed.<=
br>
&gt; Maybe you already applied it in the interim?<br>
<br>
</span>Is this different to &quot;ASoC: amd: Report accurate hw_ptr during =
dma&quot;<br>
which was applied at 16:07?<br>
</blockquote></div><br></div><div class=3D"gmail_extra">I suspect we may be=
 getting hit by chromeos-isms again. In Chrome OS, we don&#39;t use Fixes: =
tags but &quot;FIXUP: &lt;original description&gt;&quot; in the subject (no=
t that I like it, but it is what it is).</div><div class=3D"gmail_extra"><b=
r></div><div class=3D"gmail_extra">Guenter</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra"><br></div></div>

--001a1140c8e6e57998055d7d7c04--

--===============0715699664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0715699664==--

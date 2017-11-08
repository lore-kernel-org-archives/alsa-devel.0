From: Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 11:30:55 -0800
Message-ID: <CABXOdTf=nEu_KAnAvT0p9tn96xiGGSqYzW1o0XUBDf9EHb+CoA@mail.gmail.com>
References: <20171108181841.29332-1-alexander.deucher@amd.com>
 <20171108182214.bwdvt5wwwz7wqf32@sirena.co.uk>
 <CADnq5_PM=C9OjseqvV8M5ohm7Mo18foHGPUkFZSnVNpVruut8Q@mail.gmail.com>
 <20171108184752.wff6qn6ssguaegkq@sirena.co.uk>
 <BN6PR12MB1652F8671D062FDE91D42951F7560@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0405287937=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652F8671D062FDE91D42951F7560-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============0405287937==
Content-Type: multipart/alternative; boundary="001a114dac12fd878e055d7db97c"

--001a114dac12fd878e055d7db97c
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 8, 2017 at 11:18 AM, Deucher, Alexander <
Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:

> > -----Original Message-----
> > From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> > Sent: Wednesday, November 08, 2017 1:48 PM
> > To: Alex Deucher
> > Cc: amd-gfx list; alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; Maling list - DRI
> developers;
> > Mukunda, Vijendar; Liam Girdwood; Takashi Iwai; Guenter Roeck; Deucher,
> > Alexander
> > Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma
> >
> > On Wed, Nov 08, 2017 at 01:40:32PM -0500, Alex Deucher wrote:
> > > On Wed, Nov 8, 2017 at 1:22 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > wrote:
> >
> > > > Like I said in reply to your other mail please don't resubmit already
> > > > applied patches.  The current tip of my topic/amd branch appears to
> be
> > > > this very patch, if there's anything needs changing please send an
> > > > incremental patch.
> >
> > > I'm not seeing this one in your tree either.  This is just a resend of
> > > Guenter's patch from an hour ago with the chromium stuff removed.
> > > Maybe you already applied it in the interim?
> >
> > Is this different to "ASoC: amd: Report accurate hw_ptr during dma"
> > which was applied at 16:07?
>
> Yes, this is a fix for that patch.  It fixes a 64 bit division that wasn't
> properly handled.
>
>
In that case, the subject should reflect the problem fixed, the description
should describe the problem, and there should be a Fixes: tag pointing to
the problematic patch.

Sorry, I was not aware that the problematic patch is already pending
upstream, or I would have submitted a proper patch upstream myself.

Guenter


> Alex
>
>

--001a114dac12fd878e055d7db97c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Nov 8, 2017 at 11:18 AM, Deucher, Alexander <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Alexander.Deucher=
@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cla=
ss=3D"HOEnZb"><div class=3D"h5">&gt; -----Original Message-----<br>
&gt; From: Mark Brown [mailto:<a href=3D"mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org">broonie=
@kernel.org</a>]<br>
&gt; Sent: Wednesday, November 08, 2017 1:48 PM<br>
&gt; To: Alex Deucher<br>
&gt; Cc: amd-gfx list; <a href=3D"mailto:alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org">alsa-=
devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org</a>; Maling list - DRI developers;<br>
&gt; Mukunda, Vijendar; Liam Girdwood; Takashi Iwai; Guenter Roeck; Deucher=
,<br>
&gt; Alexander<br>
&gt; Subject: Re: [PATCH] ASoC: amd: fix report accurate hw_ptr during dma<=
br>
&gt;<br>
&gt; On Wed, Nov 08, 2017 at 01:40:32PM -0500, Alex Deucher wrote:<br>
&gt; &gt; On Wed, Nov 8, 2017 at 1:22 PM, Mark Brown &lt;<a href=3D"mailto:=
broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org">broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; &gt; Like I said in reply to your other mail please don&#39;t res=
ubmit already<br>
&gt; &gt; &gt; applied patches.=C2=A0 The current tip of my topic/amd branc=
h appears to be<br>
&gt; &gt; &gt; this very patch, if there&#39;s anything needs changing plea=
se send an<br>
&gt; &gt; &gt; incremental patch.<br>
&gt;<br>
&gt; &gt; I&#39;m not seeing this one in your tree either.=C2=A0 This is ju=
st a resend of<br>
&gt; &gt; Guenter&#39;s patch from an hour ago with the chromium stuff remo=
ved.<br>
&gt; &gt; Maybe you already applied it in the interim?<br>
&gt;<br>
&gt; Is this different to &quot;ASoC: amd: Report accurate hw_ptr during dm=
a&quot;<br>
&gt; which was applied at 16:07?<br>
<br>
</div></div>Yes, this is a fix for that patch.=C2=A0 It fixes a 64 bit divi=
sion that wasn&#39;t properly handled.<br>
<br></blockquote><div><br></div><div>In that case, the subject should refle=
ct the problem fixed, the description should describe the problem, and ther=
e should be a Fixes: tag pointing to the problematic patch.</div><div><br><=
/div><div>Sorry, I was not aware that the problematic patch is already pend=
ing upstream, or I would have submitted a proper patch upstream myself.</di=
v><div><br></div><div>Guenter</div><div>=C2=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
Alex<br>
<br>
</blockquote></div><br></div></div>

--001a114dac12fd878e055d7db97c--

--===============0405287937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0405287937==--

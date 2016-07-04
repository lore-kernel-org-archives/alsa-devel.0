From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH] drm: sti: fix prototypes after API change
Date: Mon, 4 Jul 2016 15:27:18 +0200
Message-ID: <CA+M3ks5FcGKL9sDZNJaux4F1oyWwmiOiF5aK2ATc=5Cg3p69=g@mail.gmail.com>
References: <20160704131651.1083630-1-arnd@arndb.de>
 <20160704132230.GD6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0235854404=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160704132230.GD6247@sirena.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, kernel@stlinux.com, Arnd Bergmann <arnd@arndb.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============0235854404==
Content-Type: multipart/alternative; boundary=001a113fa6dca310d60536cf4b87

--001a113fa6dca310d60536cf4b87
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

2016-07-04 15:22 GMT+02:00 Mark Brown <broonie@kernel.org>:

> On Mon, Jul 04, 2016 at 03:16:51PM +0200, Arnd Bergmann wrote:
>
> > This follows the API change, adding the extra function arguments.
> > I suppose we want this to be part of the ASoC merge in linux-next
> > for now too.
>
> I sent a pull request for the API change to the DRM people which might
> be easier given that it's a single commit topic branch rather than the
> whole of DRM.
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>


--=20

Benjamin Gaignard

Graphic Working Group

Linaro.org <http://www.linaro.org/> *=E2=94=82 *Open source software for AR=
M SoCs

Follow *Linaro: *Facebook <http://www.facebook.com/pages/Linaro> | Twitter
<http://twitter.com/#!/linaroorg> | Blog
<http://www.linaro.org/linaro-blog/>

--001a113fa6dca310d60536cf4b87
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by: Benjamin Gaignard &lt;<a href=3D"mailto:benjamin=
.gaignard@linaro.org">benjamin.gaignard@linaro.org</a>&gt;</div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-07-04 15:22 GMT+02:00 =
Mark Brown <span dir=3D"ltr">&lt;<a href=3D"mailto:broonie@kernel.org" targ=
et=3D"_blank">broonie@kernel.org</a>&gt;</span>:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><span class=3D"">On Mon, Jul 04, 2016 at 03:16:51PM +0200, Arnd Ber=
gmann wrote:<br>
<br>
&gt; This follows the API change, adding the extra function arguments.<br>
&gt; I suppose we want this to be part of the ASoC merge in linux-next<br>
&gt; for now too.<br>
<br>
</span>I sent a pull request for the API change to the DRM people which mig=
ht<br>
be easier given that it&#39;s a single commit topic branch rather than the<=
br>
whole of DRM.<br>
<br>_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesk=
top.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listin=
fo/dri-devel</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature" data-smartmail=3D"gmail_signature"><span style=3D"bo=
rder-collapse:collapse;font-family:arial,sans-serif;font-size:13px"><p styl=
e=3D"margin-top:0px;margin-right:0px;margin-bottom:0px;margin-left:0px">Ben=
jamin Gaignard=C2=A0</p><p style=3D"margin-top:0px;margin-right:0px;margin-=
bottom:0px;margin-left:0px">Graphic Working Group</p><p style=3D"margin-top=
:0px;margin-right:0px;margin-bottom:0px;margin-left:0px"><span lang=3D"EN-U=
S" style=3D"font-size:10pt;color:rgb(0,176,80)"><span style=3D"color:rgb(0,=
68,252)"><a href=3D"http://www.linaro.org/" style=3D"color:rgb(0,0,204)" ta=
rget=3D"_blank">Linaro.org</a></span><b>=C2=A0</b></span><b><span lang=3D"E=
N-US" style=3D"font-size:10pt">=E2=94=82=C2=A0</span></b><span lang=3D"EN-U=
S" style=3D"font-size:10pt">Open source software for ARM SoCs</span></p><p =
style=3D"margin-top:0px;margin-right:0px;margin-bottom:0px;margin-left:0px"=
><u></u></p><p style=3D"margin-top:0px;margin-right:0px;margin-bottom:0px;m=
argin-left:0px"><span lang=3D"EN-US" style=3D"font-size:10pt">Follow=C2=A0<=
b>Linaro:=C2=A0</b></span><span style=3D"font-size:10pt;color:rgb(0,68,252)=
"><a href=3D"http://www.facebook.com/pages/Linaro" style=3D"color:rgb(0,0,2=
04)" target=3D"_blank"><span style=3D"color:blue">Facebook</span></a></span=
><span style=3D"font-size:10pt">=C2=A0|=C2=A0<span style=3D"color:rgb(0,68,=
252)"><a href=3D"http://twitter.com/#!/linaroorg" style=3D"color:rgb(0,0,20=
4)" target=3D"_blank"><span style=3D"color:blue">Twitter</span></a></span>=
=C2=A0|=C2=A0<span style=3D"color:rgb(0,68,252)"><a href=3D"http://www.lina=
ro.org/linaro-blog/" style=3D"color:rgb(0,0,204)" target=3D"_blank"><span s=
tyle=3D"color:blue">Blog</span></a></span></span></p></span></div>
</div>

--001a113fa6dca310d60536cf4b87--

--===============0235854404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0235854404==--

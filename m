From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: mc13783: Add devicetree support
Date: Wed, 30 Apr 2014 15:46:50 +0100
Message-ID: <20140430144650.GW29462@lee--X1>
References: <1398495423-2223-1-git-send-email-shc_work@mail.ru>
 <1398868130.411182088@f224.i.mail.ru>
 <20140430143352.GV29462@lee--X1>
 <1398868829.456957971@f392.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398868829.456957971-NHsxxyuixOdsdVUOrk1QfQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> > > > > > > > > > This patch adds devicetree support for mc13783-code=
c.
> > > > > > > > >=20
> > > > > > > > > Applied, thanks.
> > > > > > > >=20
> > > > > > > > No Mark, no!
> > > > > > >=20
> > > > > > > What a problem, Lee?
> > > > > >=20
> > > > > > There's no problem with the patch, don't worry.
> > > > > >=20
> > > > > > Neither Mark, nor I can apply this patch independently, we =
need to
> > > > > > create a shared branch somewhere, or we'll risk conflicts a=
t merge
> > > > > > time.
> > > > >=20
> > > > > I can separate this patch for ASoC and MFD if need.
> > > > > But this will work only if both is applied.
> > > >=20
> > > > Are there build dependencies, or only functional ones?
> > >=20
> > > Functional only.
> > > At this time "fsl,mc13xxx-uses-codec" option for PMIC produce a k=
ernel crash :)
> >=20
> > If patches can be broken up notwithstanding build errors, they shou=
ld
> > be.  It makes things sooo much easier.
>=20
> In fact that the patch for MFD is not obvious if the codec have no DT=
 support...
>=20
> If you do we see this problem (pdata =3D=3D NULL and we pass this to =
the
> driver in DT case), for me it not worst to separate this. What we do?
> Should this be a two patches in one series or one for MFD and one for=
 ASoC then?

You can put them into a patch-set and I will take the MFD one, Mark
will take the other.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

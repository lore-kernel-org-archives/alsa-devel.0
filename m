From: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [PATCH v2 5/5] ASoC: adau17x1: Support platform data via DT
Date: Wed, 17 Feb 2016 09:58:29 +0100
Message-ID: <20160217085829.GC2137@lnxandire1.se.axis.com>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
 <1455627405-18155-6-git-send-email-andire@axis.com>
 <4053162.T8NAULHXMt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4053162.T8NAULHXMt@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Andreas =?iso-8859-1?Q?Irest=E5l?= <andire-VrBV9hrLPhE@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 16, 2016 at 02:42:02PM +0100, Arnd Bergmann wrote:
> On Tuesday 16 February 2016 13:56:45 Andreas Irest=E5l wrote:
> > Currently, it is only possible to configure HW-specific options to =
the
> > adau17x1 codecs by providing a platform data struct. With this patc=
h,
> > it is possible to provide the same data via DT instead.
> >=20
> > Signed-off-by: Andreas Irest=E5l <andire-VrBV9hrLPhE@public.gmane.org>
> > ---
> >  .../devicetree/bindings/sound/adi,adau17x1.txt     |  31 +++++
> >  include/dt-bindings/sound/adau17x1.h               |  14 +++
> >  sound/soc/codecs/adau1761.c                        | 127 +++++++++=
++++++++++++
> >  sound/soc/codecs/adau1781.c                        |  48 ++++++++
> >  4 files changed, 220 insertions(+)
> >  create mode 100644 include/dt-bindings/sound/adau17x1.h
>=20
> > +		of_pdata =3D devm_kzalloc(dev, sizeof(*of_pdata), GFP_KERNEL);
> > +		if (!of_pdata)
> > +			return -ENOMEM;
> > +		adau1781_pdata_from_of(dev, of_pdata);
> > +		dev->platform_data =3D of_pdata;
>=20
> and here I'd try to avoid the dynamic allocation and just add the fie=
lds to the
> driver private structure. You can copy the information from the platf=
orm
> data in the 'else' path.

Since the driver private structure is shared between two different
codecs, the platform_data struct can be of 2 different types, but I
guess it should be OK to have two fields or a
union in the private struct.

I was thinking about this too but chose the approach above since provid=
ing
platform_data is optional. However, I could add some default values and
submit again.

Thanks a lot for the feedback.
/Andreas

>=20
> 	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

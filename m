From: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 1/2] mfd: arizona: Add support for INn_Mode
 register control
Date: Mon, 25 Aug 2014 18:20:01 +0900
Message-ID: <20140825182001.666bd966@songinha-Samsung-DeskTop-System>
References: <20140813205313.65bbe343@songinha-Samsung-DeskTop-System>
 <20140821121219.GF4266@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140821121219.GF4266@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Lee,

On Thu, 21 Aug 2014 13:12:19 +0100
Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> On Wed, 13 Aug 2014, Inha Song wrote:
>=20
> > Some boards need to set the INn_MODE[1:0] register to change
> > the input signal patch. This wlf,inmode property is optional.
> > If present values must be specified by the number of
> > ARIZONA_MAX_INPUT.
> >=20
> > Example:
> >    - wlf,inmode =3D <2 0 2 0>;	/* IN1, IN3 use DMIC */
> >=20
> > Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/mfd/arizona-core.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> This is going to require a DT Ack.
>=20
> Is [2/2] adding the documentation?  I can't easily go and look becaus=
e
> you send the patch-set unthreaded.  Please thread patch-sets.  See
> the man page for `git send-email` for more information.
>=20

Sorry, I will resend this patch set to use "git send email".

Best regards,
Inha Song.

> > diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.=
c
> > index 10a0cb9..2b68ccd 100644
> > --- a/drivers/mfd/arizona-core.c
> > +++ b/drivers/mfd/arizona-core.c
> > @@ -534,7 +534,7 @@ EXPORT_SYMBOL_GPL(arizona_of_get_named_gpio);
> >  static int arizona_of_get_core_pdata(struct arizona *arizona)
> >  {
> >  	struct arizona_pdata *pdata =3D &arizona->pdata;
> > -	int ret, i;
> > +	int ret, i, proplen;
> > =20
> >  	pdata->reset =3D arizona_of_get_named_gpio(arizona, "wlf,reset", =
true);
> > =20
> > @@ -560,6 +560,15 @@ static int arizona_of_get_core_pdata(struct ar=
izona *arizona)
> >  			ret);
> >  	}
> > =20
> > +	proplen =3D of_property_count_u32_elems(arizona->dev->of_node,
> > +					      "wlf,inmode");
> > +	if (proplen > 0 && proplen <=3D ARRAY_SIZE(arizona->pdata.inmode)=
) {
> > +		for (i =3D 0; i < proplen; i++)
> > +			of_property_read_u32_index(arizona->dev->of_node,
> > +						   "wlf,inmode", i,
> > +						    &arizona->pdata.inmode[i]);
> > +	}
> > +
> >  	return 0;
> >  }
> > =20
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

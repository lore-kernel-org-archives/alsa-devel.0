From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v3 1/2] mfd: arizona: Add support for
 INn_Modec register control
Date: Fri, 29 Aug 2014 09:17:41 +0100
Message-ID: <20140829081741.GD24579@lee--X1>
References: <20140818200003.2ab8aca0@songinha-Samsung-DeskTop-System>
 <20140828113651.GN24579@lee--X1>
 <20140829170230.673ca9ff@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140829170230.673ca9ff@songinha-Samsung-DeskTop-System>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sameo@linux.intel.com, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Aug 2014, Inha Song wrote:

> Hi, Lee
> Thanks for your review.
>=20
> On Thu, 28 Aug 2014 12:36:51 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
>=20
> > On Mon, 18 Aug 2014, Inha Song wrote:
> >=20
> > > Some boards need to set the INn_MODE[1:0] register to change
> > > the input signal patch. This wlf,inmode property is optional.
> > > If present, values must be specified less than or equal to
> > > the number of input singals. If values less than the number
> > > of input signals, elements that has not been specifed are set
> > > to 0 by default.
> > >=20
> > > Example:
> > >    - wlf,inmode =3D <2 0 2>;	/* IN1, IN3 use DMIC */
> > >=20
> > > Signed-off-by: Inha Song <ideal.song@samsung.com>
> > > ---
> > >  drivers/mfd/arizona-core.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-cor=
e.c
> > > index 10a0cb9..81e6db8 100644
> > > --- a/drivers/mfd/arizona-core.c
> > > +++ b/drivers/mfd/arizona-core.c
> > > @@ -534,7 +534,7 @@ EXPORT_SYMBOL_GPL(arizona_of_get_named_gpio);
> > >  static int arizona_of_get_core_pdata(struct arizona *arizona)
> > >  {
> > >  	struct arizona_pdata *pdata =3D &arizona->pdata;
> > > -	int ret, i;
> > > +	int ret, i, proplen;
> > > =20
> > >  	pdata->reset =3D arizona_of_get_named_gpio(arizona, "wlf,reset"=
, true);
> > > =20
> > > @@ -560,6 +560,12 @@ static int arizona_of_get_core_pdata(struct =
arizona *arizona)
> > >  			ret);
> > >  	}
> > > =20
> > > +	proplen =3D of_property_count_u32_elems(arizona->dev->of_node,
> > > +					      "wlf,inmode");
> > > +	if (proplen > 0 && proplen <=3D ARRAY_SIZE(arizona->pdata.inmod=
e))
> > > +		of_property_read_u32_array(arizona->dev->of_node, "wlf,inmode"=
,
> > > +					   arizona->pdata.inmode, proplen);
> >=20
> > of_property_for_each_u32()?
>=20
> Is it more clear to use of_property_for_each_u32() instead of
> of_property_read_u32_array()?

It prevents you from having to use of_property_count_u32_elems() first.

> If so, I will fix in v5.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

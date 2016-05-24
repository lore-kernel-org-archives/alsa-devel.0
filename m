From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: da7219: Convert driver to use generic
 device/fwnode functions
Date: Tue, 24 May 2016 13:53:02 +0300
Message-ID: <1464087182.31269.44.camel@linux.intel.com>
References: <cover.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
	 <eea79e2c26dafa785451931387cfce716bd150d4.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
 <1463664451.31269.3.camel@linux.intel.com>
	 <2E89032DDAA8B9408CB92943514A0337D463EEB5@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D463EEB5@SW-EX-MBX01.diasemi.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Suravee <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2016-05-23 at 22:53 +0000, Opensource [Adam Thomson] wrote:
> On May 19, 2015 14:28, Andy Shevchenko wrote:
>=20
> > > -static struct da7219_aad_pdata *da7219_aad_of_to_pdata(struct
> > > snd_soc_codec *codec)
> > > +static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct
> > > snd_soc_codec *codec)
> > > =C2=A0{
> > > -	struct device_node *np =3D codec->dev->of_node;
> > > -	struct device_node *aad_np =3D of_find_node_by_name(np,
> > > "da7219_aad");
> > > +	struct device *dev =3D codec->dev;
> > > +	struct i2c_client *i2c =3D to_i2c_client(dev);
> > > +	struct fwnode_handle *aad_np =3D
> > > +		device_get_named_child_node(dev, "da7219_aad");
> >=20
> > I would suggest to do an assignment below...
> >=20
> > > =C2=A0	struct da7219_aad_pdata *aad_pdata;
> > > -	const char *of_str;
> > > -	u32 of_val32;
> > > +	const char *fw_str;
> > > +	u32 fw_val32;
> > >=20
> >=20
> >=20
> > ...right here.
> > Same amount of LOC, but less difficult to see from where aad_np
> > comes.
> >=20
> > > =C2=A0	if (!aad_np)
> > > =C2=A0		return NULL;
> > >=20
>=20
> To be fair the allocation of 'aad_np' is only a few lines above so
> this really
> doesn't seem to make much difference in my opinion. It really
> shouldn't be hard
> for someone to spot where it's allocated.

Better to have it exactly before check. Just a readability and future
maintenance. (Someone might insert something in between, and a matter o=
f
fact already did)

Though I agree this is minor.

>=20
> > > @@ -769,9 +768,9 @@ int da7219_aad_init(struct snd_soc_codec
> > > *codec)
> > > =C2=A0	da7219->aad =3D da7219_aad;
> > > =C2=A0	da7219_aad->codec =3D codec;
> > >=20
> > > -	/* Handle any DT/platform data */
> > > -	if ((codec->dev->of_node) && (da7219->pdata))
> > > -		da7219->pdata->aad_pdata =3D
> > > da7219_aad_of_to_pdata(codec);
> > > +	/* Handle any DT/ACPI/platform data */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((da7219->pdata) && (!da7219->p=
data->aad_pdata))
> >=20
> > Redundant parens, twice.
>=20
> Not essential, but looks cleaner to me. Unless there's a real demand
> to change,
> I'd like to leave this as is.

It's really unusual pattern and doesn't add any value

Compare
=C2=A0if ((da7219->pdata) && (!da7219->pdata->aad_pdata))=C2=A0
to
=C2=A0if (da7219->pdata && !da7219->pdata->aad_pdata)

Latter looks cleaner.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

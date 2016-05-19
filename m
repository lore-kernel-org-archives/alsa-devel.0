From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: da7219: Convert driver to use generic
 device/fwnode functions
Date: Thu, 19 May 2016 16:27:31 +0300
Message-ID: <1463664451.31269.3.camel@linux.intel.com>
References: <cover.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
	 <eea79e2c26dafa785451931387cfce716bd150d4.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <eea79e2c26dafa785451931387cfce716bd150d4.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Suthikulpanit@diasemi.com, Suravee <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-05-17 at 11:28 +0100, Adam Thomson wrote:
> This change converts the driver from using the of_* functions to usin=
g
> the device_* and fwnode_* functions for accssing FW related data.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

@@ -538,97 +538,96 @@ static enum da7219_aad_adc_1bit_rpt
> =C2=A0	}
> =C2=A0}
>=20
> -static struct da7219_aad_pdata *da7219_aad_of_to_pdata(struct
> snd_soc_codec *codec)
> +static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct
> snd_soc_codec *codec)
> =C2=A0{
> -	struct device_node *np =3D codec->dev->of_node;
> -	struct device_node *aad_np =3D of_find_node_by_name(np,
> "da7219_aad");
> +	struct device *dev =3D codec->dev;
> +	struct i2c_client *i2c =3D to_i2c_client(dev);
> +	struct fwnode_handle *aad_np =3D
> +		device_get_named_child_node(dev, "da7219_aad");

I would suggest to do an assignment below...

> =C2=A0	struct da7219_aad_pdata *aad_pdata;
> -	const char *of_str;
> -	u32 of_val32;
> +	const char *fw_str;
> +	u32 fw_val32;
>=20


=2E..right here.
Same amount of LOC, but less difficult to see from where aad_np comes.

> =C2=A0	if (!aad_np)
> =C2=A0		return NULL;
>=20

> @@ -769,9 +768,9 @@ int da7219_aad_init(struct snd_soc_codec *codec)
> =C2=A0	da7219->aad =3D da7219_aad;
> =C2=A0	da7219_aad->codec =3D codec;
>=20
> -	/* Handle any DT/platform data */
> -	if ((codec->dev->of_node) && (da7219->pdata))
> -		da7219->pdata->aad_pdata =3D
> da7219_aad_of_to_pdata(codec);
> +	/* Handle any DT/ACPI/platform data */
> + =C2=A0 =C2=A0 if ((da7219->pdata) && (!da7219->pdata->aad_pdata))

Redundant parens, twice.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

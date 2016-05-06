From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: da7219: Add ACPI parsing support
Date: Fri, 6 May 2016 13:39:09 +0100
Message-ID: <20160506123909.GT6292@sirena.org.uk>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <bb23ba754ed1f51c9b20ccd4a2b87520ce7c1893.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5fM1MC9alg+yIaL4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb23ba754ed1f51c9b20ccd4a2b87520ce7c1893.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--5fM1MC9alg+yIaL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 11:53:05AM +0100, Adam Thomson wrote:

> @@ -27,7 +28,6 @@
>  #include "da7219.h"
>  #include "da7219-aad.h"
>=20
> -
>  /*
>   * Detection control
>   */

Random whitespace change.

>  static struct fwnode_handle *da7219_aad_of_named_fwhandle(struct device =
*dev,
>  							  const char *name)
>  {
> @@ -551,6 +571,9 @@ static struct fwnode_handle *da7219_aad_of_named_fwha=
ndle(struct device *dev,
>  			of_node =3D to_of_node(child);
>  			if (of_node_cmp(of_node->name, name) =3D=3D 0)
>  				return child;
> +		} else if (is_acpi_data_node(child)) {
> +			if (da7219_aad_of_acpi_node_matched(child, name))
> +				return child;
>  		}
>  	}
>=20

This seems messy.  It is a function with a DT specific name that's
matching ACPI stuff and the fwnode API isn't hiding anything for us
which suggests this isn't something that's expected to work
transparently.  At least the naming needs to be corrected, and if this
*is* supposed to be something we do in ACPI I'd expect the handling to
be pushed into the fwnode API rather than open coded in a driver - at
the minute I'm unsure if this is messy because it's a bad idea to do
this at all or if it's just the naming and so on.

> -	/* Handle any DT/platform data */
> -	if ((codec->dev->of_node) && (da7219->pdata))
> +	/* Handle any DT/ACPI/platform data */
> +	if (((codec->dev->of_node) || is_acpi_node(codec->dev->fwnode)) &&
> +	    (da7219->pdata))
>  		da7219->pdata->aad_pdata =3D da7219_aad_of_to_pdata(codec);
>=20
>  	da7219_aad_handle_pdata(codec);

Surely we should be able to check if there's firmware data without
enumerating every possible firmware type?

--5fM1MC9alg+yIaL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLJBrAAoJECTWi3JdVIfQ2TcH/jr/36ilwqR3DojT6VS5jgbI
j92b1A7zwSWjwhDJCvTol0mbWzwiphuUDwUmyyjBcBDibFhNTzN4YjMoyowLEuvl
NONjisMzEZ1Mpp/mGle5o6tbAringfSEK/OrgadnpvLK6yZTGXSYLLYPN73iiKUV
JvBRbl2DbYSOXzwRp7A82osoc1wSsRi0ugBf3NC1voE6s4Uc3kNST2aM40UK0T6w
K3qJThSDwu1rxMM3ljv8ff4vc3yT0HQma5T3SioSfvYqMnZmW9HV5TuO2bUWX33E
H8lflbCQB0Ag7dVRXl9HvKVqHEsVz4po5QLw96rJlQSEQEoQCLd4BHw2+uzDWCU=
=mIDR
-----END PGP SIGNATURE-----

--5fM1MC9alg+yIaL4--

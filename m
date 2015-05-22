From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Fri, 22 May 2015 13:56:34 +0100
Message-ID: <20150522125634.GX21391@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8784729355756917738=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81BBB265ACA
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:05:45 +0200 (CEST)
In-Reply-To: <1431341645-2457-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8784729355756917738==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R0SsnouPYaG+7rP6"
Content-Disposition: inline


--R0SsnouPYaG+7rP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 04:23:59PM +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> ASoC hda codec driver will use id_table for registration.
> id_table has info of codec vendor_id, revision_id and name.
> For ASoC device/driver matching, device vendor_id, rev_id
> will be matched to id_table to identify the device/driver.

I'm sorry but I still don't entirely understand what this is supposed to
do.  It *looks* like it's trying to create a bus for HDA with this:

> +/* HDA device table */
> +#define HDA_NAME_SIZE      20
> +struct soc_hda_device_id {
> +	__u32 id;
> +	__u32 rev_id;
> +	char name[HDA_NAME_SIZE];
> +	unsigned long driver_data;
> +};
> +
> +struct soc_hda_codec_driver {
> +	struct hdac_driver core;
> +	const struct soc_hda_device_id *id_table;
> +};

but it's not actually defining a driver model bus type (though it does
use driver_register()) and I'd expect the bus type to be provided by the
generic HDA code.  Looking (fairly quickly admittedly) at the HDA code
it's not entirely obvious how it all fits together and the changelog for
that just talks about moving code around.

We really need to make sure we don't end up with the same shambles we've
got for AC'97 here (though we're unlikely to get similar touchscreen
type things so it should be less bad).

--R0SsnouPYaG+7rP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyeBAAoJECTWi3JdVIfQ2yoH/1CVdBCM8bRF6IKcEqlaQEuv
FUVVoalGDxbYEvLq7/++b17iEqmWmiKqL2JiW0GvCJqsNAQS1DWy39RCwH/PMdJy
MphdzD2dp/uFb5RqtIYLW+P93OyO+HgjoSpNrloHN7hrIAe5UmW8P5NbVp7LsFXd
vWfGZYOf+agzpt4DOd1sZu5b7SPkRtpQjdu5Y9IVhFNdmJWFjNmhzbw0PJCw8He8
DR4rVESg9Ntotu/REQ0fHRwz/Zb+Sw693sFtNTOqAwkQshj6hgJZGmrjU3vOq1NW
14XeAfTMWZNTFOPfQ7Kf1ntxVdEqlk+QqQF4I3tg+/97G9lEiidxbxqL4YVuLXI=
=lS+X
-----END PGP SIGNATURE-----

--R0SsnouPYaG+7rP6--

--===============8784729355756917738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8784729355756917738==--

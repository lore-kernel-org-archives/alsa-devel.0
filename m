From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-card support for arizona-core
Date: Mon, 30 Nov 2015 11:54:49 +0000
Message-ID: <20151130115449.GV1929@sirena.org.uk>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
 <20151012113702.GC8805@ck-lbox>
 <20151130113717.GB32172@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bKO1kftFne8qVRsx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151130113717.GB32172@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--bKO1kftFne8qVRsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 30, 2015 at 12:37:17PM +0100, Pavel Machek wrote:
> Hi!

Please submit patches in the format covered in SubmittingPatches.

> +	ret = of_property_read_u32(arizona->dev->of_node,
> +				   "wlf,codec-number", &arizona->pdata.codec_num);

Why does this make sense - what information is this adding?

--bKO1kftFne8qVRsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXDkIAAoJECTWi3JdVIfQsl8H/0nBAHB/ckXhhZjf/saGZ2bK
KEh1i5u9G/zg5oecXXjagq9oPdCewlMLP2lsHTb7qlewKgYs3uzkVwFfX30lKj6f
acE2Q07cwIJ2+n5xctEgWi4naFnUXPEWlrUTsVrxghh3T7v4QvuoCUfSx9TfFOjc
aCvjC3IBU/aeDDVqeAFjb9Tpx2kuH2GTN54BI7Hs7dQ3Mk7Jg+to2jkDCfNko08P
D3HfsQV3sWhwKKWOuufcZjJ+idEfd9Pxk1ZE9uLn6RjYnHwh3ED6CHORyFaQL+Lc
QtCMCWOAvAb/Ps87SFHK6tAMw4Sj8ryA5Ej7Et3nkB6ngb0jKqkhbNPhcn1RYjg=
=Aykt
-----END PGP SIGNATURE-----

--bKO1kftFne8qVRsx--

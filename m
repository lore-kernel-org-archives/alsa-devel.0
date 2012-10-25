From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm5102: Correct micbias DAPM supplies
Date: Thu, 25 Oct 2012 17:22:51 +0100
Message-ID: <20121025162251.GP18814@opensource.wolfsonmicro.com>
References: <20121025142442.GA32126@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FRaepaAnLTQkJ4tS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121025142442.GA32126@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--FRaepaAnLTQkJ4tS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 25, 2012 at 03:24:42PM +0100, Charles Keepax wrote:
> ARIZONA_MICB1_ENA_SHIFT was used for micbias 2 and 3. This change
> correctly uses the ARIZONA_MICBX_ENA_SHIFT for each corresponding DAPM
> supply. This should not have caused any problems as the micbias enables
> are in the same place in each register.

Applied, thanks.

--FRaepaAnLTQkJ4tS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiWbxAAoJELSic+t+oim9gSsP/3I0JRSgp4HEgffLYeQ1PADD
+NoQLBbyBFlRfnYiVdw2KbvYKwAn5E0WXUj0AtpOmQXdiz/a589Hlai7FiN5a+VD
/C4D3ohm1Cjlqra9Gzh/zliQcYP8HtIXNH4y/d6KvXlqUVQww/kZxDLkevPfgqMW
ZmS2MHzlt8CKOQgNDCFIu02s9SObVwUBjokVAsGv/CRnK58GeNufWjdUCA/LEPOq
sYnHjSJgMMKP4cODO4mw6TrnSMzdY+QgTU6oqvYGV1otZ/XCanyn5KQy1xS1L1nl
bigbWeHwzIHJfGOrbjF8U0XZ2QWpvAFikG6XfzuWm6IFAS58st1Tc5x968n+NarI
UNowsIrZrw5EW0pDEksfZSHzGPv5+Jh/3OQe2DGqUIPR9zcf7GPurZDQiwrMDmee
K1BmK6/PAbuN0co2dyQWqYYOcas6XOkbPDVD9eTuNBp5HC1HB2S3D8WCnekkur3+
/kRMFbGgNe1v9PZm9mEG0hU4z0zD7HABappEkQv/Gzx+6M75EPCJHAdKiuV8Blj5
PrZh8tRToovyuuvTBwjr5tA2NYs26LkJERdA5ZR0yZ/GZid+54LsWm/Hg4+WA/Nu
o6ELvBpnrEmbr7EcgfKEX/5NpWPARIcMjrZOkDkOq+vbp7T17WWgoEiKjjS9rDSN
hGB/5/IETa1g+p0ANlKZ
=OXsG
-----END PGP SIGNATURE-----

--FRaepaAnLTQkJ4tS--

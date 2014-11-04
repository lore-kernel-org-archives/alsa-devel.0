From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix the driver data not set
	issue
Date: Tue, 4 Nov 2014 11:44:15 +0000
Message-ID: <20141104114415.GK3815@sirena.org.uk>
References: <1415083524-22756-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4816817726566811551=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1410626060F
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:45:31 +0100 (CET)
In-Reply-To: <1415083524-22756-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4816817726566811551==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gCatpCT2/Jx0qRyG"
Content-Disposition: inline


--gCatpCT2/Jx0qRyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 02:45:24PM +0800, Jie Yang wrote:
> The priv_data is allocated again here wrongly, and it
> is not set to the driver data after assignment. This
> make the pdata->dev is NULL and oops occurs on the first
> call to hsw_volume_put.

Applied, thanks.

--gCatpCT2/Jx0qRyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWLwPAAoJECTWi3JdVIfQwEQH/08odXRbdIEwSUSTtK5C/9bc
Zz5dCWjWwjKaCOY+6HVY/NWXbM/B2VSjQOl6MqKcAPQbzeMO7dE4EyW30Hp2c2zm
oCRddoXouC1UugnGaTbezuLTD5/uqFP8YNxj/OP4vjWDO33Pmw3/7yc8hj1gJs6D
Tos8M8Vrb6NhkTwGLncS86gl9za8xSiGM8KoHiW0+jp/Z+5tpTVZpS4M2pe73HK5
cLI8m+MH5X4uqO6po8UiPkkhELaQn4BFFzs5sHcw73irixNdpV3EHnb1HK6hxwqA
ipQ+HQ6ltpq+0AAWJaiu9cry4/luXAb7nAbRIYhvzGAZwmNd8J1/GeSstZWdROA=
=Yzmf
-----END PGP SIGNATURE-----

--gCatpCT2/Jx0qRyG--

--===============4816817726566811551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4816817726566811551==--

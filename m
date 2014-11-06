From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC:rt5670: add rt5672 codec support
Date: Thu, 6 Nov 2014 06:00:15 +0000
Message-ID: <20141106060015.GP8509@sirena.org.uk>
References: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
 <1415247834-14278-3-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2960195769791889479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80B472650C5
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 07:00:26 +0100 (CET)
In-Reply-To: <1415247834-14278-3-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2960195769791889479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+W7ryvxEk4RRyt+P"
Content-Disposition: inline


--+W7ryvxEk4RRyt+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 12:23:53PM +0800, bardliao@realtek.com wrote:

> +	case RT5670_ID_5670:
> +	case RT5670_ID_5671:

This looks like it also adds rt5671 support but...

>  static const struct i2c_device_id rt5670_i2c_id[] = {
>  	{ "rt5670", 0 },
> +	{ "rt5672", 0 },
>  	{ }
>  };

...not here.  Otherwise this is fine, though it would be better to warn
if the user registered the device as one type but it turns out to be
another when we read the ID register.

--+W7ryvxEk4RRyt+P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWw5vAAoJECTWi3JdVIfQp5AIAIaN03wA6vgI+WySMHXjRAq4
px9nrtdihD+zJeC9bJYXrhvPeLqVycQ0RhCT3PC3y6nIyN98XKsM6UODNTZhHUqH
tG7lAAkTL8Bj/7/Lebrj30uOf9o1AfZIH8Lgdw8UYRTSG2NW7j0a3rtouSO3ojzg
dV3IqRBwFcO7W2m8OB/78PhcTxZ97oPYgCqDoNeX9cAKEW8mDob0gaD/AeOBR2Ci
ho2AccBT2Arjrj+/Dz3e44MvxtbGPErwNcdZcYS6OswFimA1orBXGMUBGxpZa7+S
89xeXBzPuM6zLyCvrNdiko+POOlRsVmh1QrJu70dtHhBN5caMO1zmWB2sIqdgco=
=zhRm
-----END PGP SIGNATURE-----

--+W7ryvxEk4RRyt+P--

--===============2960195769791889479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2960195769791889479==--

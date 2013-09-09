From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Mon, 9 Sep 2013 12:26:43 +0100
Message-ID: <20130909112643.GX29403@sirena.org.uk>
References: <1375717898.29528.23.camel@matrix>
 <20130805162342.GS9858@sirena.org.uk>
 <1377778108.15438.6.camel@matrix>
 <2E89032DDAA8B9408CB92943514A033751E611AF@SW-EX-MBX01.diasemi.com>
 <20130902103843.GL3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
 <20130902174121.GV3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E6157D@SW-EX-MBX01.diasemi.com>
 <20130904183405.GX3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E61991@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7062294263595502041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D96B2625E1
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 13:26:49 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A033751E61991@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, David Dajun Chen <david.chen@diasemi.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7062294263595502041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JjNtGRvLZqzR8wa5"
Content-Disposition: inline


--JjNtGRvLZqzR8wa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2013 at 02:17:48PM +0000, Opensource [Adam Thomson] wrote:

> Bringing this back to DA9055 though, the current method of initialisation, for
> PMIC and Codec, isn't complicated or confusing nor does it require a lot of
> effort. As well as this the implementation is logically sound. It should
> remain that way in my opinion. The only thing that should be updated is the I2C
> Id of the Codec to make it more meaningful, and preferably sooner rather than
> later so the issue can be finally put to bed.

Well, the obvious approach would seem to be to just do the registration
of the CODEC I2C device from the MFD...

--JjNtGRvLZqzR8wa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLbBvAAoJELSic+t+oim9aa0P/1yX17viQppBzB3kcGptNhC3
DscLDJu0Cte4Y5D1UJGmuKQMDHNpU1mr4wlPdpevU/2sjqd4p2Mi1k3Nh773mT9f
hgqJj/LQoqRlyLemfa53SVc7THPC+76yQCsoqaWl/egz+7Kc4hhEhto+NJyNQpA3
sHux/0aA3tOykmCdQ4bIhWsyE1UcIHaxjrCw20P8MRf9I+iIqlSdW8lxj448HyFU
uHsD+WvWFor9upmNbOG5agQG/tVSxlNfRKSzwjip/9ct8LClc/Y6NBly6It8hYb5
M85UGG8Zixw0BC2it2Exu/+LZUfYWMxWlv6bajfm4sAtkynGXHyLqDEob7jN7dHe
yO3Os24iuMk+UO6Rq2NBoWCmFeOm9Sut68AdRK6vHaxjt88gUglqUChApqgPNlpv
tjX8XFMB4x7hXYhbPcQH0SMfEV07n7JZjTiQt6VyVJ3tKPNf7IBe7bMx6HUhSIha
qSJVriLi+ID4OKYIMV9qiOpjZV8Df3A+ngRFsUJXDjeFVWH0bW8eqXPsFd66K4ht
kwSeZgaTQAt4B5Bme+XRWZkGmqs49WjTCZIE4uAbBFUIHZZL2Y0CMGI+3Hbhh+cV
v/FT8aZa8Unxt086k7ESKBZS5lOfcGtNJyYmOxHTpBrkBmksJQX5QFVM+/YQLybO
8qmwYmtUYXGUVYfnG7CB
=UZQZ
-----END PGP SIGNATURE-----

--JjNtGRvLZqzR8wa5--

--===============7062294263595502041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7062294263595502041==--

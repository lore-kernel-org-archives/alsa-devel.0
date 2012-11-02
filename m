From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: UCM/DAPM - saving power when idle?
Date: Fri, 2 Nov 2012 14:30:09 +0000
Message-ID: <20121102143008.GA4413@opensource.wolfsonmicro.com>
References: <50925145.4070706@canonical.com>
 <50929498.60103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4577995523153313954=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16DB4265092
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 15:30:10 +0100 (CET)
In-Reply-To: <50929498.60103@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, arun.raghavan@collabora.co.uk, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============4577995523153313954==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ul2mxMk0z4RYCW0d"
Content-Disposition: inline


--Ul2mxMk0z4RYCW0d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2012 at 03:26:16PM +0000, Liam Girdwood wrote:

> + Mark and Arun,

David, *ALWAYS* CC maintainers.

> DAPM also handles the sidetone or FM radio task as described above
> too by detecting the source -> sink between two widgets that are not
> enabled by the CPU PCM devices (e.g. not DACs or ADCs, etc) and will
> then power this path.

...and of course if the driver for whatever device is provding the
analogue input is able to update the state of the source then that will
integrate nicely with ASoC and we can do the automatic power up/down in
the same way as we do for DACs and ADCs.  There's a standard helper for
integrating with accessory detect like this.

--Ul2mxMk0z4RYCW0d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk9jJAAoJELSic+t+oim9cxIP/R9Zp1Q/F0I383TAd9Hydpoi
KlN/dGBO9iW94SO3rMvCT1qm7BrHVf3fEMIxP4fbNemXDX62/Be0tOa3mcWaO9CK
n3PZLZ5zeh/X0khYOMnXRWSLHoCWCo6Gdjq5ZkCF7NKXjj3/XHjyEDe5D04yo8QE
4ferhDnUff/X4Wbev3z4hUo5gZOFwsEA4rhj3icWxmF+b+PONfmb+rbXTl/yHoNo
QksFa4f+Tw9Yjj90myOblQu1FyUpWnigr5yfxrGApFeSzyHfwep8uDXX0rsSgOR0
odFHhsaFlE/MEII8we75Ms3B1Z3+r6DF52MavSiP6ejwpObMGJ2AOD5K0PrQmS45
7QIEx+05TxqRVA88JZitxTeOKLWVLZIpqraM5GjAwM91rXr3v2i9jwP4Pu7XHxRX
cQ4UR9/nZL9EmFjDDUjGLb4OGJwXUdte2xjtD1n0pKo1QJCGcXPsiT4sOGa+6Uxo
HOM+ARSYkPHdlMNyTfAU78HR7+jgT0VhjO55zk6tI9Yp0SCjLDN2w8CmDlXZ2CSH
9qUp2ij6dGNxeoqkfdGk2JpLUS5Z/B9Hh/jgxy3LG/L7Nc8L36UPq9lv7RJC2Zr5
Q3GVUnRQaLuBM+KTexZ2G1P0hUzJkrlrEnQLWoOZIR2cowxnYTfzQJhpMh4ShBbE
azTsnwNlYQ1YmIcPbuGm
=BA94
-----END PGP SIGNATURE-----

--Ul2mxMk0z4RYCW0d--

--===============4577995523153313954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4577995523153313954==--

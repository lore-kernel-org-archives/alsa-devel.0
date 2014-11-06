From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/6] ASoC: Intel: mrfld- add ACPI module
Date: Thu, 6 Nov 2014 13:44:26 +0000
Message-ID: <20141106134426.GI8509@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-5-git-send-email-vinod.koul@intel.com>
 <20141106124349.GB8509@sirena.org.uk>
 <20141106130909.GC1870@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8900656890918002187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9384260695
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 14:44:51 +0100 (CET)
In-Reply-To: <20141106130909.GC1870@intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8900656890918002187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uN5p0Kt0tLhd3gfz"
Content-Disposition: inline


--uN5p0Kt0tLhd3gfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 06:39:09PM +0530, Vinod Koul wrote:
> On Thu, Nov 06, 2014 at 12:43:49PM +0000, Mark Brown wrote:
> > On Tue, Nov 04, 2014 at 04:25:18PM +0530, Vinod Koul wrote:

> > No, we should be able to build a kernel which runs with or without ACPI
> > - make this a runtime check if it's required (a comment might be in
> > order too since this is a weird thing to do).

> yes that is doable by adding a parameter and setting that in specfic probe,
> will add.

There's a variable acpi_disabled you can check.

--uN5p0Kt0tLhd3gfz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW3s5AAoJECTWi3JdVIfQ7boH/R2qlhNdxhwuoZNLAtP33jsh
XjvVZWOQPEkJBYvLHz3yTxX3UEHMRpc3Y97I8xxamPLEX9LEjqouOzp3qBbLjYCs
Wd8Bsng909uVlpDBJxlLxov0Ynd2KcxXUvNSmWUajQ6rrUZ7HiyEqODzv1AtaVtj
4Jfg+Eva79691xJSUpde+ESJd3YMK95YQGunwFJI7QFzvtKfgMc3J/BKhHJVg6/j
54gC2+bgER9wNXFH+oxTPTc/zghqjNgDpHE4HeD7aQZy7MyOmleh3pkI17viPCyL
uMf7t7faBMbcG2xRgT5iCRoLDx+b0bHpjo+udSunmVyKEBYh4vYcXH4v8ZiftxA=
=1jdz
-----END PGP SIGNATURE-----

--uN5p0Kt0tLhd3gfz--

--===============8900656890918002187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8900656890918002187==--

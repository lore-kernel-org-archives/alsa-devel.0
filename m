From: Mark Brown <broonie@kernel.org>
Subject: Re: Problem with commit 924eb47512 ("ASoC: dwc: fix dma stop
 transferring issue")
Date: Wed, 27 Jan 2016 13:21:40 +0000
Message-ID: <20160127132140.GN6042@sirena.org.uk>
References: <1453386247.2858.58.camel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453386247.2858.58.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Yitian Bu <yitian.bu@tangramtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 21, 2016 at 02:24:07PM +0000, Jon Medhurst (Tixy) wrote:

> In trying to work out why audio stopped working on ARM's Juno board I
> bisected the problem to $subject commit and reverting this fixed things.

Yitian?  Tixy's analysis looks good, in the absence of further feedback
I intend to revert your change.

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqMRjAAoJECTWi3JdVIfQq08H/ilOPJrLyNX/x7Eo5JX61DOa
YxBpneVDE6dJUgFySFg+2Wcc6H555zTRHQD+WHsdmv0TmR+3YwxWsFxaiysLG8Ga
IlipJQVOYDwMStXKxlFL5yssnWQotbovk8UB7gROs2sUN3rzix53N8nufBY1Eoqm
dBu4bbW9eA+yu7bp/FwQZtF3T4hql551TDSOr0IbQZqgr3nAciGbVeC0BQm+2fmS
sEweZGJXsopx9ra2ajVtvVS675Hhwi49tf3a1Z1hzuxBGQNJXDgPP/NrN2O+Csww
AO0QzzFKlG8JTsGarhNIbr0x1kSrQuzD1/1wNqhEvPEB48OPofHcPPCVojbzk+E=
=Jtq2
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--

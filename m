From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/6] ASoC: Intel: mrfld - remove
 unnecessary check for pointer
Date: Thu, 6 Nov 2014 12:36:26 +0000
Message-ID: <20141106123626.GY8509@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3053391746239354837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8144626517F
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:36:38 +0100 (CET)
In-Reply-To: <1415098520-14113-2-git-send-email-vinod.koul@intel.com>
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


--===============3053391746239354837==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rmLdANEyqdgxlbgR"
Content-Disposition: inline


--rmLdANEyqdgxlbgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:25:15PM +0530, Vinod Koul wrote:
> the 'platform' pointer in sst_map_modules_to_pipe() is deref in caller
> function so we need to check for it in this function

Applied, thanks.

--rmLdANEyqdgxlbgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW2tKAAoJECTWi3JdVIfQEKQH/AnGG4sCWkmHeEz2/QlL2rak
nzPELlzekqOgLXYHvxntD8O+gx+fhLebLZ6WwHfG/bUWEkNvCaoltWBiXM3+iw6h
qm4E7BBsIBKynyyDfYgW/T5tPWQwBMHD+bkz88kXB9hLfWvzI0AgHxY7ohTtfGZD
lUGRQMTcMnggqaHK4hIGB4PxkP0AqasHkG8+9M8FL7R2KJFvjrBNB1G29vcp9Req
4GzcYprVsDbCISS4ifOMcR4wW7sW6xRBp6vNVWLBSx/sv8Wqu+2ztq3feSrs40R/
N0xYNcB+wM2LfjxRuoInrmwp/7/XHn3ZRkx430q3AEqRZML/TJoUrE/6X+F/5N0=
=dm25
-----END PGP SIGNATURE-----

--rmLdANEyqdgxlbgR--

--===============3053391746239354837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3053391746239354837==--

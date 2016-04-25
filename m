From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to
 volatile register list
Date: Mon, 25 Apr 2016 19:06:13 +0100
Message-ID: <20160425180613.GR3217@sirena.org.uk>
References: <1461606624-130216-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8172644862670372784=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A44A0265068
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 20:06:26 +0200 (CEST)
In-Reply-To: <1461606624-130216-1-git-send-email-caleb@crome.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============8172644862670372784==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RCQbRqFVGRR2abej"
Content-Disposition: inline


--RCQbRqFVGRR2abej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 25, 2016 at 10:50:24AM -0700, Caleb Crome wrote:

> Due to caching, SOR wasn't written when it should have been.  This
> patch simply adds SOR to the volatile list.

Could you expand on when it wasn't written and why it needed to be
please?

--RCQbRqFVGRR2abej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXHlyUAAoJECTWi3JdVIfQH7QH/iiFtjnWj6/tyzk4VnfXeKLj
t6mfUR7Gd2cL1OhVsDg9HJJ2hhuxw/FuOK20MRE2UZbdhMGQwZq0zfpNs1bp+JIR
MhzF1GFfJrRvY6HbsKtk/mRvUysPKjnWuV8UwA2Ec0W0Kn7AKfib6TO10HSNag3I
UEfH66jQZmOle4mSmARzlHDyZvplDp9W+ABqQrgKNObUjJVEfZJRm2C5xOaAaABB
RxGVnEJjcBK4yaCSITI51Lqs12V7zgDDg2fndkqQjA1zQG3du3N0CcTCIYCsxt7K
n2HHvnG/oDYQs3wrz9w0d+DwQX/GD0AQvg6BSvWQz2CIRM7O3bEDFoACTi7o7Y0=
=ew4i
-----END PGP SIGNATURE-----

--RCQbRqFVGRR2abej--

--===============8172644862670372784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8172644862670372784==--

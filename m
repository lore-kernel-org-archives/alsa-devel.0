From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: declare snd_kcontrol_new structures
	as const
Date: Mon, 29 May 2017 14:14:27 +0100
Message-ID: <20170529131427.mezkiwcvo2znkekz@sirena.org.uk>
References: <1495896375-30855-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4329430608507852037=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4BAB2664EB
 for <alsa-devel@alsa-project.org>; Mon, 29 May 2017 15:14:59 +0200 (CEST)
In-Reply-To: <1495896375-30855-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, clemens@ladisch.de, lgirdwood@gmail.com, tiwai@suse.com, julia.lawall@lip6.fr, johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============4329430608507852037==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cjo5vbwv4cfjepq3"
Content-Disposition: inline


--cjo5vbwv4cfjepq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 27, 2017 at 08:16:15PM +0530, Bhumika Goyal wrote:
> Declare snd_kcontrol_new structures as const as they are only passed an
> argument to the function snd_ctl_new1. This argument is of type const,
> so snd_kcontrol_new structures having this property can be made const.
> Done using Coccinelle:

Acked-by: Mark Brown <broonie@kernel.org>

--cjo5vbwv4cfjepq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlksHrIACgkQJNaLcl1U
h9AQ6Af/SYHN10JcudGoHosgxab47NA+Ypt7AjxkfRA+CJgA1NRGvTmopRopFf26
79SWlGmaMbSVmtZdMB3Iq2PaFWJCF5Ox1MrXkrPtv0lGxpHVWHXo/7yL61T7POB5
8wg51DokQyzlXS/7dL/bEYDajeRUVTJEn5VanevXgv4Efa1z6BAbZtB+uy6r+wZ1
3NWo1C/V/tQ3ziK/Bv7CSimVX3hSXninjPnFq3pvXyyiYSsg6Km/4K4HxRpU5RDj
t1RvvmmtAGEXpneVcCTCitoIgpa34QNl2p/mqr6EDSnA25+SPJ/CGpz5BIxO6G+6
da09+Y5lFnjAzj6fop4CUEaWswpp2g==
=PVxq
-----END PGP SIGNATURE-----

--cjo5vbwv4cfjepq3--

--===============4329430608507852037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4329430608507852037==--

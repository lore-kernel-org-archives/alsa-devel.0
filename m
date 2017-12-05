From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about soc-utils
Date: Tue, 5 Dec 2017 12:39:24 +0000
Message-ID: <20171205123924.GG11658@finisterre>
References: <87r2s9txwi.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1411272482295305886=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA29F266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:39:28 +0100 (CET)
In-Reply-To: <87r2s9txwi.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1411272482295305886==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 08:01:07AM +0000, Kuninori Morimoto wrote:

> But, soc-utils::snd_soc_params_to_frame_size()
> is using snd_pcm_format_width() instead of snd_pcm_format_physical_width(),
> In "2ch x 24bit data with 32bit width" case, above "frame_bits" will be "64",
> but, below "frame size" will be "48", I think.
> Am I wrong ?

That's just an oversight, it should be using the sample size.

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlomk3wACgkQJNaLcl1U
h9DXdQf+M25tw2u0gJmgCvUNQGsm9qOviVSPfb+SiXHKSNm3Buy4t/9Lqhn5EMzr
PxrgLbbm2LIA+mDZZPlpJou66Wsj38wxBxrfZViMW2NzkScx2D6da1kPGSLDG+kW
mGHuGKUV7epLaIoA5qRxlrQP3FuluWfPOMNKqIaNc2klnTLs2gc9AXFWsnncvaUc
WI+V8PbShIgQnbBfrH0YQd13r7lnaaGVQuP2tG0Ugp6OvYjSCdPwgybaBU6yAHWx
NsKlElZvPIF7jWuxRrva10MM2OfC2MapMzcL2YUmFTGBxWyhha//MwDsbZCd4bSO
OAjJGOkSR5MBuKaiODQfEvSV8OE0BQ==
=eel+
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--

--===============1411272482295305886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1411272482295305886==--

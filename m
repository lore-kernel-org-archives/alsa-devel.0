From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: export function to find
 components
Date: Tue, 18 Jun 2019 11:46:16 +0100
Message-ID: <20190618104616.GK5316@sirena.org.uk>
References: <1560844059-5897-1-git-send-email-bgoswami@codeaurora.org>
 <s5hsgs7e0wr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4386972750024376590=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3CC0F80CC4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 12:46:17 +0200 (CEST)
In-Reply-To: <s5hsgs7e0wr.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============4386972750024376590==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HEgoE9Ku6Eog9oq6"
Content-Disposition: inline


--HEgoE9Ku6Eog9oq6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2019 at 10:46:28AM +0200, Takashi Iwai wrote:
> bgoswami@codeaurora.org wrote:

> > Drivers may need to use the ASoC core function to
> > find out whether a particular component is already
> > registered with ASoC core or not.
> > Export the function so that drivers can use it outside
> > of the file.

Why might they need to do that?

> Why not EXPORT_SYMBOL_GPL()?

All the other ASoC exports are GPL, any new ones should be too.

--HEgoE9Ku6Eog9oq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0IwPcACgkQJNaLcl1U
h9A2Hgf+MLN+CcPHI83z4dawcdkQR9dkXmxPPnBx/+6qohSXV8XhWaclTwZnF3S9
OlcFavt5pJZrMSjiK8aP5ddu4/YCEUocw2+iz6QfpFTg+FGMKEmqBA/9iQJ4nzOK
Rni3N11FRaWz8c8pMrGHqZJYfsSBN4x9ujfMGC4Gz+Rfidv39bv/bE5wgEriVtoI
WfRQwEGqyGPE/caYbtjr6iAm/RecpQdj+TsAjgYrKCnISKFChwXapzOw6zBa+LiF
Iv8LdXvEAXRJ0ESIDWwK1EDxfjhvB0NfEdfIa9CedUw6Jc5VYxE2iMJgBVWAmgyz
ZbDyXdWW8qEzyvsU1wPlGPw6tugTrg==
=bPzC
-----END PGP SIGNATURE-----

--HEgoE9Ku6Eog9oq6--

--===============4386972750024376590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4386972750024376590==--

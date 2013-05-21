From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci: fix sample rotation
Date: Tue, 21 May 2013 13:22:55 -0500
Message-ID: <20130521182255.GH1627@sirena.org.uk>
References: <1368710701-12159-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7500132780791266773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A6F261A96
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 20:28:05 +0200 (CEST)
In-Reply-To: <1368710701-12159-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: marek.belisko@streamunlimited.com, stable@vger.kernel.org, alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, vaibhav.bedia@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7500132780791266773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u/esRqyc5dLeU/8t"
Content-Disposition: inline


--u/esRqyc5dLeU/8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2013 at 03:25:01PM +0200, Daniel Mack wrote:
> McASP serial audio engine needs different rotation values on TX and RX
> channels. Commit dde109fb462 ("ASoC: McASP: Fix data rotation for
> playback. Enables 24bit audio playback") changed the calculation to fix
> the playback format, but broke the capture stream by doing it for both
> TXFMT and RXFMT.

Applied, thanks.

--u/esRqyc5dLeU/8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRm7t8AAoJELSic+t+oim9y0wQAJ5SDwn7Ermig4P3eFOsNKoL
P+wTCwB3DQhM5MJpoiAh7iGgR9zWZQy9QEl02chw86oc6AyF5zHTMmBQfvdVB5nu
Ai+VDTCA53apb8oXi0TBD2Kc2QchChy/kssUCrjwZfTOkuWwqL6/PaSPH/TPYKtF
zkz3pP2BzYxXR2o48at1gmXB+fKsR4g6acpSwZhHu7GAqaS1b6GucY3Rj0s5J8sk
Jm28rqoFAcxWtkQ1aCwTq2FY0vyCsAjTdkiEV3dcnFCUkdmrWsOWQHUb1RBXLbrG
lj492+1RUv2zieLZ0eWebD2DyhZL4/bAk3qAbgthrGiYhRvLL8F+IC2Oc44/f24/
ilqZqKiFv2odI5fCQ3ugXc1p6vCmd8R0sOyHJ4iklGlmTUUA7L4zTycHPQ1hxNdh
gP7hcbs/8xptUcKL3xAtHgNGe4z/jfUi7r9KqNPMcZWQcWMG1OCAlN/on6pdsa9k
ZiGlHLykRpby6rrT67YUI2e2IhGF+W6BmgSVI1jHmwgnXbtGY22Mns05wrt7lxtv
r2ZNNy62Qe+Kfzf5jC7zJivDM4asqFrqddhwWFdnA1tiynTMD4Xfq0bq3JZq2SP5
WUbTlBBD3lMUqunQComREiyoM/0jcbug2PLC8IJzXP6Ap9WyC81eLxrR0Uh3xVwe
tEDapAmf0K9byImxsA3/
=vY0I
-----END PGP SIGNATURE-----

--u/esRqyc5dLeU/8t--

--===============7500132780791266773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7500132780791266773==--

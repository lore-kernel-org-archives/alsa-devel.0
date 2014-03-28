From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5640: Remove the pre-allocated
 size of reg_default
Date: Fri, 28 Mar 2014 12:52:58 +0000
Message-ID: <20140328125258.GJ30768@sirena.org.uk>
References: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7392169037623847195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 185702654BC
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:53:19 +0100 (CET)
In-Reply-To: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7392169037623847195==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Ll2WeG2L2s3+nMg"
Content-Disposition: inline


--8Ll2WeG2L2s3+nMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 08:28:25PM +0800, Oder Chiou wrote:
> In order to prevent the redundant memory usage, the pre-allocated size of
> reg_default should be remove.

Applied, thanks.

--8Ll2WeG2L2s3+nMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNXCmAAoJELSic+t+oim99q4QAIlB85bGw5XxA+FTJ2Rp0W3P
zK2Drs356ZlYQHO4cw6mbABPmnAKjioYR0DmQlEigrYrgwhEtCuEs4HsvUKSQ8F6
mh92IHc4uTq8k0n/hgKTf1n8EJEclzaBhsphoS18OejJw+UYkWR9tSYkTesCRsTP
NS7W19YlAsAmNNAneYW8hHcuErAKqOdEGQjCjoU5tDK3rm44uo/UEi0clyFtpLDK
pERjUmIaiubOlQHU5U1nn1qxV3jjXPc0zb7Ijikk/i3oYmlAF6a4YllSWGuM4KIQ
y91V+Ri9Ki0+LeeHOteA7BMPuquggBXkYM3wDFiBmcjAeLtMUzQPrbB3de2VZnVo
jD2C8ITYY0sGB6V313l7lAiRVTAaAsUo71azp8I9rLdsQ2/vEZslUQaPWsGRYjT7
PHwLPbM9knY9Mq+vaDilPA3zIG8BGzvj9oqbneeOoJN5G/HS+VKRW+Ur2fxdUiTM
A0nJ+lCOqoesQGCI9unwH0FM6oUcAvukLLngnVu3XR4zK85K/OOaNAnR/WnhEd3z
IhKV2n2L2j1xk93cmBDKzrjLkRATgeKRUvsDsv2YKnAVVw9+/iLafjXJIY8j2deK
kmu4cTxPubX3uEAKeGYuNFu4uHyeW8pqoaMmeGr/GQFsBU1l8pMq0PmV+Rn3I9PR
tuxOmGCOE/+O9K5nghai
=RhJZ
-----END PGP SIGNATURE-----

--8Ll2WeG2L2s3+nMg--

--===============7392169037623847195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7392169037623847195==--

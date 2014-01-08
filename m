From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bcm: Remove obsoleted Kconfig
 dependency
Date: Wed, 8 Jan 2014 19:59:47 +0000
Message-ID: <20140108195947.GZ31886@sirena.org.uk>
References: <1389173827-1554-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5992944356658905564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30EB926535D
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 20:59:53 +0100 (CET)
In-Reply-To: <1389173827-1554-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Florian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org


--===============5992944356658905564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E9hUM0EC7HY7JpV1"
Content-Disposition: inline


--E9hUM0EC7HY7JpV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 10:37:07AM +0100, Takashi Iwai wrote:
> CONFIG_SND_SOC_DMAENGINE_PCM was renamed to CONFIG_SND_DMAENGINE_PCM
> recently.  And yet we don't have to select it since
> CONFIG_SND_GENERIC_DMAENGINE_PCM selects the dependency by itself, so
> just rip it off.

Applied, but please CC maintainers...

--E9hUM0EC7HY7JpV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSza4vAAoJELSic+t+oim9zkgP/3KTkLr2xgwYIHpO/Eg7GV15
nI0vV8hKaMVl8mHv+mFt0gP41PZ1vOXEPcBso+zGN9D1sAjdaog6XciBMuXvi9vi
yRC2UBwyVYej7iPz74/OrNXkRwlp5ZLH7GWTRp6BswMr6f9J47meRe130c5csdGH
c6VSKs1oqHoqYEHu/MKczbAOpTbVQWSOnWt798XpTgAsgIxGnB5Z1owV67BX0YRw
bqqMy9QBeQ67GpDNtDAfZFtdZjael+YJo1EJnHL9rGhaKSKOVuxgxU28zh89mnVo
LmMOon6S2rfOt/nJpOQMDTyYZJA+ps7Dmb3aU7wBEyj8ogpvRn9vY4RM9HCBJ9dR
LwCEQqDF36YapOAqVTAdFyBxVOoOaIBGtfiDaI1knCc9TG5ZRz9ptEe9UAH/gVLC
C6KyN51lmjOqKFqfnwvQnWgyU/e2Mql09Pr8KiA1k8nUxdln/+lgGb/G+aP1jSuJ
Mt8SxXR7ZUOAVEjxPxv7ratCfJ2p8n8y2NC3FFgYwU/KL7ZtDnkEAez69lXcx4tP
gofZ5dRygFM0ID2uBVb0BZQfLDPIHKiFq+4pt/egnVryvgcZiGlwicIt/BcZNgsm
9Eur5wxswXRJgIbhPqPeeD0fWNyEW2ZT4qXyu/A4s2pomfsmLbvj2I7wrZ8e6535
mHmnI+vZrBc+9Imjb4fT
=ZkFm
-----END PGP SIGNATURE-----

--E9hUM0EC7HY7JpV1--

--===============5992944356658905564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5992944356658905564==--

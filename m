From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: soc-pcm: Add support for
	unidirectional dai links
Date: Thu, 29 Aug 2013 11:47:42 +0100
Message-ID: <20130829104742.GU10783@sirena.org.uk>
References: <1377752099-21373-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4464071839534017631=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0627F2616B8
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 12:47:48 +0200 (CEST)
In-Reply-To: <1377752099-21373-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4464071839534017631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O2qoDrRdTxptnP8M"
Content-Disposition: inline


--O2qoDrRdTxptnP8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 01:54:59AM -0300, Fabio Estevam wrote:

> @@ -105,11 +105,13 @@ static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
>  		.stream_name	= "HiFi Playback",
>  		.codec_dai_name	= "sgtl5000",
>  		.ops		= &mxs_sgtl5000_hifi_ops,
> +		.playback_only	= true,
>  	}, {
>  		.name		= "HiFi Rx",
>  		.stream_name	= "HiFi Capture",
>  		.codec_dai_name	= "sgtl5000",
>  		.ops		= &mxs_sgtl5000_hifi_ops,
> +		.capture_only	= true,
>  	},

This doesn't make much sense to me - it should be possible to tell from
the capabilities of the two DAIs on the link if they support both
playback and capture.  Or has the board wired up two bidirectional DAIs
on each link for some reason?

--O2qoDrRdTxptnP8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHybKAAoJELSic+t+oim9WqkQAJwwAacPHuSZ9t8TOBnA2R8Y
rwjtZIde/n3v2hv2aV5mZNuT01942ujILb8Jq7YQF1BXv8/cQhHEeM3WXkIMNQsj
5pEezzMvDZY5g/xbZutlPGQirc0LoFfyv0utgjJGJim9Z5Mr9UHV2Km3lrOID+dj
90c8B0DF9ZX9cENyj1o3HlnP4CGZySRfV6FV2xtJBgb/+fU3x1mgEOgK6PImx0ty
ENKsaY8vu2XpVZRwObOSHckxUpsh5UyCKFPwz87E+5ntAw+67i3neVNUGbVWRIlW
V0Hq+iGQlFumhvd0bHRc+lJV5BHUbqB0bRctebxQzc21iGMvoJ4ULmMqXddr33ge
8b1DT8L/KJkGuQTX+GY59Oe94JxBdhr0gJbrIcgyPaouJI+9pZDBvizfGRBF+i4Q
X+xJ9DhbKvg0DgxFRotIAu8H/skRtlWLv0EJ4j2kf3liVWos8nK9aARBFTiCy653
PFKbRQGLHqd7bBbEDROlKePYnPjnQDNdlVZWkMTr2Iw84p/krI+35fb2xQg7Jrvi
iaSwowpCIoVI3ynspEaDg7DtksJekvNMgWFM92x6wTqus9xpKamULTgqlGdwDNds
BnBo8XACYkPCJZNF7yUkIRQMPZYhAPe16Lc9/R800K31bIGNkx0zOcSi2iiImGkH
T7hHOBClWmE9V0hm1tlz
=NPY+
-----END PGP SIGNATURE-----

--O2qoDrRdTxptnP8M--

--===============4464071839534017631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4464071839534017631==--

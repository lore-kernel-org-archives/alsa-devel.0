From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoc: kirkwood: merge kirkwood-i2c and
	kirkwood-dma
Date: Thu, 25 Jul 2013 20:16:04 +0100
Message-ID: <20130725191604.GQ9858@sirena.org.uk>
References: <20130725111428.419ee278@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2334479028937024094=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E6F92608D9
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 21:16:10 +0200 (CEST)
In-Reply-To: <20130725111428.419ee278@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============2334479028937024094==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXqDGoDRqNOsF677"
Content-Disposition: inline


--uXqDGoDRqNOsF677
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 11:14:28AM +0200, Jean-Francois Moine wrote:
> To avoid the declaration of a 'kirkwood-pcm-audio' device in the DT,
> this patch merges the kirkwood-i2c and kirkwood-dma drivers into one
> module.

This seems mostly fine, though it may be best to keep kirkwood-dma as a
separate module for the benefit of the S/PDIF support when it gets added
- I had a look at the implementation Russell has and it looks like it
can be added as a separate interface.

> -	.platform_name = "kirkwood-pcm-audio",
> +	.platform_name = "kirkwood-i2s",

Should the name be done as dev_name() for the interface (I don't know if
there is ever more than one)?

--uXqDGoDRqNOsF677
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8XlxAAoJELSic+t+oim96KkQAI1ZCIRwUCURAg2+SoDxHgqq
rLrcVNf2D7a9yMw1z3muobdHvvIkXaFnQBaszyOP/eHjEfoZap7ilyCU+SB0Ho6o
5BzPG8HKGrBiiDovAxmVvqwJgLpi34mMhKd01Ay+z+Y2GvQdx7hiUpcGL05F8yKg
Yi9JxORKtAWp/NGDGzlZ3EKGE/vHudX28WeNYwrecC5sJOssW2Qov/mYgBvBWdyH
z8Geb9778/FpVaDmOh9e5YdnSy6fEL3fOXn0DfptKySEwKvkfC5tkOoKb8ikh1ad
SoFW/xpjMNHb5HaLuV6ta4cUQ8QK3JlZhlZOKcOSKcGPhrAOAnEb4FVa0KbNME2j
5xwXFe6CAVkqy+FPxD6b5YE2pmDrw7LJwYXXf89rZJ3EiF4Ldapfk1NVa5tKRN4m
2D3wfX7eVWGJNJC/N8sIpQRrIv0uMqfH4spuu0IDgxiCNBrvhrxGNZbwCswCatf9
i2VFe6bbKh4eT8iep7gWL3QHk6Z0JonV54duulaYLf5ZX2eSjh+JXJeGyydkacII
ir3R1q+ERGBcXZvtHz9L8P4uxq1jYfg2s0N7g3c6qVO12hbiOBN2UScuVv8/rqxa
01KK7td9OxzDcLForwe09qU1p1eCmfKgLeTGCctof15LAMkQX7Gq1ZSQqbh+rNO6
+rDMcuBTCpdO/zsrqkFt
=UvGR
-----END PGP SIGNATURE-----

--uXqDGoDRqNOsF677--

--===============2334479028937024094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2334479028937024094==--

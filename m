From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
 before writting
Date: Mon, 1 Jul 2013 11:07:10 +0100
Message-ID: <20130701100710.GB27646@sirena.org.uk>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7773486997935376623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E3E02625D8
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 12:07:18 +0200 (CEST)
In-Reply-To: <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7773486997935376623==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+NWYRNQpSl62EBce"
Content-Disposition: inline


--+NWYRNQpSl62EBce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2013 at 04:16:08PM +0800, Shawn Guo wrote:

> +	/*
> +	 * It seems that sgtl5000 takes a longer time to get the registers
> +	 * ready for write than bread.  Let's give it a ramping time before
> +	 * the first write goes.
> +	 */
> +	msleep(50);
> +
>  	/* Ensure sgtl5000 will start with sane register values */
>  	ret = sgtl5000_fill_defaults(sgtl5000);
>  	if (ret)

This seems like a really odd place to add the sleep - I'd have expected
this to be a part of or just after the reset operation.  It's a *really*
long sleep too, though if that's what you need that's what you need.

Also "bread" :)

--+NWYRNQpSl62EBce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0VTLAAoJELSic+t+oim9QU4QAJ5th7cSNaCT5tNV71l+UXrU
P76mrWuk03vd6Y162YqoG0vTmimRc19mrOhwAFz7Gg3Hdts5nh0/lDnhhMFiUbNM
EAkfC6UysC4F+TEJcQbRe0XpV4I7e9eaPE+SNo6sdt+FIQbTfqO2Ym+Z52/SvsKi
MRrxrmon37uSpJy1S7HqCqfQTj/Z79YGgU1vCO8vQJWXC8D0Ux8HmZRubx33uqAf
pEjsCkSmgIP8spDi6TqmUMzTH1LCYZssekK2WKwoU+4q5UJ+baNxSqRyOwATx1Gc
NB8OH19mOfzxWy6vdeS/Jbrwb/PZw9GMwWeVkcbVwXY1AFHqTZfniqSJvIAB+xO2
AK2AaTn8YsyErj/L4+gdKxwTW/R1XOCQFWWr9QdZ67wwrx8zmKni9FlJqHg6MFKg
Zvj17z0CEVB+7fZSrdZmWayfv/imOiMEw+qfcTjjWuXnm/LzEKIiNTeWaEugmq69
wE6vXOibu55vYeZlh1fvs7sX95jt+IB+ic+BSxK4tpb0STLUym5gFKRAVFsPkoHA
TZqEBzOlq98y3j4t2qzaJpj4QardobtSv8j4PcynNFAmYgLw2r5mbGu3YBlmczsa
lfyZO+vm4TS9B6ATs33tBuGKoBxVLasGUrqPqhlaTiyHIdIiUREh+sktv5iYmJDX
2buKEea5sdTo1qGIqvKH
=KghG
-----END PGP SIGNATURE-----

--+NWYRNQpSl62EBce--

--===============7773486997935376623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7773486997935376623==--

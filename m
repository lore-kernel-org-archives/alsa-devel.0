From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pxa2xx-ac97: fix oops when
	codec_driver probe runs
Date: Wed, 2 Jan 2013 10:49:39 +0000
Message-ID: <20130102104939.GA4627@opensource.wolfsonmicro.com>
References: <1356704275-3098-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4339449452570810590=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81CDD2608E7
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2013 11:49:41 +0100 (CET)
In-Reply-To: <1356704275-3098-1-git-send-email-mikedunn@newsguy.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Tomas Cech <sleep_walker@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4339449452570810590==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 28, 2012 at 06:17:55AM -0800, Mike Dunn wrote:

> -	/* Punt most of the init to the SoC probe; we may need the machine
> -	 * driver to do interesting things with the clocking to get us up
> -	 * and running.
> -	 */
> -	return snd_soc_register_dais(&pdev->dev, pxa_ac97_dai_driver,
> -			ARRAY_SIZE(pxa_ac97_dai_driver));
> +	ret = snd_soc_register_dais(&pdev->dev, pxa_ac97_dai_driver,
> +				    ARRAY_SIZE(pxa_ac97_dai_driver));
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "snd_soc_register_dais failed with %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = pxa2xx_ac97_hw_probe(pdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pxa2xx_ac97_hw_probe failed with %d\n",
> +			ret);
> +		snd_soc_unregister_dais(&pdev->dev,
> +					ARRAY_SIZE(pxa_ac97_dai_driver));
> +	}
> +	return ret;

We should be doing all resource acquisition before registering the DAIs,
if anything this patch introduces the potential for additional issues
with the clocks not having been acquired before we try to use them in
the sound card.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ5BC7AAoJELSic+t+oim9t5QP/2KedskYIpElb0TMfaSSXUyE
rOqY32RW1DS5JO216qIBs5bcXQpUBmjNPsTW3ktt/fnNsdwN7QKlvf6QS+CwQN5/
U87+gAGtbEWldO4tjeRRBEAUQesSIYWHCjHZ0aPcusKVgBPweiFCdoCCiKgnLlPE
SFrV8HOnDNrydbU1WPTsWn2IskizHclXUP91l7BiyKIty3WICzQlNoXYHMKytwD2
Qi5Dzwks3bCG03qsY5Br5LMkNAMXhC3YyvLGlhVRftqtWdQBOjnZBjqw5B4X03J3
ojM+ymasE3HwiDwKl0DnAoBs9WEL3VsTN9OYb3frtqKxiW6SZ2hqELjgr/ZNkotq
cFHX8DbyBhrGW09KKnnoPtLImcRbCBsliBk4u+6fEtbSIank5FRR/mrJFEAAdk2/
0WJ8q9PxQ6bdxUqakUS6glrvBPo6cVl9PHN/gTI8KVjyYgVBfGEkjPnvLFKn1i1m
sm1QKVkrirR2mBbvfJZzOn7D3p2ehsOiWhEHvcnxMMVGmZhqDbjsEEklCRZMZT2W
398ETYfm1sXHVmQR+ZezDmfYGwFG2w9FKvj5onqgXuJf2tlunKOZLDmpwL1opuoq
d80t7gkEx3c7e1WDvCE2iDSlgQHhNsc7ZOHbESRyFWVNgYBpq376iiJyvgPGdklW
Ii74WCvdmfe1VX9l6yA5
=Q8Pg
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============4339449452570810590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4339449452570810590==--

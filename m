From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Wed, 16 Oct 2013 12:58:47 +0100
Message-ID: <20131016115847.GK2443@sirena.org.uk>
References: <1381920801-9187-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9125191103021230733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B5C26515F
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 13:58:53 +0200 (CEST)
In-Reply-To: <1381920801-9187-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9125191103021230733==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O+TX324yz4KliqWi"
Content-Disposition: inline


--O+TX324yz4KliqWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2013 at 06:53:21PM +0800, Nicolin Chen wrote:

> +	if (!dev->of_node)
> +		return NULL;
> +
> +	pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
> +	if (!pool)
> +		return NULL;

Can you refactor these ifdefs so they just protect this OF specific code
and just have the allocation fail otherwise please?  That way the OF
dependency is minimised - we should be able to support this on other
platforms in the future and the rest of the code will be the same.

Also is iram the best name?  It makes me think of the dedicated fast
instruction RAM that some processors have.  sram perhaps (for static
RAM)?

--O+TX324yz4KliqWi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXn90AAoJELSic+t+oim9CLUP/j2rC6yyQy8u3AVqyZlLXQlk
8h9ncVDmDAtJx40APKIK+WbkMa3EJ2kn1YWbj3gaawhnZvZtu6wqqfZi7dfYHBtt
2ZYlXEX5wm1x+92z57RINDLbXwFKznws2WwvLdd6m8+3mBxKAcAZDmecjilQj6TU
klvHsk1puG/sFmqSH8E0zulZ90iD8RhE8PPRKFYT+3snS3uoifb+L344bSgwnTh3
Zgs0RO01pWmzhk1vriFRBxyy+xPAlwQlu5Bjx2II1+Z/m25uXZKYmlmtvdPV3aQ/
gzMkqnFa49+5EYEWaBnEfELDyKm4jZhn+VNRMwkRI6/HVnkLQ8sgQIH+hmWwbUnE
tVxQ0V+B25XiVmoWmMZh5PNrJAsaNEGXsUre3JE4Jo3klCFMjge532YVH1YL/KIb
UdsWaBiJ74g37h59pTGeQPwxUazG9rLwxRn8zw8l9AnLb49a0wD4iZu6IRjrIIhB
uo3/Q5hSe9tCiAivRqJQ3ZDsJyWDd1uzjr3fvwsDye8b3DljyAJTW57rI5vS77MZ
O1tn8n5+VDjCEJ12yi0CrQLsSNTLfVdpkap9e3HvrSeAxlx9IK9C/OekstpK4vWI
c5+5U4Pqc3RK7BJpNM0F2w1nPTAfhLKBpzFq+YfLC8PcCE8/amYBKBqjwqPywkx4
ekl0hVvcwzLdbRPEG0Vw
=MzYM
-----END PGP SIGNATURE-----

--O+TX324yz4KliqWi--

--===============9125191103021230733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9125191103021230733==--

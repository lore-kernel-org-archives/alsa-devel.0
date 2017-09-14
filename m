From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5663: Add the function of
	impedance sensing
Date: Thu, 14 Sep 2017 10:28:00 -0700
Message-ID: <20170914172800.dst524eo6emmjl3d@sirena.org.uk>
References: <1505368256-27250-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2951438092392610057=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE18266986
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 19:28:04 +0200 (CEST)
In-Reply-To: <1505368256-27250-1-git-send-email-oder_chiou@realtek.com>
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
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2951438092392610057==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a3u2svjlzjbwlkks"
Content-Disposition: inline


--a3u2svjlzjbwlkks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 14, 2017 at 01:50:56PM +0800, Oder Chiou wrote:

> +- "realtek,impedance_sensing_num"
> +  The matrix row number of the impedance sensing table.

Which table - one in the datasheet?

> +- "realtek,impedance_sensing_table"
> +  The matrix rows of the impedance sensing table are consisted by impedance
> +  minimum, impedance maximun, volume, DC offset w/o and w/ mic of each L and
> +  R channel accordingly.

I can't understand what this property is supposed to look like based on
this, sorry.  What does the property actually look like, what are the
values in it and what units are they specified in?

--a3u2svjlzjbwlkks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm6vB8ACgkQJNaLcl1U
h9Dg2Qf8CgkAFHDZZWVf1KoLDy2UNuvyfu0d6cONbqEJGWxTwyMlZXeB00iRGTGH
06vIIytj66BwyopitHBsUsC9MNv40ajFxjPNFqFfUBfe5YyKh+aBdt4qE3wCHZNE
4MGWYfNxy+8f/otOHwMT/CwGtrDHvnt11peTOYTumlNs8wc+g/ek5PCug7Fp4GUY
wf1DR4i2dsAY3Qv78GVUM60XgoMTBauBGokiQXiKpewd2jjkRY43CtuK6a9Ai/p7
BprniW9j8/PIlVIBHhEt+w0hA720EmTnPshIuK34QWPXX+LjkDSf9i/PDQpciIvJ
yhiSSiQ3iEt2qAqwmRwzdsEWArKu2Q==
=UMw9
-----END PGP SIGNATURE-----

--a3u2svjlzjbwlkks--

--===============2951438092392610057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2951438092392610057==--

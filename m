From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tlv320aic26: Fix keyclick feature
Date: Tue, 6 Aug 2013 12:42:14 +0100
Message-ID: <20130806114214.GA29078@sirena.org.uk>
References: <1375789171-12098-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2888169290538584361=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 53AA526535B
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 13:42:17 +0200 (CEST)
In-Reply-To: <1375789171-12098-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2888169290538584361==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 01:39:29PM +0200, Lars-Peter Clausen wrote:
> The tlv320aic26 contains a embedded snd_soc_codec struct which is referenced in
> the keyclick code. That struct is never initialized though, replace the embedded
> struct with a pointer and use that in the keyclick code.

Applied, thanks.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAOESAAoJELSic+t+oim9tNUP/0AXqDIsBjO/mt+5FpBnzdJz
h+QJQ1QAH+XVsAhMCggdRw+Jb3JYD0F11ziV5cmG5v4q05GbQexQ/dn7O1twL6Eo
DplU/dQrOfxGW4LlhDBhmiOjKTgsXskbo0+eVchpQ0Jh+0nw7qYJj7WqhfNAV7//
Hh8uqBJw+zQgyFa0eUPyTDBeotL4CGp4rLIm2w7XZPqlDpsVJ8ZmaE78KeFktAMh
ihFllG/h7NcrZs212powxcES5pIi1U+pdtlsJRpizwnZaMrPu6UvEL2iKNYRZBqq
z1nB36ZQs2nLpeCJ1FxE463diV4WfAK5WDMrcf/1oqSYBqfr2IqmgvO2t8//61M/
95wtNXZsKY8oT/6nesOJMF95j8uzVOCP8xuqdMil3dlS4k90lwVGLBAgar54wEzj
qwgnfYPCBm8Ud6Up1zQ9IhriaS4gLZL9hG3CvIHRk+Zz7VbEuWXNqjNnWmSJx86S
cuw9XSmJAzqeNJFYPq0RcCtHP0TYA+J+0f9mDHYtzz4mtTvVtyByHWjyXGzNealv
fgGP08BsGPPKb6Rq7RMvg+46dZXwR6juN9rD2rPE97SiMXMYMgD1S07XpvwUSe1G
saO0hyV4Dw5f0gGM2/Hc/r39MFvvwwwLjOZupm2MmSQn/3CvkRrYuZ8PH/84RETn
WSDpuYji6A5AajstASXm
=0L/0
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--===============2888169290538584361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2888169290538584361==--

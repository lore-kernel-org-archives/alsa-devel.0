From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum
 workaround into SPI I/O function
Date: Thu, 19 Sep 2013 10:56:28 +0100
Message-ID: <20130919095628.GH21013@sirena.org.uk>
References: <1379527587-14567-1-git-send-email-broonie@kernel.org>
 <1379527587-14567-2-git-send-email-broonie@kernel.org>
 <20130919091318.GA22389@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6933137731120836901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BC3DD2619E5
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 11:56:51 +0200 (CEST)
In-Reply-To: <20130919091318.GA22389@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, u.kleine-koenig@pengutronix.de, Marc Reilly <marc@cpdesign.com.au>
List-Id: alsa-devel@alsa-project.org


--===============6933137731120836901==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D+MycPccvPlP5/X+"
Content-Disposition: inline


--D+MycPccvPlP5/X+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2013 at 10:13:18AM +0100, Lee Jones wrote:

Please delete irrelevant context from mails, it makes it easier to find
the new content that's beenn added.

> On Wed, 18 Sep 2013, Mark Brown wrote:

> > @@ -94,10 +94,15 @@ static int mc13xxx_spi_write(void *context, const void *data, size_t count)
> >  {
> >  	struct device *dev = context;
> >  	struct spi_device *spi = to_spi_device(dev);
> > +	char *reg = data;

> I think this requires a cast.

No, you should never need a cast to or from void in C - it probably does
want to be a const char though.

--D+MycPccvPlP5/X+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOspDAAoJELSic+t+oim9FpkP/igeBTgdqLd2AM0jwuzRaaIp
feGipN7o51qlbvGEawz50qIkqrfiSiq0Zr1CPdvvBxMyE/uHxwMDxNazmDESL7h3
2kWHuMyhQuT0YIahFc/M/7wr7SszfCFNmu9NAT7pQtrGuBV19MkerPCFr3qVFQVz
OxWpQ1IZXraXV9t+DAq2o/FJtK6IZOO7QHUufY5y6UpkZIqIhvW8yY+A4XWgOylJ
Y0r88K9Ips1w729JUjHxZEF8u4KH6IMP/xMT04vO1YMXsmNKXKNAGRuAZex7NVom
eXSgeQgsEcuTkpHwd7Ny6AWepMI/0342BJHylDlJOSP1UEzOc3+Z+RPIFoaDqbzK
IxDjmq0deFWaqAaAIwVH37Ub5uI+/Kua2Lv/QlRfGlfZvxOQPI/RhC7GAtwc3c38
pqAEPyeKP+BVKuq6ipJ7+Y+PvY4FpGnhHSjJB7bHqR4mVfR3GHnQz3SmTe5TzfaR
7cf9hgidCEqZ+2zCroTCy3A0e6/hYur25ekZmNH+EZovIcFGxWLIkFYKI4U/PTb2
PhwFRM4RBGuFcrymMMdeToGCYNJZnbfO+XaQ5VUsZnSX9+0ooN0pDKZo3tn8MLhr
qbO0ghy5nXTahj0ABaJ1skkUk/vUW9OL7tJ+WwOEcUpCxe0fmhaTtfoPWFHDq3PP
YXM3I6yo9sansFj0gt3Z
=2/jp
-----END PGP SIGNATURE-----

--D+MycPccvPlP5/X+--

--===============6933137731120836901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6933137731120836901==--

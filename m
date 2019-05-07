From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/19] ASoC: SOF: improvements for ABI
 checks and Intel code
Date: Tue, 7 May 2019 12:04:46 +0900
Message-ID: <20190507030446.GD14916@sirena.org.uk>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
 <20190503054047.GB14916@sirena.org.uk>
 <6ac56436-5ce1-d977-45ef-f305f77bfe01@linux.intel.com>
 <20190506035133.GI14916@sirena.org.uk>
 <cf4cf0ca-b11d-48ff-8e23-fd2e308ec3af@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8020003008254999319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2182CF80726
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 05:04:58 +0200 (CEST)
In-Reply-To: <cf4cf0ca-b11d-48ff-8e23-fd2e308ec3af@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8020003008254999319==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zKt6bo/V7G+vDr7"
Content-Disposition: inline


--4zKt6bo/V7G+vDr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 09:59:24AM -0500, Pierre-Louis Bossart wrote:
> On 5/5/19 10:51 PM, Mark Brown wrote:

> > The last point there is that Intel only write patches, nobody from Intel
> > is reviewing other people's patches especially in areas of the code like
> > DPCM which are complex, fragile and where Intel is by far the most
> > active user.

> It's a valid point, and for now we indeed only check for non-regressions and
> provide point solutions without looking at the bigger picture. We have a
> couple of people ramping up (Ranjani, Libin, Guennadi, Jaska) and hopefully
> at some point we'll be able to review and improve.

Even just testing (rather than reviewing, though obviously reviewing
would be good!) patches off the list would be very helpful and is close
to the regression testing stuff you're already doing.

--4zKt6bo/V7G+vDr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQ9c0ACgkQJNaLcl1U
h9DqnQf7BbIANJ8L8hITt30Bp0GVGsM7lzTpSl+yY2Uk3xJZQNC4VivJQQ6SY8b7
bF8wOqXGrsmuhTN0ToZbSSbwKXJHOMEdNNKNSz+qAf1SU/JdjCJ98uykimrhWlXu
d9SlAyXInUmFSpion+/hVYhQJmSYmOzIcAQSM2ISNUdwj2uNEIG0CM7Op9J2MmBb
g+B0ppysb/qR0kRSEFtwc16FejnXfA7YRQcPLwNvg7Rkb02AgNlZI8PsGE+E8oYI
5UfI7RKBMXLWHIVUgULAfOC8Ew7y9+jUMHsD7TulR+b0vhrWXVnyEYVzF/QsK5KC
cq2NTKtSe3jaBwjVWRMjvWTuyxRWlw==
=trxJ
-----END PGP SIGNATURE-----

--4zKt6bo/V7G+vDr7--

--===============8020003008254999319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8020003008254999319==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dapm: Add new widget type for
 constructing DAPM graphs on DSPs.
Date: Thu, 15 Jun 2017 11:01:24 +0100
Message-ID: <20170615100124.vegs5xwkvbzqtq7z@sirena.org.uk>
References: <1497021829-5680-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20170609175333.6ift3olr3thobopr@sirena.org.uk>
 <1497439735.30929.330.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8094200033942861543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 298B3267208
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 12:01:30 +0200 (CEST)
In-Reply-To: <1497439735.30929.330.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8094200033942861543==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="clylutps7wjdzcs7"
Content-Disposition: inline


--clylutps7wjdzcs7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2017 at 12:28:55PM +0100, Liam Girdwood wrote:
> On Fri, 2017-06-09 at 18:53 +0100, Mark Brown wrote:

> > I'm still a bit unclear about how a pipeline and effect are different
> > from an ASoC point of view - it matters on the DSP but from the kernel's
> > point of view a pipeline just an effect that happens to have a more
> > complicated implementation on the DSP?

> Yes, that's true, some of the objects will most likely be treated the
> same by the kernel core but for the DSP and driver they will different.
> i.e. they create different objects with different topology private data
> (using the widget ID to differentiate).

Shouldn't that just be handled in the driver though?  Nothing outside
the driver cares.  We're going to need to differentiate between
different effects and pipelines in the driver anyway.

--clylutps7wjdzcs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllCWvQACgkQJNaLcl1U
h9Ag1gf9F6g+zGwXjRwUu+u3o1Io3ipw5UrYSxHnmBQ05L1TGuKbPFFwa3jLX8be
Xx8WA3cYbXc1Ogvj4ElCUDQgOQnpQ9YUJ7rR/j3n1NaqTNaLlnkKvbgrkQZGwl4c
ZHD27n/PEtsRNpwe2WulVASE7FeTYYyWflgHm/6HEfVYkqGa9ssk3yMcfy31vLCs
Xz4MIvng6PL8NY2FTAm5N8BAeCeXhl4Eoaa2lH4ZRFRI+ZpMUbO9z/3GfMmfLMB1
4wm9BFGQODqxVX3C1xHV4XyR6qRjublMaJKLyPa219RHQII357B64VuxO0R93zBz
jO260OoQtCyJV5/jtsHPLXNPdqNF1w==
=63FL
-----END PGP SIGNATURE-----

--clylutps7wjdzcs7--

--===============8094200033942861543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8094200033942861543==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/3] ASoC: core: do not unload topology
 in unregister_component()
Date: Fri, 5 Apr 2019 09:28:21 +0700
Message-ID: <20190405022821.GC2803@sirena.org.uk>
References: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
 <20190405003040.8709-2-ranjani.sridharan@linux.intel.com>
 <20190405021729.GB2803@sirena.org.uk>
 <c99769e7a08a7402add146e27ee7dc191b119232.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8133317085803408091=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 981B5F80792
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:28:31 +0200 (CEST)
In-Reply-To: <c99769e7a08a7402add146e27ee7dc191b119232.camel@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8133317085803408091==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 07:23:54PM -0700, Ranjani Sridharan wrote:

> Agree that this might make the clean up robust. But today we call this
> only when the component is unregistered and that's causing a null
> pointer dereference. So what we really need to do is to remove the
> topology in remove() first.=20

If that's what this is doing then the changelog should reflect that it's
fixing a null pointer dereference rather than talking about these
separate issues.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlymvUQACgkQJNaLcl1U
h9AQcgf/W5yjX2tUrvAwxm/s4MvRnqp6ws8KpmwMGutR9XIJrI9o141MFj/D9hLo
ppRQ8ZH8MKrQKRSDhlLS0x9pAOkH3fMVQx0kv5LGIiWhZ5a82HpPgGcgKEfYII2b
dFzPS031GZVHLyJ0cryLRP7eox7uEZPWa1r2JWA6RogyZYr99jXW/+LEfsBAG0fn
v48K8TXgMKLqRVtasJlAWG3d5j+jbZ0vCULnrA8xibIOyZADKhQ9jUkFsYR7w/kS
lU1ipm7hIuoYbatcdv0Mv8Pq30wA5KgIFVHkai3/KNJxovIz6rn730vdPjcVa5Yo
NAyaGcaxqxMSUQ8UjAqv8PEJt4gBiw==
=8Uny
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

--===============8133317085803408091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8133317085803408091==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: SOF: acpi: add module param
 to disable pm_runtime
Date: Thu, 13 Jun 2019 20:13:03 +0100
Message-ID: <20190613191303.GX5316@sirena.org.uk>
References: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
 <20190612164726.26768-3-pierre-louis.bossart@linux.intel.com>
 <20190613184801.GV5316@sirena.org.uk>
 <s5hk1dpe283.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7309909173404186475=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3409CF89703
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:13:04 +0200 (CEST)
In-Reply-To: <s5hk1dpe283.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7309909173404186475==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U7NLafZe7Bh9OCap"
Content-Disposition: inline


--U7NLafZe7Bh9OCap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2019 at 09:04:28PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > I can't immediately find it right now but isn't there some generic way
> > of doing this in the runtime PM framework?  If not it seems like it'd be
> > a good thing to add, these can't be the only devices where it'd be
> > useful.

> Well, runtime PM can be fully controlled via sysfs, but the problem is
> that the driver declares itself being runtime-enabled.
> So, either we leave it default and let user-space enabling it (via
> udev or other way), or introduce some condition in the driver side.

I thought someone had added a command line parameter to do it based on
dev_name(), perhaps they were just talking about it or it was in some
BSP somewhere though.

--U7NLafZe7Bh9OCap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CoD4ACgkQJNaLcl1U
h9CS7wf+NyiE06T0ELAkUK7p6KBurBosA0c15gTltBa+f60wfrOCwOWNWoNK/CY8
4CMdFtB0GQKXxyaIqXQGgsYj2rDD1WhT+pqBgkoYD1w9xGAfGVBduBuxXVHDmLnE
PpKhvokOO5ZO+jfyB+dWYykBzB9bfwrms0X3n+Rc3aUaINkUxkd/j5h640Pp+Q3f
sk1sAGwBkddCD+MtoN+eTvAETzF/hXnAFbrudEtgzIONJv2NA7K4xdz5e9qIrnSx
Xd/k3ThLnldJ5HxKyoj8Z1E7dICOwyCTVBvgOOc7AroYnS71L9SXZKDOl+7jVDv7
9mTkdYl7QDIlaed3nTtnVyOd0nNgdA==
=5FNq
-----END PGP SIGNATURE-----

--U7NLafZe7Bh9OCap--

--===============7309909173404186475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7309909173404186475==--

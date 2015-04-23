From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix the makefile for atom code
Date: Thu, 23 Apr 2015 10:32:56 +0100
Message-ID: <20150423093256.GQ22845@sirena.org.uk>
References: <1429780093-11783-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4660115508961718821=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D8FC0261585
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 11:33:03 +0200 (CEST)
In-Reply-To: <1429780093-11783-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4660115508961718821==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tA17j72qc45BosbQ"
Content-Disposition: inline


--tA17j72qc45BosbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 02:38:13PM +0530, Vinod Koul wrote:
> The tom code should be using SND_SST_MFLD_PLATFORM and not the baytrail one.
> So fix it now

applied, thanks.

--tA17j72qc45BosbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOLxIAAoJECTWi3JdVIfQEc0H/0Y+knypzhrMRSsFH3RYFiFA
Ek70Z1zoOV9mcMKrR1Dc3rEeO5FQ9hKeh4DfwdsveHvCXC4vTemPArQVrE/FcC7y
cjlani87Z4xv5qZtsxsF4+6HKkZyT5TV3qg4P2eo3IO7aHhDuK8mjN+GQ1QvYt2K
wk2QPjYmTRnwMxP1YkO2cNQ7teyGBsAvyua4SpqbmMs+dOPg+x0p7DlWASsF6lMA
61W4r8/KlUhpJRppUAZNH/v4TdwDtcgooVf1YdJ6o10jycVg1u01v6rFotC9zagq
wrZhLLKRnVfliGqm7HzUms1BRd5rqBP8hLpdWabUAX+8A8G+Q/EWctGhhBkPfFA=
=gcF8
-----END PGP SIGNATURE-----

--tA17j72qc45BosbQ--

--===============4660115508961718821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4660115508961718821==--

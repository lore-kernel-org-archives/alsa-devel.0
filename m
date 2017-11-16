From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: kbl: Remove option of
 choosing CH count based on pdata
Date: Thu, 16 Nov 2017 11:48:46 +0000
Message-ID: <20171116114846.lnlpesev5yo3d23b@sirena.org.uk>
References: <1510236276-3416-1-git-send-email-naveen.m@intel.com>
 <1510236276-3416-2-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0873128624844230064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 92FCA266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 12:48:54 +0100 (CET)
In-Reply-To: <1510236276-3416-2-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>
Cc: vinod.koul@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0873128624844230064==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="reinwvt2xen5qudd"
Content-Disposition: inline


--reinwvt2xen5qudd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 09, 2017 at 07:34:35PM +0530, Naveen Manohar wrote:

> User-space expects 4ch DMIC data and uses channel-map in ucm to
> figure-out the desired channel to use. Hence removing driver change
> to allow choosing channels using pdata.

Which userspace and are you sure there are no boards that only have two
of the mics?

--reinwvt2xen5qudd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloNex0ACgkQJNaLcl1U
h9CWfwf+Ie5JKIegviLfX2ZN25LsYXtOfSQP6JyOU4OS1BXkoWXfAX0zabOtxAE7
Nk1ZJYUhdTh75rUfFHzZzLgb6LAksJDuayXiwTf15WhSLsnjCk9hUStezJE7qDv3
ykBZnnkIvIdR7gVgLI29wrH6ucaU103k4plIvDJWP3GpqHO/anHRB+8vsZ1Kdc0y
PjGGJuNtdk8AXQUWafuFbLPaSk2TcnCtR2gM2pWd7uPl2Kw0Gqkg6xOsCYXMKo/y
JlYm6k3lqbtBS6pm+wqf3l+kdTMU5W1/kInUUzpxORO1iKbzdByl3ohgnrzsPkMs
cAWh69dd6HH3Wb3l5uPV/uE9jgaM7g==
=JHZE
-----END PGP SIGNATURE-----

--reinwvt2xen5qudd--

--===============0873128624844230064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0873128624844230064==--

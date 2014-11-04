From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dpcm: Fix race between FE/BE updates
	and trigger
Date: Tue, 4 Nov 2014 17:19:23 +0000
Message-ID: <20141104171923.GS3815@sirena.org.uk>
References: <1415116348-11792-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6175397675853844442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D6D260623
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 18:20:52 +0100 (CET)
In-Reply-To: <1415116348-11792-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Qiao Zhou <zhouqiao@marvell.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6175397675853844442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Z3Qj54wC++taHdq"
Content-Disposition: inline


--/Z3Qj54wC++taHdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:52:28PM +0100, Takashi Iwai wrote:
> DPCM can update the FE/BE connection states totally asynchronously
> from the FE's PCM state.  Most of FE/BE state changes are protected by
> mutex, so that they won't race, but there are still some actions that

Applied, thanks.

--/Z3Qj54wC++taHdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWQqaAAoJECTWi3JdVIfQ52wH/jFiXJNrA13TjY8rNNz1g0Ss
7CoSljX/v+FTSRr+3T8rHryoAUMkC4MoguywDJhd3TDQXBuKSWOIjYvHL0E2UA6t
YjTJFGMG8cjDSRFb6YFb7cC2Ep4NDmOGuk0qDJC68FuawXvOTgzfcLJyYz14v26O
3erKzQPvOaFUXFH1dpSu2NQIS93uVewmRI+CtG+2x2xkIFio3/MvImGCk343pb5i
gxTQMu1UqvPMUbsCo0T4m6jsZ2t8ey5Kv0EgqbzjcuqxxV4vj4TYlsIJOMy+BMMx
TMlh01yKjMADnT3mm/IA4aP4oEphxmHWBgXpBarnHlPNXoF/L5Rz2DGDqKy2sLU=
=e4Zo
-----END PGP SIGNATURE-----

--/Z3Qj54wC++taHdq--

--===============6175397675853844442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6175397675853844442==--

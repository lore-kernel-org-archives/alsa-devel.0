From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: remove SND_SOC_BYTES_EXT
Date: Sat, 21 Nov 2015 14:08:28 +0000
Message-ID: <20151121140828.GK26072@sirena.org.uk>
References: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
 <s5hlh9ve7n0.wl-tiwai@suse.de> <20151118181953.GX25173@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8316406597401607514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2864266719
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 15:08:43 +0100 (CET)
In-Reply-To: <20151118181953.GX25173@localhost>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8316406597401607514==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EMQjp+MvU6EBGjHc"
Content-Disposition: inline


--EMQjp+MvU6EBGjHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2015 at 11:49:53PM +0530, Vinod Koul wrote:
> On Wed, Nov 18, 2015 at 02:53:23PM +0100, Takashi Iwai wrote:

> > Hmm, won't this break user-space?  Both use the difference access
> > methods, so I wonder how they can be kept compatible.

> Yes they will, so should we then keep these and mark SND_SOC_BYTES_EXT
> depricated ..?

> Mark what should we do with these

Yes, that seems like a reasonable approach.

--EMQjp+MvU6EBGjHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUHrbAAoJECTWi3JdVIfQfV4H/2Md+9fRZ+NSSDZVU5ogRlwT
Lv3UO4QA8JrzZD3z4K42uOzdLCU1mNLONKzQbTwORsjGidEgwt/mSYDnGXfcydnk
HGxVM4YFYKYShsQbUVOTuTPdF6cgPKS8g1vVf6xKkCYgaTuu+chbAMBnaszYRsX7
p6qx7Th4IiWVjerg1ZX/r4ayVCH3DvfREXJle/gzq5PhRoMmZOFyHmjcRsLO8Tlx
4Lt7f2zOpYsHI+NwDC2KfBOAIB0OkYH9GzwDoTZxM03cBYgtG8MSSdX//fS7XDsZ
SfmKYjbJo6bdEaSaIQbR5lclSinkr5b5NGiCgApJau7s3/OaWv+T5MPE++X+1BY=
=aGFq
-----END PGP SIGNATURE-----

--EMQjp+MvU6EBGjHc--

--===============8316406597401607514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8316406597401607514==--

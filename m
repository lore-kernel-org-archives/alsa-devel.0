From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/8] ASoC: intel: boards: add card for
 MinnowBoard I2S access
Date: Tue, 5 Jan 2016 13:15:39 +0000
Message-ID: <20160105131539.GC16023@sirena.org.uk>
References: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1451949630-3475-4-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0735583668085094785=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85A0B261537
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 14:15:46 +0100 (CET)
In-Reply-To: <1451949630-3475-4-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0735583668085094785==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fuiho1aubMFfXcAs"
Content-Disposition: inline


--fuiho1aubMFfXcAs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2016 at 05:20:25PM -0600, Pierre-Louis Bossart wrote:
> Add card with dummy codec and DAI to make I2S signals observable.
> Uses Mic and Speaker pins/widgets to control DAPM

I'm wondering how this is going to get loaded (I don't see what creates
the platform device) and how we handle systems with a CODEC connected on
the expansion headers?

--fuiho1aubMFfXcAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi8H6AAoJECTWi3JdVIfQyV4H/iy/umlN0leqbJ7se5e0uMk8
FLTEtqGwbsqXdIFwZvOiiocmpZBTBdzru5XamrKzW2dB24IY84jGjR5gRaKFPa9W
xNyhoap29nLepJ7UCAru2wFbL0a0TYiBp1pICjuqGSofWpRHZaf1RyBWP6gWMAhD
bnvuKXzGYcJeMvNKmOh6w55ljawX3NYeIkNewyZKQc9YZYBJ/FvxcIu2VmmNpbXy
RiAuo6yiq1UapT2qnfebDnQ+Bjj2jsgJV317fxBB63n5js5cULrSpQnO/ZLqv4c8
41TjBjwi7WpoKwqGp8Vs4DBbv2sCkzAyqhdInUG/3NQP+uDRYR6Ysp8TLB/eUfU=
=OKzt
-----END PGP SIGNATURE-----

--fuiho1aubMFfXcAs--

--===============0735583668085094785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0735583668085094785==--

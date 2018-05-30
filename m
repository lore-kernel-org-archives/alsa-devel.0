From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fix 0-day warnings with
 snd_soc_new_compress()
Date: Wed, 30 May 2018 14:56:50 +0100
Message-ID: <20180530135650.GK6920@sirena.org.uk>
References: <20180529233002.23656-1-pierre-louis.bossart@linux.intel.com>
 <20180530031656.GL5666@vkoul-mobl>
 <4e691d48-6d09-cf2c-39f4-d3352bcf6d10@linux.intel.com>
 <s5hwovlmiy1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6292836068399413196=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F067126771F
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 15:56:53 +0200 (CEST)
In-Reply-To: <s5hwovlmiy1.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, Vinod <vkoul@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6292836068399413196==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aziWXe2aaRGlkyg3"
Content-Disposition: inline


--aziWXe2aaRGlkyg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 02:22:46PM +0200, Takashi Iwai wrote:

> Well, a good patch describes itself concisely but clearly in the
> subject line in general.  And, in this regard, whether it's reported
> by 0-day bot or not is pretty much useless.  We'd merge a fix not

Describing the source of the problem report is what Reported-by is for.

--aziWXe2aaRGlkyg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOraEACgkQJNaLcl1U
h9BUuwf8CIxRBdn7d6m8K0Ft6U9osyVsQDRUQVRBzLP4oYzt4kVSFPBY+Rlgz9Fk
UyXkjhsyAjzrsfI9qdDui12YfXRClGprh8VUQdAjDqRoN4eJavvVciTelbnLHkIX
6N+UEiAnWsU74tTDobXIPyk4WjaxQ3M9U6l+pzX9gJQOV7ls0LnX2MCgUykhUqKh
4uyAE2lcUQ/FaRKSgXPf1nusgdd06PkjRqlhkXh7TbT3P/zI2zNutVDq6FFd7o8m
CtEiE1pcW4Dh/hgdwDkiW8J6bQfaKCr5B343Ayj2ry1PKgbLyM5/avy4Ef3jFSCN
B3HL8QHGA456MpsHYMQ4j0sDmlOMIQ==
=A2KO
-----END PGP SIGNATURE-----

--aziWXe2aaRGlkyg3--

--===============6292836068399413196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6292836068399413196==--

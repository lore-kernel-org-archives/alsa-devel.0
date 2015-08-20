From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Handle multiple codecs with split
 playback / capture
Date: Thu, 20 Aug 2015 10:10:06 -0700
Message-ID: <20150820171006.GD12027@sirena.org.uk>
References: <alpine.DEB.2.02.1508191717300.27635@lnxricardw1.se.axis.com>
 <55D5F611.9090205@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3329214312104419833=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FA6426513F
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2015 19:10:19 +0200 (CEST)
In-Reply-To: <55D5F611.9090205@linux.intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ricard Wanderlof <ricard.wanderlof@axis.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3329214312104419833==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 10:45:21AM -0500, Pierre-Louis Bossart wrote:
> On 8/19/15 10:32 AM, Ricard Wanderlof wrote:

> >+		/*
> >+		 * Skip CODECs which don't support the current stream type.
> >+		 * Otherwise, since the rate, channel, and format values will
> >+		 * zero in that case, we would have no usable settings left,
> >+		 * causing the resulting setup to fail.
> >+		 * At least one CODEC should match, otherwise we should have
> >+		 * bailed out on a higher level, since there would be no
> >+		 * CODEC to support the transfer direction in that case.
> >+		 */
> >+		if (!snd_soc_dai_stream_valid(rtd->codec_dais[i],
> >+					      substream->stream))

> Maybe I misunderstood but shouldn't there be some sort of verification that
> the codecs can use the same number of slots between playback and capture if
> they share the same LRCLK/FS? e.g. it's not uncommon to have 4 mic capture
> and 2 ch playback. If the capture and playback is handled by different chips
> you'd still need to maintain some level of consistency.

Yes, this was my point about it being hard to work out what's going on
with regard to things being shared.

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1gntAAoJECTWi3JdVIfQ6gUH/1Ly8knmgyX0FNtrnxg4U9zF
/eJk/5Z5Le5u3+E1kMcbWenYbA8ToPoIZvRqLkd0fGc3sQJC0MiaxorVuaRHhw7N
+9Gnd8J+gnElOI3c2pMJ9GLuWQJjPGsO/yCMpCvdL2Rf/Fip7Jxs3WSw5+CAZ+tY
3gkdm5BSLWE5cjbnVi/Q0TJYzUGFcXrqoA7VHjP0muSGAokclEfdDIdcDVALmlee
NDF9It2aw7JrVf0WU8RsRqyHOsmFzAr9Ch3rl8HWvHxuQlx8iXTyI+B60RXaeoe0
FhRZeapUx6jSt0nfzptpCroXk9PYLJs1wQH0wEiLGU/u+VCmkQLUibFsSwvUP+4=
=iEsC
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--

--===============3329214312104419833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3329214312104419833==--

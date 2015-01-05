From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: boardwell: Drop unnecessary
 snd_soc_dapm_enable() calls
Date: Mon, 5 Jan 2015 20:12:35 +0000
Message-ID: <20150105201235.GL2634@sirena.org.uk>
References: <1420108235-30798-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4649197266660852729=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 934FB26047D
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 21:12:57 +0100 (CET)
In-Reply-To: <1420108235-30798-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4649197266660852729==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E6lVPAHcXg6biC3t"
Content-Disposition: inline


--E6lVPAHcXg6biC3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 01, 2015 at 11:30:35AM +0100, Lars-Peter Clausen wrote:
> DAPM widgets are enabled by default, there is no need to enable them unless
> they have previously been explicitly disabled.

Applied, thanks.

--E6lVPAHcXg6biC3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqvAyAAoJECTWi3JdVIfQlRwH+wRLjQt7OuPzT+C3ZgZcPkar
gxtUY/wxGAtoakRIhDcgE1IF/P2ddilMoNLHHBOCzPzhgX/gSuZSs0bZwhKVU5cL
T9fw6/tZumXDIzTiQtIrWGVfWtNL6+Y7mgu1hdQ8ggleSWrlY0FphlvbCvuHIoIl
oA1BHSq/iXclaScZx60JXjUSUL5nVRz0eq8HBiTzfTFwIKFL3i78PKzN8dB8FTOo
3K6SSBHu3F7QZYf4YRfCuoPROEHuvendc4fvRZ+iA7yZoQV+5MHnBqKttSmBCSjE
2i3iCC/Hj5BcTdYuk3WanW2iVh8WaJxNPZL+CZE4BvD6MJfIqJwTIVK+1VaXzHI=
=Szd4
-----END PGP SIGNATURE-----

--E6lVPAHcXg6biC3t--

--===============4649197266660852729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4649197266660852729==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 15/31] ASoC: omap: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 10:34:09 +0000
Message-ID: <20131106103409.GW11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-16-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6532793985184291514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D3D742625C4
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:34:12 +0100 (CET)
In-Reply-To: <1383673218-18405-16-git-send-email-tiwai@suse.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============6532793985184291514==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AFjAQ8ujNJnIGHaX"
Content-Disposition: inline


--AFjAQ8ujNJnIGHaX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:02PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--AFjAQ8ujNJnIGHaX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehseAAoJELSic+t+oim9ZjUP/1C92STYGMoihcOmoKKoJ+Q5
J1Yx4Ih126L1fUSmv7NykBoGZlgI/BiiyK0cShXnqH8lGVSCn6arBaZ+yS6K4Jyu
JHT5f4f2Lzc1tNGYX4rEe51y7F7qDgW028Dr374CERsPdf8jsoIUxiv4EYTBwLEd
eiRU8sUzJz79egOi9joNwmDBUTxTesJrNVCmlq/ynPfuQZHpMIDNQe0rTVzthd37
KR2xdc1gA5be1E3krs1qIJ9PUInS5ifhwuhWwChSNc0+VSkhXvedUfJQNjihZMh5
7hwRy3Nbj5TBGhRayuShcVmb087HJ3bFDVL+owaHfv4UD37pIChBXg2Df6fUvgiu
ObOcqsqxBlyPqJf5HDK0q6uj6pMa10+zgZxmReaiLQ+5+OVHBPzaDixVT+znfNQk
nO7+gbYTw7QFieD6VU0a9k64gdGwLuND8nkmJSGXOlQkB0C+hfdAFYZviIWmMHHx
pA0TjZAoN9PVj0Tm5uWGKGzb2I9HiJcuIrMHZIKPhiXSW/zdvcRwxVvNugGrHEKc
nt3g6X3X+d1iGadK7CUxcar5SBhJmP38gB+0jJW4n+WmkDvUr2gs2kBLmxM4hJGN
Vc4yinH/XRvLV8t0HoM4pDPKhK6ITD8HI3vUyauR/9h4jQi88l/TPjREwaU1/UlF
86BspOiawHQjoOIEgXwy
=QJxs
-----END PGP SIGNATURE-----

--AFjAQ8ujNJnIGHaX--

--===============6532793985184291514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6532793985184291514==--

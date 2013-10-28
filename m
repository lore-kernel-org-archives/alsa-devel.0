From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: DAPM: Fix uninitialized return
 value from snd_soc_dai_link_event()
Date: Mon, 28 Oct 2013 09:35:32 -0700
Message-ID: <20131028163532.GG13643@sirena.org.uk>
References: <1382966510-13075-1-git-send-email-tiwai@suse.de>
 <1382966510-13075-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1364882612962716323=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EDA1726171F
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 17:35:41 +0100 (CET)
In-Reply-To: <1382966510-13075-4-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1364882612962716323==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
Content-Disposition: inline


--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 02:21:48PM +0100, Takashi Iwai wrote:
> In a slightest path (both source and sink hw_params are NULL), the
> function may return an uninitialized value.

Applied, thanks.

--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbpJRAAoJELSic+t+oim9B4wP/0BwQbL1AayH0vqCeK1gwHgi
aufezJ4jHQpuKMJz5BVkjOO2wzORsp2/nv8qfDbtBvn2X402MozhJnhpW3TJMkB2
gNhqhZGFbj3tcley7u0V6Hz/d8P3WkwThB83g4ZbVpZ1Z47j0+CfPGb5r0wNhref
qdgDX2kDfv53s+oLF8sMSjw//tlTMoHU+IRFeV/8lj1M8eWllDG7vKqQYVG2rM5g
2EGy3m+Bl7NE7oNBa8taHXyHyanwwPC/u4Dq3vL0dvO3G23UyC4/TQcmOMn5CaN6
XsU4E2AxGTIsh8oNL02IwFlHV1x1M7FElNCn3UGuz44/yjpeWYRH0vmTFUNmTnam
f1pUXoRVkOKGv96V6MH+GePXloGceO7X7/xs2w+QmIohfBGpIPIkivoiit92O6gj
mWvUtoBcnENpzGROh6alyeBDSSPQ4V5i66vEhY72dh0e0/xvSL+6j4kCAM/HDJP0
qnU0zQVUrTgTl01xWgk7UssTZqqr7l5xnntSKMEq80N3lrLn90+CrASG0uqgkLvI
PSPIgzOZf0kY4V3US568Y2D/40E0G99F2zbU61Mupq615ZQUEdne9KHtj2vkunJy
V+YMbXwhdFVx5P2koM06rq2SNw+iUV70dM1yof3hn5/1TwpB4m/OG3KFFxCvsbvN
mYVDTEhTFiqWTjNuZqVR
=86na
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--

--===============1364882612962716323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1364882612962716323==--

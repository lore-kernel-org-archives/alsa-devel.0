From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix empty list check in
	dapm_new_mux()
Date: Thu, 1 Aug 2013 19:44:27 +0100
Message-ID: <20130801184427.GX9858@sirena.org.uk>
References: <1375374638-28305-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7957418414754568685=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B292726166B
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 20:44:36 +0200 (CEST)
In-Reply-To: <1375374638-28305-1-git-send-email-lars@metafoo.de>
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
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============7957418414754568685==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0dy43O7bf9gvZbBV"
Content-Disposition: inline


--0dy43O7bf9gvZbBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2013 at 06:30:38PM +0200, Lars-Peter Clausen wrote:
> list_first_entry() will always return a valid pointer, even if the list is
> empty. So the check whether path is NULL will always be false. So we end up
> calling dapm_create_or_share_mixmux_kcontrol() with a path struct that points
> right in the middle of the widget struct and by trying to modify the path the
> widgets memory will become corrupted. Fix this by using list_emtpy() to check if
> the widget doesn't have any paths.

Applied, thanks - looking at this I'm surprised we've not been running
into problems before.

--0dy43O7bf9gvZbBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+qyIAAoJELSic+t+oim9saEQAIxAoC4UoCQkcrg35W+9FUp9
BBHpg8Ae11hP+5FBLzs8Wm0rFdyc8rIgI8qd/KTBdOAPyR9srbl88khPWT5Y12wr
ohxkZUS3iJ7jvRidrEguf37l9Ao5+lfO7M9OpXdMBD0kLB8A7LLC+Y1aEF1Wc/Vg
YeqZDoIwBgQgWj/FrT1XXU/7FZr3ZnFRmsRXrN1zl38A5WBBdoxPd9ACkh5Cb8uv
QWIVgprsk1tjZ9lm7TLt6cWdwdhVmeN7lqMexckOdNQx+/OQGTruF3aU0vXWZpQs
N+odgJzTHYEC55g2Gtjjg4S3q2xYj72ZXRAXG3y3kfF0i4n3nQgky1UvnH/9E6nz
4bE/U+oFTcXc/qsL+HF3PLW+qL+k+Kz3oVkMCMBLU73Zbu4YHITTQrG4CQBWN2E/
g6kI760O44XzS7Gn3j7Tf/2kbk/+c9PcioFxNHJmvuXtBJFUYaY+x1zn+v9juJKL
C8fo7IV3FNTOJsDggFWJ/P2T74sIPVQcvc4ohIlKMThey604VaXZ/fy/JcLSgcSG
NPIhP36dkQ1WXNTlhfkF1LVRw0ONjAohYuXbhIS90eEKw8PhxaqYfOdn7Eohw65C
MZVyaBbNQUwsf1tXYtyDJOWYC+udLTeQnOCPG1cj7RuXWKGoCKZuavFyt3D+hKcj
WJ5FHIp4DyezZaibMirx
=bmkq
-----END PGP SIGNATURE-----

--0dy43O7bf9gvZbBV--

--===============7957418414754568685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7957418414754568685==--

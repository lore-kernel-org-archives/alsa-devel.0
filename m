From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while
 entering DAPM standby mode
Date: Thu, 3 Jan 2019 12:45:54 +0000
Message-ID: <20190103124554.GS1846@sirena.org.uk>
References: <20190102170633.GA9724@Ideapad-330S>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2726811607683114884=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC9B267B2D
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 13:45:57 +0100 (CET)
In-Reply-To: <20190102170633.GA9724@Ideapad-330S>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: b-ak <anur.bhargav@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2726811607683114884==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NKys6zTV8iyMJiwY"
Content-Disposition: inline


--NKys6zTV8iyMJiwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 10:36:33PM +0530, b-ak wrote:
> During the bootup of the kernel, as soon as the DAPM framework kicks in
> it pushes the codec into standy mode.
>=20
> The existing TVL320AIC32x4 codec driver doesn't prepare the clock in
> the probe function.
> This leads to an OOPS when the DAPM tries to put it into standy by calling
> clk_disable_unprepare()
>=20
> This patch fixes that problem.

This isn't the best way of fixing this because it makes it look like
there's a missing disable in the removal process.  What would be better
would be to do what other drivers do and check to see what state we're
transitioning from before we disable the clock in set_bias_level().  See
drivers like wm8903.c for examples.

--NKys6zTV8iyMJiwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuBAIACgkQJNaLcl1U
h9BrYwf+KCEnm5TdZGt2KnnUoIaVh4hWECHkX/qObLnXclv5IAMaPVq0Kh/BsjUe
QeAyAioFfWsaTUwvG6BFPuG2roPQhR/QP97gxE3awnbH1VvL7TfjdVgmIi76ds53
Y5MxRRCN5g8Z4QhE/13lHMiPr4DH21gizaFMy/o7Z0/o9kGLxsn1WB6JopLh6f42
KQldT7VW7zix5LElg5ATUE1J2pkljeFVMXjjw71EJQSeyFFlpg2Xjaiq3jIIjHjh
0kEeiBSnuOK3i1ZUGmu0EdUvdbdGbqUOIZEpsgCb3tKYdPLG+7GvmNs34rUZiaMq
mQm2/dA1mWJK3m6v8YSmKIlTWCz03w==
=weB4
-----END PGP SIGNATURE-----

--NKys6zTV8iyMJiwY--

--===============2726811607683114884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2726811607683114884==--

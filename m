From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sgtl5000: add avc enable control
Date: Thu, 8 Jun 2017 14:27:35 +0100
Message-ID: <20170608132735.3dgjqo7xgnys5ad5@sirena.org.uk>
References: <1496145616-9307-1-git-send-email-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3408037656855349915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 117C726681D
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 15:27:56 +0200 (CEST)
In-Reply-To: <1496145616-9307-1-git-send-email-richard.leitner@skidata.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, dev@g0hl1n.net
List-Id: alsa-devel@alsa-project.org


--===============3408037656855349915==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rpwjbr4wpwoghcag"
Content-Disposition: inline


--rpwjbr4wpwoghcag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2017 at 02:00:16PM +0200, Richard Leitner wrote:

> +	SOC_SINGLE("AVC Enable Switch", SGTL5000_DAP_AVC_CTRL, 0, 1, 0),

This should just be AVC Switch.

--rpwjbr4wpwoghcag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk5UMYACgkQJNaLcl1U
h9AIHQf/Wy2N0Px4DJp3htnIPxulMaH4iBkbbwFH7gAHeupO1p8uJlA+x41hZPC9
kWadpynbQGcFaby7HTFmnf5RYgWHMtGoQc4ZFd4uBxgVXqyXdWM/w3lNSnw2Rquc
iNVgW8r+khnzGS59uNYkIuUkWhniTlhrvQJ1egyCGha4jQG6LYjEHmsU+q0lEz1y
ExUp9X7RlUzi8lKc/MfinOosesWyxLoDW1ZlNzLWf80u1DqxBo2XeVGiFgdzzR9W
ME6+zjjM4JcaqVdQUdJlZNAYqWtKo68MlYhHmgo62ZNcerVFG74eA0HhxepvLcdM
pISuaTRN8EwTNVpuPgO9CFaqT+dOjw==
=BvQP
-----END PGP SIGNATURE-----

--rpwjbr4wpwoghcag--

--===============3408037656855349915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3408037656855349915==--

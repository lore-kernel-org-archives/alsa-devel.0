From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Date: Mon, 18 Jun 2018 12:06:42 +0100
Message-ID: <20180618110642.GA6928@sirena.org.uk>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4619413241370421179=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D1D782673C7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 13:06:52 +0200 (CEST)
In-Reply-To: <20180614111138.8923-6-niklas.cassel@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4619413241370421179==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
> of_platform_device_destroy is only defined when building
> with CONFIG_OF=y. Add a depends on OF.

Is it sensible that of_platform_device_destroy() is only defined when
building with CONFIG_OF=y?

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsnkj4ACgkQJNaLcl1U
h9AVVwf/VkuPxov3tJzTawHKXw0n000NRSxme0b13/p1sM5sEOLHLsj+tCaYPfy/
TsY0kHTJ6NDmr9YRm/vFbDRxUc19/6LAH021VsFrg3kz0mH/fNgifFfbYxoIjCCf
2YyW5Ei1SLVFARQIN9BiphjwsZL6i/aEKlg7Q7b95OjVnA2/E/fh3ZGMhrUQ17t/
HhCaw1EQ9yqhefxtCD8meRFZbrYrIT2tWIxZuXA/cBQplR8HIOu9NcUD7Pz+rJcO
b1bwNTAEDfG8KSOZTTcTuASrumJLze1gOi6RVoQlSidG30ya3regKB4sJ0VndECL
+JUXsvVr/HCOHFsS+rYWIzV0rWtpFA==
=ATMi
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============4619413241370421179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4619413241370421179==--

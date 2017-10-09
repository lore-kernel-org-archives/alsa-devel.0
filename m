From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH] ASoC: codecs: msm8916-wcd-digital:
 fix RX2 MIX1 and RX3 MIX1
Date: Mon, 9 Oct 2017 09:31:47 +0100
Message-ID: <20171009083147.iwugpdgx2zcw6fyu@sirena.co.uk>
References: <20171006180951.10930-1-jean-francois.tetu@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6341850272212641587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 057B8266BFD
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:31:50 +0200 (CEST)
In-Reply-To: <20171006180951.10930-1-jean-francois.tetu@savoirfairelinux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Jean-Fran=E7ois_T=EAtu?= <jean-francois.tetu@savoirfairelinux.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============6341850272212641587==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ehfcq6c3tkzpaq2n"
Content-Disposition: inline


--ehfcq6c3tkzpaq2n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 02:09:51PM -0400, Jean-Fran=E7ois T=EAtu wrote:
> The kcontrol for the third input (rxN_mix1_inp3) of both RX2
> and RX3 mixers are not using the correct control register. This simple
> patch fixes this.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--ehfcq6c3tkzpaq2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnbM/IACgkQJNaLcl1U
h9Bk0gf45+DiGrEC341snu2y0LwL609OjIITvbzqJLELvtgicKweAoBQK2FgNNRE
axtf+WbbdZYJvSBSh672ehTIICRopSQrh1OrrXcYEWjoeY4XptOYGE9K911mCKJk
L8ZyYv065GTE0EUg/vlM1E/G7A9lqKqeGR9OtlB/e+InmA8wmjRJ0B6cFyTOSFlt
pZrShVQWU4P2oCmEZOFJiJ9cn+s3cJac9+b4kq0k1oIcdUoykt3AAxLxwCd4DLAa
Srq5P9raGd4a/nhwmwRFY80+2v3dA2VGfbq24K41/18N5wEr7FrwSF7rxMlkWISG
9+rDvR+cggBwsfnoQGEGNC22lvYn
=BXgY
-----END PGP SIGNATURE-----

--ehfcq6c3tkzpaq2n--

--===============6341850272212641587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6341850272212641587==--

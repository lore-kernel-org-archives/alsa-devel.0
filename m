From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: alc5632: Cleanup bias level
	transitions
Date: Mon, 24 Nov 2014 18:06:52 +0000
Message-ID: <20141124180652.GR7712@sirena.org.uk>
References: <1416746872-11513-1-git-send-email-lars@metafoo.de>
 <1416746872-11513-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4312913540843610850=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 304D2260A5D
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:08:56 +0100 (CET)
In-Reply-To: <1416746872-11513-2-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4312913540843610850==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qXPE+6hUsFlDAc0e"
Content-Disposition: inline


--qXPE+6hUsFlDAc0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:47:51PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--qXPE+6hUsFlDAc0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3O7AAoJECTWi3JdVIfQmpcH/iRsFDXbjCDpJbZFzacWo938
qXFt+ilVw5MpGwZC55u3hZZcrGpHnKqb4ymKW9MQ56b9JNpv3KnKKOIDYpsTDFmG
h0QaWhsrcn5XEhx38txZM/F5QVZv1U/h0F3XSTye+Mk3osSPtUPKHLtfu18d4ba0
A9SitUErgzOiPSzGtsP0yH3ydpmy+chLKPhu0fqgFC6e/TXofwDsOGoHizdxmySf
CYYzdFL6d/FYAxO2bQpG8CBRm3WH/u+PK81DX53K5uM0Huy2o3lil12sNCAG12tu
ZK3e+XJZ3laZpe0bI3h7nLasm1APO2yRt6VXcmdn+VVPVnRLnM+QtrnDOBFkWOE=
=1Hcb
-----END PGP SIGNATURE-----

--qXPE+6hUsFlDAc0e--

--===============4312913540843610850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4312913540843610850==--

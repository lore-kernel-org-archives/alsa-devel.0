From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: Use the local variable to
 get the data from SPI device
Date: Fri, 21 Jul 2017 11:51:05 +0100
Message-ID: <20170721105105.4lsehuw6an7oclqd@sirena.org.uk>
References: <1500624047-21492-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8080874254604987608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FB5326750A
 for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2017 12:51:13 +0200 (CEST)
In-Reply-To: <1500624047-21492-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8080874254604987608==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rfrjxuucjkrpe47l"
Content-Disposition: inline


--rfrjxuucjkrpe47l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2017 at 04:00:47PM +0800, Oder Chiou wrote:
> The patch uses the local variable to get the data from SPI device to
> prevent to get all zero data.

How do you end up with all zero data from reading directly into rxbuf?

--rfrjxuucjkrpe47l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllx3JgACgkQJNaLcl1U
h9AK1Af9H2+giDk1uOm9ywI3XpYUnCZ2uV0qkhdM3bGSd/AqQ2WY6NtjlBWl7Tv7
Pg00mPkYlkV476hdiNDCnItJlYb31OsENGw3qlVE/4/lkPZxDvLB9LeuUJs92g0k
2GXXgndbDnvkO62WglFonfHdyiApnuDzosGJ9xHfYSgbhJEZ+MrzMM/lA23gZn5u
0TxfKAf99n/qBoW0rfWfvRkJyoScuxV5r1xwvqiiChKMM5DwMvNACR/1VX0oey9B
LI8P0zu4XCTt9mAuOU5b7YFgiXQAEx/McjJ+kSCBj/oYKvgHg9+F2GWgT2sHhAuo
djSNuQ4dCCS0aS4+/OW/fqJldzrCoQ==
=iZD4
-----END PGP SIGNATURE-----

--rfrjxuucjkrpe47l--

--===============8080874254604987608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8080874254604987608==--

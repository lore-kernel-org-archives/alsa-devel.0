From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: fix the DAPM routes map
	parsing
Date: Mon, 6 Jan 2014 15:37:15 +0000
Message-ID: <20140106153715.GZ31886@sirena.org.uk>
References: <1388986906-32139-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7424701221852765452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76FDD2610B7
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 16:37:22 +0100 (CET)
In-Reply-To: <1388986906-32139-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7424701221852765452==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKxMeUgs2YHnbgRP"
Content-Disposition: inline


--TKxMeUgs2YHnbgRP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 01:41:46PM +0800, Xiubo Li wrote:
> The simple-card's DAPM route maping is optional. For example, the spdif has
> no need of this.

This doesn't seem to apply against current code, can you please check
and resend?

--TKxMeUgs2YHnbgRP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSys2oAAoJELSic+t+oim9jDQP/04lsa/nZ5ocRvhAF82oxeWf
FpwS8R3s554lbmtGJciZBTgDcJc58Mby5lYhjwbcAahqVeFi8vdnbfZhj7J5RVpP
8SKA4ufNc5QmQzMN3xvFsL42zIWZF9d3+hXYd5Iz4TbGJy9O03S0l2SqNBv8RWAu
t8qxtnnYpUPAL0VoK76laOOlNf8kZf7qOLZ+D8Pm4afCJYjZtGDOtszDJ5aPJSdP
Dtsf2BP5Xpu4yh/YwXsnGH5KLA8oqFKoQAGmxEDiARGXxXhVLCCQR15ujjh++dH7
o0ABlaE23fsvVqej2ztvnuQFo6mB2UvfppxpQQqwmnP3p2yW4Pzp97/dqT3j4UcE
ccwdurzym1PS7ceIIbCSbVpX0XMAIgRZfPbVqEjs2OKL8eAfzBYeDfXoxwq/dMPy
BsGZcGJ7d2LOcp2KKW02686wGjUqBgdT/7xnAWnYlBjQYx5IHHW8hA5s0pEAEwAu
W6H5wiK+EYH3p/82Ew+6HowA2hvcOgez3IWAcKhKPWtmErsX1qgabBYwfDpVi95k
7f8+iSav96EvvIiq8+XT0kCFxvJiIbK/7fwv+71tVkpHNi+6KV3MsS0qPx1O9bVq
QSUTMPIBfeRTSHF3RW46ahagBAXePjYTkfq0oAiX1z4vTQXSmS7jpPckqBox3cuR
2vn64W5y9oBVW9UPSO5x
=+bUx
-----END PGP SIGNATURE-----

--TKxMeUgs2YHnbgRP--

--===============7424701221852765452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7424701221852765452==--

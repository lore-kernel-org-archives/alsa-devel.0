From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: 88pm860x: Replace direct
 snd_soc_codec dapm field access
Date: Mon, 11 May 2015 17:31:18 +0100
Message-ID: <20150511163118.GP3458@sirena.org.uk>
References: <1431330156-16706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4222323728730063191=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38D77264F53
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 18:31:37 +0200 (CEST)
In-Reply-To: <1431330156-16706-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Rongjun Ying <rongjun.ying@csr.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org


--===============4222323728730063191==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LpcCHpaCAbC4X43d"
Content-Disposition: inline


--LpcCHpaCAbC4X43d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 09:42:26AM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct is eventually going to be
> removed, in preparation for this replace all manual access to
> codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Applied all, thanks.

--LpcCHpaCAbC4X43d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUNlVAAoJECTWi3JdVIfQwHoH/0jgMDQdYWJ0HFrkU8dEs95H
NNdewHUmz/pruRCkXnC4/UgerP7gEBbJBS+Kj8rT8f3rs3pVTGF0M3Hc4jNwYx73
/ZkFEHU3254qwLwuBrUqfROxDT1XfIFT8G/dd4vfdvO+IrzQcYjD3InRfEyBY3DC
ARsEFhAV9D3wSOGAIac/X7g004CIWM+9y6RknpkCl1wuW2k18Ibna8uEvLLd8HTh
BiWdfiOBGQBMNj7S0W+JRJIVMN+pSNJY7p0BWIQ0tWOEn+zkmH1iJaa7lSfrCAQR
JeriaRmt7TseThJBp01FntNIXIcOAXseoq/ENZ6MPgo9cSYugtFvJRg9kQzEYlI=
=YyeM
-----END PGP SIGNATURE-----

--LpcCHpaCAbC4X43d--

--===============4222323728730063191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4222323728730063191==--

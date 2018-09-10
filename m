From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: AMD: Fix simultaneous playback
 and capture on different channel
Date: Mon, 10 Sep 2018 12:38:20 +0100
Message-ID: <20180910113820.GD5856@sirena.org.uk>
References: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6928417734714745501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AE5372676ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 13:38:24 +0200 (CEST)
In-Reply-To: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============6928417734714745501==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 01:36:29PM +0530, Akshu Agrawal wrote:
> If capture and playback are started on different channel (I2S/BT)
> there is a possibilty that channel information passed from machine driver
> is overwritten before the configuration is done in dma driver.
> Example:
> 113.597588: cz_max_startup: ---playback sets BT channel
> 113.597694: cz_dmic1_startup: ---capture sets I2S channel
> 113.597979: acp_dma_hw_params: ---configures capture for I2S channel
> 113.598114: acp_dma_hw_params: ---configures playback for I2S channel
>=20
> This is fixed by having lock between startup and prepare. This ensures
> no other codec startup gets called between a codec's startup(where channel
> info is set) and hw_params(where channel info is read).

This isn't viable - the driver will deadlock if the application hits an
error and never gets to startup, or if the application tries to
simultaneously configure two channels (ie, do all the prepares and then
all the parameter configuration and then startup).  The DMA driver needs
to remember the configurations for the different channels separately.

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWV6wACgkQJNaLcl1U
h9CujQf/dW83AWCa4lWvkfHryxAKuYFIxv1USSFz30+0uzXDmLTxOt3ZRu4D8gVW
i1Is4Fk5sY2zj0HXU0DH4PPA+NSnpoUg7IHa3aI8hzmkIiKtKP2ZH3Q6EVjZChgS
bf/isOGQ01RJl/QNFZ2u393l9C4ZX5i7EgYQI2PwCdt9DzgbyFGgvYIcs4Ac2eLF
tgeEHq8N0qvl4W3Q2NT6s+fBaxIYqHzNHZIE/jvMgTccM38J7YhK+OvPdjmsnwtW
ukPoZxjEfMYvhA574ApIpwONMmRwsB9YfmAK7vXE0S3nLSTWZC9ftDXOtRG5HwZC
b96+fJx6o07IHeQ1Mwu4lRv5drDXEA==
=sbh/
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--

--===============6928417734714745501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6928417734714745501==--

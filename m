From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH V2 1/6] ASoC: davinci: davinci-pcm does not
 need to be a plaform_driver
Date: Wed, 29 Aug 2012 10:25:34 +0400
Message-ID: <20120829062534.GB11919@newmaster.mivlgu.local>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-2-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0014219327172838928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mivlgu.ru (mivlgu.ru [195.20.195.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 36961264F11
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2012 08:25:40 +0200 (CEST)
In-Reply-To: <1346074004-22172-2-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-user@lists.sourceforge.net, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0014219327172838928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2012 at 06:56:39PM +0530, Hebbar, Gururaja wrote:
> Same as the commit 518de86 (ASoC: tegra: register 'platform' from DAIs,
> get rid of pdev). It makes davinci-pcm not a platform_driver but helper
> to register "platform", so that the platform_device for davinci-pcm can
> be saved completely.
>=20
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> ---
> Changes from V1:
> 	- New Commit. Instanciate seudo-device (davinci-pcm) directly from DAI
> 	  driver rather than having a separate virtual-device registered
>=20
> :100644 100644 c80c20a... 4b37e2a... M	sound/soc/davinci/davinci-evm.c
> :100644 100644 0a74b95... 407df72... M	sound/soc/davinci/davinci-i2s.c
> :100644 100644 6a2c54c... 34ee2f1... M	sound/soc/davinci/davinci-mcasp.c
> :100644 100644 97d77b2... 4b70828... M	sound/soc/davinci/davinci-pcm.c
> :100644 100644 c0d6c9b... 5e55164... M	sound/soc/davinci/davinci-pcm.h
> :100644 100644 f71175b... 5be65aa... M	sound/soc/davinci/davinci-sffsdr.c
> :100644 100644 da030ff... 07bde2e... M	sound/soc/davinci/davinci-vcif.c
>  sound/soc/davinci/davinci-evm.c    |   15 ++++++++-------
>  sound/soc/davinci/davinci-i2s.c    |   10 ++++++++++
>  sound/soc/davinci/davinci-mcasp.c  |   10 ++++++++++
>  sound/soc/davinci/davinci-pcm.c    |   23 ++++++-----------------
>  sound/soc/davinci/davinci-pcm.h    |    3 +++
>  sound/soc/davinci/davinci-sffsdr.c |    2 +-
>  sound/soc/davinci/davinci-vcif.c   |    8 ++++++++
>  7 files changed, 46 insertions(+), 25 deletions(-)
>=20
> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-=
evm.c
> index c80c20a..4b37e2a 100644
> --- a/sound/soc/davinci/davinci-evm.c
> +++ b/sound/soc/davinci/davinci-evm.c
> @@ -159,7 +159,7 @@ static struct snd_soc_dai_link dm6446_evm_dai =3D {
>  	.cpu_dai_name =3D "davinci-mcbsp",
>  	.codec_dai_name =3D "tlv320aic3x-hifi",
>  	.codec_name =3D "tlv320aic3x-codec.1-001b",
> -	.platform_name =3D "davinci-pcm-audio",
> +	.platform_name =3D "davinci-mcbsp",
>  	.init =3D evm_aic3x_init,
>  	.ops =3D &evm_ops,
>  };
> @@ -170,7 +170,7 @@ static struct snd_soc_dai_link dm355_evm_dai =3D {
>  	.cpu_dai_name =3D "davinci-mcbsp.1",
>  	.codec_dai_name =3D "tlv320aic3x-hifi",
>  	.codec_name =3D "tlv320aic3x-codec.1-001b",
> -	.platform_name =3D "davinci-pcm-audio",
> +	.platform_name =3D "davinci-mcbsp.1",
>  	.init =3D evm_aic3x_init,
>  	.ops =3D &evm_ops,
>  };
> @@ -184,14 +184,15 @@ static struct snd_soc_dai_link dm365_evm_dai =3D {
>  	.init =3D evm_aic3x_init,
>  	.codec_name =3D "tlv320aic3x-codec.1-0018",
>  	.ops =3D &evm_ops,
> +	.platform_name =3D "davinci-mcbsp",
>  #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
>  	.name =3D "Voice Codec - CQ93VC",
>  	.stream_name =3D "CQ93",
>  	.cpu_dai_name =3D "davinci-vcif",
>  	.codec_dai_name =3D "cq93vc-hifi",
>  	.codec_name =3D "cq93vc-codec",
> +	.platform_name =3D "avinci-vcif",

Typo?

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD8DBQFQPbXeW82GfkQfsqIRAnQVAJ4icoBpoX8wTeh6eY7TbztZ6ytZiwCdGURZ
4lVnzGOGR7KOvesX8Crwues=
=1r94
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--

--===============0014219327172838928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0014219327172838928==--

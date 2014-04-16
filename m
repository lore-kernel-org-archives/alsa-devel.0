From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/18] ASoC: omap-mcpdm: Assign the dai DMA
 data at earlier time
Date: Wed, 16 Apr 2014 11:15:35 +0100
Message-ID: <20140416101535.GQ12304@sirena.org.uk>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
 <1397640211-15447-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0874115311053360288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9E1A2650CE
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 12:15:53 +0200 (CEST)
In-Reply-To: <1397640211-15447-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0874115311053360288==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHwaWyh5/fUA7Dm/"
Content-Disposition: inline


--wHwaWyh5/fUA7Dm/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2014 at 12:23:15PM +0300, Peter Ujfalusi wrote:

> -	snd_soc_dai_set_dma_data(dai, substream,
> -				 &mcpdm->dma_data[substream->stream]);
> -
>  	return 0;
>  }
> =20
> @@ -406,6 +403,10 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
>  	mcpdm->config[SNDRV_PCM_STREAM_PLAYBACK].threshold =3D 2;
>  	mcpdm->config[SNDRV_PCM_STREAM_CAPTURE].threshold =3D
>  							MCPDM_UP_THRES_MAX - 3;
> +
> +	dai->playback_dma_data =3D &mcpdm->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
> +	dai->capture_dma_data =3D &mcpdm->dma_data[SNDRV_PCM_STREAM_CAPTURE];
> +

Any reason to stop using _set_dma_data()?

--wHwaWyh5/fUA7Dm/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTlhEAAoJELSic+t+oim9wcEP/i/5OV30GPSYYQUWN/5alhCs
v9ebNrcMFRR72H70UGBEiMk6SW+4Hz4M1dwo1VHrqohPBmvxVx5H1hFq/+Cq7XMY
4IGH5ZL8Kye5OH0Z+7Vs+yOgZ+1DZ+7u/41YCsjJnXID2j/RuPVY8PYawPoCSOLf
3eHDHB7nZkz0iu4lvZi2mVQOzA+mCxOV+3K2aN42q0Qi2CuM5c9mv2UglR/5RaiV
JJc5WurWJqq3lrvaXBKm+4xjzNF2Wb/SevpLfOUTvKvx/ybwbva1n3+NAwU9ytI7
IFQ7g4C/pzTiiU7YjszMjzsVfEWghmbYVYY6YCxOMeCc16D5iVgCDLQb9Rf3xqeZ
0uFSrZt+JE41VeFQfadSBUaHgyrTJ/BlKLaicXaJ0YIAzSVFrilYvH7Hi4Mi1vKw
SnvzXyK5aOKm43L45UAzZJkM4mao/p34UhaKV26BtYg1YjxNqAHxxAV/mPd1GE+8
dcMx1j9vdBxW+906ilIE8Tg1r82E7zHJXEoOpUkwuhnmTbgtp3IE/oXSNlQY6tBJ
f6y8UL11uXp8mkpCgmjkfcvX0LpYpuvbYLAt6zQqIHG4tTZ9Vhnstqsta9EjZb+r
np5HcIqn3gMgqWtm5TKhHavKG6OuAMEocAxr7fxVbav1XnxHBsp9nXT1mnRwBiih
YdW2d7zIu5Axk5F80LYt
=K0RV
-----END PGP SIGNATURE-----

--wHwaWyh5/fUA7Dm/--

--===============0874115311053360288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0874115311053360288==--

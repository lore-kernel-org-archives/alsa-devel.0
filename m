From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: fix dpcm_path_get error
	handling
Date: Wed, 10 Sep 2014 10:41:08 +0100
Message-ID: <20140910094108.GM2601@sirena.org.uk>
References: <1410335852-29957-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0806344491625062785=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 035BA26109E
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 11:41:39 +0200 (CEST)
In-Reply-To: <1410335852-29957-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: vinod.koul@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0806344491625062785==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ScurbD2uZQjqtPeh"
Content-Disposition: inline


--ScurbD2uZQjqtPeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 03:57:32PM +0800, Qiao Zhou wrote:
> dpcm_path_get may return -ENOMEM when allocating memory for list
> fails. We should not keep processing path or start up dpcm dai in
> this case.
>=20
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
>  sound/soc/soc-compress.c |    7 +++++--
>  sound/soc/soc-pcm.c      |    7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 27c06ac..b969a13 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -101,10 +101,13 @@ static int soc_compr_open_fe(struct snd_compr_strea=
m *cstream)
> =20
> +	ret =3D dpcm_path_get(fe, stream, &list);
> +	if (ret < 0) {
> +		mutex_unlock(&fe->card->mutex);
> +		goto fe_err;
> +	} else if (ret =3D=3D 0)
>  		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
>  			fe->dai_link->name, stream ? "capture" : "playback");
> -	}

If one side of an if statement has braces both sides should have braces.

Otherwise this looks good.

--ScurbD2uZQjqtPeh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEByxAAoJECTWi3JdVIfQ6LYH/icjUwgF1zwsxVh78/gvwHFD
VcjaSBjj3sysG9BWrTsScm6QHFjAbZAc0/mTcxmFcizPP7HqwMs1x6VFKVdi1tgy
GSDbSNl5EcpIa5X1gneHDklIyYlPfnRzcuNho2awW8hV13Omknt6rIxmo9GVtxdl
1BVsudKz3Uzb44icFjQIE4OJmlXa3xxSy+vxZ7T6BtnZ1XeJ4NlVEzlqFb75pQ5/
K3CFSRFwk4ycYQ0uH57gdkTAiSdBUGInAcPExwlplOjz4b8pCWHuAtChY+W518lF
2lKXdrl8Ac1DrenlNRfp46JfGkGT3nKXjlpFEoKbTZ8uh4mINnEleUPLD7a4fo8=
=ZYXW
-----END PGP SIGNATURE-----

--ScurbD2uZQjqtPeh--

--===============0806344491625062785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0806344491625062785==--

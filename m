From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH 2/5] ASoC: Intel: Headset button support in
 broxton machine driver
Date: Thu, 5 Apr 2018 17:30:33 -0700
Message-ID: <20180406003033.GA234162@decatoncale.mtv.corp.google.com>
References: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
 <1522817219-3750-3-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7724578310742334871=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 80BD02672B2
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 02:30:38 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id y66so9618100pfi.7
 for <alsa-devel@alsa-project.org>; Thu, 05 Apr 2018 17:30:38 -0700 (PDT)
In-Reply-To: <1522817219-3750-3-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, harshapriya.n@intel.com, broonie@kernel.org, bleung@google.com, bleung@chromium.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7724578310742334871==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Naveen,

On Wed, Apr 04, 2018 at 10:16:56AM +0530, Naveen Manohar wrote:
> Patch adds headset button support for broxton machine driver
> (bxt_da7219_max98357a).
>=20
> Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> ---
>  sound/soc/intel/boards/bxt_da7219_max98357a.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/in=
tel/boards/bxt_da7219_max98357a.c
> index ce021a3..1c1e70c 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -16,6 +16,7 @@
>   * GNU General Public License for more details.
>   */
> =20
> +#include <linux/input.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <sound/core.h>
> @@ -168,6 +169,7 @@ static int broxton_ssp_fixup(struct snd_soc_pcm_runti=
me *rtd,
>  static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	int ret;
> +	struct snd_soc_jack *jack;
>  	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>  	struct snd_soc_component *component =3D rtd->codec_dai->component;
> =20
> @@ -192,7 +194,12 @@ static int broxton_da7219_codec_init(struct snd_soc_=
pcm_runtime *rtd)
>  		return ret;
>  	}
> =20
> -	da7219_aad_jack_det(component, &broxton_headset);
> +	jack =3D &broxton_headset;
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);

I recently made a set of changes that replaced KEY_MEDIA usage for BTN_0
with KEY_PLAYPAUSE. See https://lkml.org/lkml/2017/11/22/586

Since this patch may be destined for Chrome OS, you should definitely use
KEY_PLAYPAUSE, as the Chrome OS user space doesn't respond to KEY_MEDIA but=
 does
respond to KEY_PLAYPAUSE.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlrGv6kACgkQHwn1ewov
5lhZPBAAuMLbv1gz45XNiaPOFIdWxAwl2vK//bugSUNJkCUjUgJTdbCV/MgDudsF
TaYEyNjDEGJ3aCZ7hJtJOz7jP+SRCGNFumlF+bnmpGKLJ73FI1HwLlQvJ5MElCGE
vsaLPHbFa26iHKz8PPuVKJFVFGj3GECtjIT93DkKRjJdqS8qRQcJkrYhI3ZDXDM5
dAl3dN+/7nREleCI9ACYf0BaL0ekX8YdIrejClwkyNL7bcEiRu8ivKMnV2hXq3sE
u1SXecY1i2zsxB9kUVcJ/F3W5KmcqkzGAiYvDtJgEHEeprnsyJ0inXZkvZApiQWS
kuV05m7lII0FIL+P9j1n1u1+5qw8zg+AiOJixp8r/8VAvYIpMiZTpMyuKQngI15X
0CO9OQXg8Ucf0WdmpNO9IAnIRBx+zctdxvCeKZYF8nzAr4wQ9aTQPw5GeybssI45
WahipcetQ52y/+NFv2Q1y+swcsT6zNhIjTAwHJVg8hkY+w54TLtAaqqa7e3FALlp
btjkzvb93avkKzCC9oPibnvUta5LSWfbBcaE5i/dCMNe7P3bDEP7bMel8RBoHzcO
Jud3CStBN2i3BkMZ6h7PwHDMLx8NVYVPoAWBNZ50Yq6FrfE0IyNXJLFrnmvmcl71
BLRtQJC3ftMo0g2rpACNHtlQGn2sEcjZ6mE+JmUY8Db0EC0zgxI=
=Rmnc
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

--===============7724578310742334871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7724578310742334871==--

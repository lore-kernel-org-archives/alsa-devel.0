From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5645: Fix potential crash in
	jd function
Date: Tue, 25 Nov 2014 12:11:21 +0000
Message-ID: <20141125121121.GS7712@sirena.org.uk>
References: <1416300619-14334-1-git-send-email-bardliao@realtek.com>
 <1416300619-14334-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5121829566824644322=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 905BD265713
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 13:13:23 +0100 (CET)
In-Reply-To: <1416300619-14334-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5121829566824644322==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XFkHhpX+zY/pUGhI"
Content-Disposition: inline


--XFkHhpX+zY/pUGhI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 04:50:19PM +0800, Bard Liao wrote:

> @@ -2209,6 +2209,10 @@ static int rt5645_jack_detect(struct snd_soc_codec=
 *codec)
>  	int gpio_state, jack_type =3D 0;
>  	unsigned int val;
> =20
> +	if (!gpio_is_valid(rt5645->pdata.hp_det_gpio)) {
> +		dev_err(codec->dev, "invalid gpio\n");
> +		return 0;
> +	}

It's not obvious that we should be returning 0 here - shouldn't we be
returning an error?  After all an error message is being displayed.

--XFkHhpX+zY/pUGhI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdHHoAAoJECTWi3JdVIfQN6UH/13SOKE0cEc1/LRsZ308+HBF
PV+DcXwZC51JtSov0aFp1MvsrsCrlnnaEHojBZhOKPx+nANn/J+60+EusA9SwKSZ
uQSlLnBAFbWf3dFiABqBNq3sSh02w4khqqHi6fzU0GkXVybzzLLJ/D1bvPKh015H
hHeI5sREcbAB1/TWp54fEpw4yb6bXyWZlwBTJtKsplLdXBJkNUy4NHLkiubHWpg3
UEXGJb4KT60CazScgNgzHiq6iL1buTSW6LP5UAuEDu9CmrKMZQuSwBnNDVD4SbQP
Xrte13XtgXXhO4UzUkl8CGz+MyLu+NCgO9YKn2E4ZYVy6AI1vNHW5fGhBGLNBAw=
=DC2B
-----END PGP SIGNATURE-----

--XFkHhpX+zY/pUGhI--

--===============5121829566824644322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5121829566824644322==--

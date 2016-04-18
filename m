From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: jack: Add a jack detect callback via codec
Date: Mon, 18 Apr 2016 12:46:18 +0100
Message-ID: <20160418114618.GW3217@sirena.org.uk>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-2-git-send-email-zhengxing@rock-chips.com>
 <20160418092218.GL3217@sirena.org.uk>
 <5714AC57.2070901@rock-chips.com>
 <20160418095302.GN3217@sirena.org.uk>
 <5714B0D4.7080506@rock-chips.com> <5714B4D0.90406@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2117475018483497329=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <5714B4D0.90406-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============2117475018483497329==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sBvc846/5FzkyDmz"
Content-Disposition: inline


--sBvc846/5FzkyDmz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 06:20:00PM +0800, Xing Zheng wrote:
> On 2016=E5=B9=B404=E6=9C=8818=E6=97=A5 18:03, Xing Zheng wrote:

> sound {
>         ......
>         simple-audio-card,dai-link@0 {
>             format =3D "i2s";
>             cpu {
>                 sound-dai =3D <&i2s0>;
>             };
>=20
>             codec {
>                 sound-dai =3D <&codec>;
>=20
>                 simple-audio-card,codec-jack =3D
>                     "JACK_HEADSET",
>                     "JACK_BTN_0",
>                     "JACK_BTN_1",
>                     "JACK_BTN_2",
>                     "JACK_BTN_3";
>             };
>         };

This seems like it's only half the job and worryingly close to Linux
internals.  In particular the fact that the binding is specific to
simple-card and the fact that it's being placed on the CODEC (rather
than a separate object that the CODEC references) so that we can't
combine multiple devices are both a concern.

Dylan Reid did have an earlier go at defining a binding for this:

  http://thread.gmane.org/gmane.linux.alsa.devel/138906

which went through a couple more iterations but the work on that seemed
to die off a bit.

--sBvc846/5FzkyDmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFMkBAAoJECTWi3JdVIfQH0AH/3ypMTUXER81aRHuLarRyLOC
38qbLWrsX5NYWt+JNAynYnJo5xAV2GxW1DLW6reQZT6b+kK7ZrZk9iygXFHWisAZ
m/9NwvedmGxgKPdF0bp3bsxHp2YQg9bj+p6c3XLbkr1dIhmP0/M5c/HATbxJZFKh
B9GIW0zwBBLm1peEtBdAYKCeklzVczOa4OiCgAdWwJeNWwjCCuzGxwnheiX4i77i
sYG6oVPyfLwAR4uGmLGesjYsLMY/dUrWQR5KkskzILgbrrcnE+T6Gogmmk5mrJyw
WP6DkYXgrSK1X/spbcmsL195epnCYtxBS9ZJxiE3miZR9DJjWoZh40iYFFmrazk=
=J3vv
-----END PGP SIGNATURE-----

--sBvc846/5FzkyDmz--


--===============2117475018483497329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============2117475018483497329==--

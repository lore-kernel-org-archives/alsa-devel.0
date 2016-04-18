From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: jack: Add a jack detect callback via codec
Date: Mon, 18 Apr 2016 10:53:02 +0100
Message-ID: <20160418095302.GN3217@sirena.org.uk>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-2-git-send-email-zhengxing@rock-chips.com>
 <20160418092218.GL3217@sirena.org.uk>
 <5714AC57.2070901@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3798963268299913748=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <5714AC57.2070901-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============3798963268299913748==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fpolVoprVozDR81Y"
Content-Disposition: inline


--fpolVoprVozDR81Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 05:43:51PM +0800, Xing Zheng wrote:

> The patch_1/3 add an export of a function that calls the _detect_jack_
> function
> when a codec supports jack detection and fill the _detect_jack_ function in
> the
> struct snd_soc_codec_driver.

But why would anything ever call this function?  How is this supposed to
be used?

--fpolVoprVozDR81Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFK59AAoJECTWi3JdVIfQoIkH/11rNOsK3IY82eHAhlPRvn4c
qZPm1puFWdfye0GlLf/hkzuXAj2yX/IDiUoOsKo8tqG3hl01+34dMLrpbwK2yzJV
OOW//DGzsBAhg4aDWJ9XYs5cF7eHDcici/mwavcUASJ4AaxyxcPAIelGMub52E35
AAJiseqfVg+tGbkRjfwNA+jJJ3TrzZ+jwbgjGVYDlXM1IIt6dPcaxFjzd+nsoSuf
Qn3ZqvAf2/YYHIZL30ih0WDQx6fC+kngRdrZe6TB1I06exLAtXwdwQ3X3+NUtejf
HsX1rHKU4TChVb9X3J0msPlDh09ykK+U1pQqTqlIryW3wUOrk/u8WkdWp02f4Vw=
=KI4t
-----END PGP SIGNATURE-----

--fpolVoprVozDR81Y--


--===============3798963268299913748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============3798963268299913748==--

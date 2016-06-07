From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
Date: Tue, 7 Jun 2016 17:31:12 +0100
Message-ID: <20160607163112.GD7510@sirena.org.uk>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-7-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7151570596178392062=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1464929784-5489-7-git-send-email-garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ir.lian-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, PC.Liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============7151570596178392062==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h+CsNYkJBPxpZ+B/"
Content-Disposition: inline


--h+CsNYkJBPxpZ+B/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 03, 2016 at 12:56:21PM +0800, Garlic Tseng wrote:

> +	if (val < 0 || val > MT2701_I2S_NUM) {
> +		dev_err(afe->dev, "%s, num not available, num %d, val %d\n",
> +			__func__, num, val);
> +		return -1;

Real error codes please.

> +static const struct snd_kcontrol_new mt2701_afe_multi_ch_out_asrc3[] = {
> +	SOC_DAPM_SINGLE_AUTODISABLE("Multi ch asrc out3", PWR2_TOP_CON, 7, 1,
> +				    1),
> +};

On/off controls should end in Switch.

--h+CsNYkJBPxpZ+B/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVvbOAAoJECTWi3JdVIfQwO4H/2/Vxs4bhRSEKO9Zi2dClEyu
msdJ3HJ3QMXc7tg5LuWnznKJ9EYib5jbENaY/SSQ/946tWXJZg/8+RkYMEcmANct
IqRAPqn6NCeOu9Eq86e8NYnxfT+6WLS5ymFIv6k6g2BNGRCCpkj7WNfPhbUYFAWA
IvgucVPrrXPSAPlsv9S6tIGiTwPQPDcdzqTt+mXUwNCVLc9NdP8Os1Wpseiv1ahT
83d8iAwh+dUSe/YdgQYQRAovvtIBWDFmRrjaKzyn1BvPXdKQnKPhNyhofahOT8PL
1TZ0IDYqAGgBUEaaICUDddR9EWp8ihI+/rucOgtxpqG+VW2a6VEmtbpCeXn2h9E=
=pW3H
-----END PGP SIGNATURE-----

--h+CsNYkJBPxpZ+B/--


--===============7151570596178392062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============7151570596178392062==--

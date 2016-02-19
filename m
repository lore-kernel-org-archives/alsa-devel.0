From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: mediatek: Add machine driver for ALC5650 codec
Date: Sat, 20 Feb 2016 00:37:44 +0900
Message-ID: <20160219153744.GP18327@sirena.org.uk>
References: <1455849359-14581-1-git-send-email-pc.liao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8396865635730190716=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1455849359-14581-1-git-send-email-pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============8396865635730190716==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
Content-Disposition: inline


--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 19, 2016 at 10:35:59AM +0800, PC Liao wrote:

> @@ -3,3 +3,4 @@ obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
>  # Machine support
>  obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
>  obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
> +obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o

Why is this not covered by (or coverable by) the existinng RT5650-RT5657
driver?

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxzbHAAoJECTWi3JdVIfQER4H/2BAfeA7Y/91xa5W+OTkuWEl
HPvKvy7P2AyJcsNBkX1Dsa9ZEfYsh0283J8bN4XhfNNVHAoFvErXPPrVr0Zg9DFB
EC9oBo+ZnTjR4EyWeqdvtT09aSHgXUzwf3ftL2L5W1dVZE8SmEXllGhwN6jXcRzh
6fGJhHd+RCCaH6vULqCScA07z2yPODKk18qjqgqEN28OwtUfwT/gUPEJ/YZ9RG1N
atla4P3KGUNBqiliFdCSmb78LhP7g7a2j4JPrLVyKHX7itt3c46uQAp9ecJNsocT
+s9vBypU5LLmrzGOVZq5MpxMxA1l2w3TAVak+Wm0A2jXdwAe7ZsACVo19wZ9p00=
=2Sux
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--


--===============8396865635730190716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============8396865635730190716==--

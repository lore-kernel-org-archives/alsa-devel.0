From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8183: add mt8183-mt6358 machine
 driver
Date: Thu, 21 Mar 2019 14:54:15 +0000
Message-ID: <20190321145415.GH5684@sirena.org.uk>
References: <1551758805-34880-1-git-send-email-shunli.wang@mediatek.com>
 <1551758805-34880-2-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1662067823895188433=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1551758805-34880-2-git-send-email-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============1662067823895188433==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yia77v5a8fyVHJSl"
Content-Disposition: inline


--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2019 at 12:06:44PM +0800, Shunli Wang wrote:

> +config SND_SOC_MT8183_MT6358
> +	tristate "ASoc Audio driver for MT8183 with MT6358 codec"
> +	depends on SND_SOC_MT8183 && MTK_PMIC_WRAP
> +	select SND_SOC_MT8183
> +	help

This doesn't build:

scripts/kconfig/conf  --oldconfig Kconfig
sound/soc/mediatek/Kconfig:119:error: recursive dependency detected!
sound/soc/mediatek/Kconfig:119:	symbol SND_SOC_MT8183_MT6358 depends on SND_SOC_MT8183
sound/soc/mediatek/Kconfig:109:	symbol SND_SOC_MT8183 is selected by SND_SOC_MT8183_MT6358
For a resolution refer to Documentation/kbuild/kconfig-language.txt


--Yia77v5a8fyVHJSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTpZYACgkQJNaLcl1U
h9AjbAf8DuYIz4/B85CMwAGAQAnmgfjrOtnC5KQxpkM6m3PuHNBUHSFEpmyLYWy7
p4ojMoDzQH/uaEChf3fOWD6oVyulAsMYx+1X2vEC+pQ5m/00FX/hBTcFfWT+7Eq5
yERPCyhfvYgxhx4zURNKaTUpV3zfjarXM3ahqBj5DvuIXZU3NmyUhlUKSxqPKlSB
UNYP71z6m8lP9Bp3NH/8sUKJQ2tXxKswRKhZDeXJqP5DygS+F5IqPD+cv+5Ms2xa
av+d9Glg+/lgDEeoBTmzIYcRJGU0IePpECx9FHBkq9+Cwwp0snIe/n59u8F93Ys1
NQdiiaT0WJACLBgUs0MfymQlHEO0fA==
=MOOc
-----END PGP SIGNATURE-----

--Yia77v5a8fyVHJSl--


--===============1662067823895188433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============1662067823895188433==--

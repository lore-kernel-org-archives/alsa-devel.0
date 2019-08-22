From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt8183: fix tdm out issue
Date: Thu, 22 Aug 2019 17:13:35 +0100
Message-ID: <20190822161335.GA23391@sirena.co.uk>
References: <1566478261-13464-1-git-send-email-jiaxin.yu@mediatek.com>
 <1566478261-13464-3-git-send-email-jiaxin.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1068978944860435447=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Resent-Message-ID: <20190822181847.GD23391@sirena.co.uk>
Resent-To: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 perex-/Fr2/VpizcU@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
 linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eason.yen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
 ck.hu-c+3QU6Y0cdFWk0Htik3J/w@public.gmane.org
In-Reply-To: <1566478261-13464-3-git-send-email-jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ck.hu-c+3QU6Y0cdFWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eason.yen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============1068978944860435447==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2019 at 08:51:01PM +0800, Jiaxin Yu wrote:
> This patch fix two tdm out issues.
> 1. TDM out support S16_LE/S24_LE/S32_LE formats .When output S32_LE, we
>    need set hd_align so that memif can output MSB 24bits correctly.
> 2. Fix TDM out hw_params as SNDRV_PCM_FORMAT_S32_LE.
> 3. Fix TDM out data is valid on rising edge.

These should really be split up into separate patches, each
fixing a single issue.  Ideally the changelog should describe
how the issue is fixed like that for 1 does.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1evy0ACgkQJNaLcl1U
h9CZ3gf9E5RTE4sV5sm2rd7vBY7Z3ZWn19T1laGFpztTqI44AkYc8yA/L9dnts7b
ERliT5kmt7nrnpBLnr76jxaEwHtegzBiEJwU099BRikGNHvrcL4kZLS7wkWluw++
yPgkcGzZyNW+Nqa+AA27xzVbjoWJT3ZfDTQMmaF82/VPsPn/1fQ6fS0d4W0ugDiV
GoEP+2UHDZLB9CSZP+l4KnqaEG+A4yJrDoauxX38aw8JpUrpduXEXpGd4t2TTYRN
LFh4r985iErQR1K3IOCzzSpxf9eOa0WyvPdpmId3+MoWNVdcxRcKnMzj53fmBxgZ
kD8P3Y919BFO6vCHunpaD0l+qS5Gfw==
=URP9
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


--===============1068978944860435447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============1068978944860435447==--

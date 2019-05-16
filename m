From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: Mediatek: MT8183: enable IIR filter
Date: Thu, 16 May 2019 11:16:52 +0100
Message-ID: <20190516101652.GD5598@sirena.org.uk>
References: <20190516101515.4127-1-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0890292539973156861=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190516101515.4127-1-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============0890292539973156861==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 06:15:15PM +0800, Shunli Wang wrote:
> This patch is to enable IIR filter when DMIC of PMIC
> is enabled.

Should this not have a user control in case the user wants to avoid the
filter for some reason?

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdOJQACgkQJNaLcl1U
h9DQXwf/Q23Lgt4di48QYQEqFll73b2HKiTnqbNLzIJALr+aNJuawGT8eTPovS0m
t4g0WY7gHRWxfKYmBSDBsEmwhNsJG5Ns592Yzki1sSsHpoi//rerbgF48q4n56nH
6o6NfuwmS5YQjPHyd996bmb1VH3fi203Ah42ZxowYptPKjuQN1+INUvj2cneGC5j
7SLu/d/PYWIRs1sMpCrvPhDIlfryIWBmCFfLXnP3ncvT93UhjyEqLX0bRCLephGE
m/GNvqIhr8mPZAQV/wfLqcvj8EKRwz9z88eQkEaPftYTlxqrr2XE97HQPHYqEDSQ
Wae+Ct0I7PgfzFIvav+/NLiKBSOajQ==
=LsWt
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--


--===============0890292539973156861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============0890292539973156861==--

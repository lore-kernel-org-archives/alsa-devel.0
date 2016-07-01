From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v5 7/9] ASoC: bt-sco: extend rate and add a
 general compatible string
Date: Fri, 1 Jul 2016 18:11:05 +0200
Message-ID: <20160701161105.GY6247@sirena.org.uk>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
 <20160629191500.GU6247@sirena.org.uk>
 <1467291345.11091.16.camel@mtksdaap41>
 <1467341386.21689.6.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6022995759774739053=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467341386.21689.6.camel@mtksdaap41>
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


--===============6022995759774739053==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lv0dYwq55yjFwMRW"
Content-Disposition: inline


--Lv0dYwq55yjFwMRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 01, 2016 at 10:49:46AM +0800, Garlic Tseng wrote:
> On Thu, 2016-06-30 at 20:55 +0800, Garlic Tseng wrote:

> > If you worry about some potential risk (I don't see any) maybe we have
> > to develop another dummy bt-sco codec driver which support both 8k and
> > 16k?

> Ah! If someone whose bluetooth modules only support 8k use the driver,
> they might be broken, right? Maybe we can add another snd_soc_dai_driver
> which can support both 8k and 16k.
> (Actually I found the issue is discussed before
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084687.html )

Yes, that'd be fine - it could be the same driver and register different
parameters depending on config/compatible.

--Lv0dYwq55yjFwMRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdpYYAAoJECTWi3JdVIfQWP0H/0jfVKrYIiZ3HxbJRJCtBIoR
blm2B9V/DaUCicehfw7bOj09DvvF3N+0t/0IVm1g+xspLKGKAElmhgWf5yeuMijZ
5/Zibh75b2wMVl7w9krEMmL9Fa2U+owU3lg6ovO0vYMFxEWvGWkdx7oyNZRU08q+
DDDv7nv/zLuJF0eFcvmXc0OxqXT441H23w5HOOwpCNKv6EKt+nE1ub96qc0xaR96
9fawFfLQDWkr1uOBEUhXvWKV9F/bn/iibq2jNvhf6rmtwAW20ZgjN9x6SHZ6XV8S
kSbAUpDfFeJh7PNxH1fsrPNjZNrXck1/hHhokZsbkPmJa0x6I8fw440Q75J/trA=
=X8hJ
-----END PGP SIGNATURE-----

--Lv0dYwq55yjFwMRW--


--===============6022995759774739053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============6022995759774739053==--

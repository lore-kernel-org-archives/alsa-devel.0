From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
Date: Tue, 7 Jun 2016 13:06:47 +0100
Message-ID: <20160607120647.GV7510@sirena.org.uk>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop>
 <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk>
 <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk>
 <5756B22F.9000105@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7451869198014087814=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <5756B22F.9000105-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============7451869198014087814==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SidV/bKy1CyabPX8"
Content-Disposition: inline


--SidV/bKy1CyabPX8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 07:38:23PM +0800, Xing Zheng wrote:
> On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 18:47, Mark Brown wrote:

> > No, that'd be one card with all three CODECs on the same board which I'm
> > guessing isn't the intention?

> Yes, because on our board, the audio connection by hardware really is suc=
h:
>                   |-- max98357a
> i2s0 <=3D=3D> |-- rt5514
>                   | -- da7219

> We do need to support max98357a / rt5514 / da7219 via i2s0 on the same bo=
ard
> for RK3399.

> I remember that it will be failed if we register card with i2s0 more time=
s.
> Therefore, I chose this mothod that create 3 dai-links on one machine
> driver.

OK, then the original name probably makes some sense though really
that's such an unusual design that just naming it after the specific
board might be better, it's not likely to see any reuse I'd guess.

--SidV/bKy1CyabPX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVrjWAAoJECTWi3JdVIfQmlwH/321+pXBIgMXijx++JtXsHvZ
msdn9EAlBD+fCxF3ggxJkNP2xv4O8C/3njIzV3dDYqp9MaJfkXWn14DSip3uELkO
NRiTpM1UshR0wLirCmgiSjmxtyTVC9yLVtkRVYVYJMwMlauPpoNh52ssq5LvM+de
wvv3CvC9JaRX1OmiM/jTAkBjaJVZL8O9ttfbbgJKjX6Wq1gaPKM9QyFEPFwasjC3
ci5RNIfi32Ar6wWmMCGdzLiNAvj5jsslw3JXV6Jpb3bdU7yzAWCjXDEan4iQKTsB
LyUEkjM3oAQOkF2Zulv+cOgQIAm9MCNkUksMuBxT2jg4cb/dlvVK6Qe3Z7g08U4=
=LMu1
-----END PGP SIGNATURE-----

--SidV/bKy1CyabPX8--


--===============7451869198014087814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============7451869198014087814==--

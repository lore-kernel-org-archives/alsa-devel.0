From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
Date: Fri, 17 Jun 2016 13:20:50 +0100
Message-ID: <20160617122050.GL26099@sirena.org.uk>
References: <1465807339-1100-1-git-send-email-zhengxing@rock-chips.com>
 <20160614223810.GA7925@rob-hp-laptop>
 <20160615095312.GY2282@sirena.org.uk>
 <CAL_JsqKEDw14HmbW=78_4P03nFDfmT7kOn4RsTF-PrBi+jWr0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5180901128721785628=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAL_JsqKEDw14HmbW=78_4P03nFDfmT7kOn4RsTF-PrBi+jWr0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============5180901128721785628==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2016 at 07:44:32AM -0500, Rob Herring wrote:
> On Wed, Jun 15, 2016 at 4:53 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > There's no point in standard property names if the interpretation has to
> > be non-standard.

> Okay, I agree with the system specific interpretation part. However, I
> don't think using simple-card or not determines using common
> properties.

The point here is that if those properties were to have a standard
meaning the system would be using simple-card anyway, the meaning is
entirely in the context of the card.

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY+shAAoJECTWi3JdVIfQe9IH/ju9XNHVtP+hk/XdCxhZQyRU
69ODHdm0dvpOWvw8kjto7fSuAFvPcWAMAvGyDllk/MqWVny3SSC6YKR1r68dKY2P
wZi+/BsFtWZgZeYzbH6obnP+FnjuXzS4sKFUljPpG3YOOZeuONE37fs1S95/AotW
qU/MnmeprWtyS3vn2pQ7+YjXhRApYN72V4h5/Xzkkn8IFbMKP9A/0O83mjDaiwzu
lyuXFlS/ajlElWlpqrdjQPNXv5ISZuQ8UXgVc+oguY0zK6QZh54S4k7JTmCJvI63
nVpi4YdoyHB6pA/KiGcvyXbr8Ttx78ScingnnhJzbdbxrSrO4uh/UHUT9QOYJhQ=
=Vyl7
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--


--===============5180901128721785628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============5180901128721785628==--

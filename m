From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: atmel-classd: DT binding for Class D audio
 amplifier driver
Date: Wed, 16 Sep 2015 20:42:34 +0100
Message-ID: <20150916194234.GR12027@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
 <20150903114316.GV12027@sirena.org.uk>
 <55EC0AFE.3080809@atmel.com>
 <20150907162548.GW5313@sirena.org.uk>
 <55EEAC0D.7010003@atmel.com>
 <20150908122340.GC9751@sirena.org.uk>
 <55F78C79.30102@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C8VkwhTltIEgspDW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F78C79.30102-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wu, Songjun" <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--C8VkwhTltIEgspDW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2015 at 11:11:53AM +0800, Wu, Songjun wrote:

> I try to use one entry, but there is a problem.
> It's about 'driver_data' in struct device.
> In function snd_soc_register_card, the parameter 'card' will be set to
> 'driver_data' by the code 'dev_set_drvdata(card->dev, card)'.
> Then some resources(eg. regmap, clock) also need be recorded by
> 'driver_data'. One entry could only has one 'driver_data'. I think the best
> way is to create two entries, like the current dts.
> What's your opinion?

Look at the recently applied sunxi driver for an example of how to do
this - it's a similar piece of hardware (entirely in the SoC and so on).

--C8VkwhTltIEgspDW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+cYpAAoJECTWi3JdVIfQT8AH/A6lavo8bmUgkGD8dpaf3OOb
qNrQjOox4qyznhBb3IuWP1llsWM/5D56MzWJXdKa5kIjTU1w19xQ+JwbxZIcmjOc
T1TyiIkofBVW505jGUFrLgoRKEDa0iSDjBI4EmqRl3jB0IVCYooWWp8z01VWOX9i
RjNCijLDfYM8wo6/WtFyz9T4QCFVcgpO90lGU8aO9zgm0u1QSH7hvPbdG5x6S4dt
n7v1/BJ2bPGtDuq/UajHTnJsubN3diGzVc8o8SmX2ENW2eODmetOS8UtwNZd3XLU
Qy6fvknhFCPJ0sxb5r76zIw39v8Uiugokn2fi/YooynU/oyKiernMkZQjqD/ps4=
=pOy3
-----END PGP SIGNATURE-----

--C8VkwhTltIEgspDW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

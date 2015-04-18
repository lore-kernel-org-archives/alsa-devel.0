From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: tas571x: New driver for TI
 TAS571x power amplifiers
Date: Sat, 18 Apr 2015 12:39:57 +0100
Message-ID: <20150418113957.GF26185@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org>
 <552FB1CD.3040401@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <552FB1CD.3040401-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2015 at 02:57:49PM +0200, Lars-Peter Clausen wrote:
> On 04/15/2015 11:42 PM, Kevin Cernekee wrote:

> >+	case TAS571X_ID_5711:
> >+		priv->codec_driver.controls = tas5711_controls;
> >+		priv->codec_driver.num_controls = ARRAY_SIZE(tas5711_controls);
> >+		break;
> >+	case TAS571X_ID_5717:
> >+	case TAS571X_ID_5719:
> >+		priv->codec_driver.controls = tas5717_controls;
> >+		priv->codec_driver.num_controls = ARRAY_SIZE(tas5717_controls);

> Typically when a driver supports multiple chips with different control sets
> the snd_soc_codec_driver implements a probe callback in which the correct
> controls are registered.

I'm fine with doing it with tables (though just having two static CODEC
driver structures would be a bit cleaner).  The pattern with probe() is
usually that there's some base set of controls all the devices have
which then gets device specific controls/routes/whatever added to it so
you get benefits fromm sharing the table but in this case the table is
so tiny anyway that I'm not sure it's worth caring.

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMkKMAAoJECTWi3JdVIfQ6YgH/2i2xJMcX5Q+9C1nFFG7d+Wv
N6TYqVsznTCfXAUBkhCTxh08ZQTu/5TtlpXX0JS6aUdxCmvu/f6SZRrt5ua0hYB8
RVme09EnlbdAHI7xCdYfNMu5DRkYas0ztPsE+g1zw79XHKvJ0JTDqOJwgop5fRlN
wqID+EEmD51zlqpv7ZGaC/4941qhy3PB6SKCKiRttQv65Zi2hKfGKI+IVhI8GJfx
e5SQ5y9Jyo2uKjGnHUFplqrVk/lB1jRJK7ScqVCGH1eChumdEkzIcwTml47Z0Wvj
3h48bSVKqMrVL+wj4r9Rlu8J8BHdqUvoiqaiIans7F+FNNRwThFsl9UtniNVkKk=
=MQmg
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

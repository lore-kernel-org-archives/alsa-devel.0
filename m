From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
Date: Fri, 11 Sep 2015 11:34:17 +0100
Message-ID: <20150911103417.GF12027@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk>
 <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk>
 <55EEAC01.3080409@atmel.com>
 <20150908122322.GB9751@sirena.org.uk>
 <55EFA478.1000109@atmel.com>
 <20150909095245.GG9751@sirena.org.uk>
 <55F0EB68.9070800@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="esct/jjn4zW1hKjT"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F0EB68.9070800-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wu, Songjun" <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--esct/jjn4zW1hKjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2015 at 10:31:04AM +0800, Wu, Songjun wrote:
> On 9/9/2015 17:52, Mark Brown wrote:

> >Yes, that's what's going to end up happening but it's not how controls
> >are expected to behave - applications will expect changing one control
> >to leave others unaffected so it's better to return an error rather than
> >change the other control.

> If application change non EQ controls, the others will be unaffected. But
> the classD IP can only supports one EQ control at once, these three EQ
> controls point to the same register field, if application set a different EQ
> control, the error occurs, there will be many errors, it's not very
> reasonable to application. The best way I think is if application set one EQ
> control, the other EQ controls will change to 0dB, it's also consistent with
> fact.

There's no really good solutions here - this is why my initial
suggestion was to have a single enumerated control.

--esct/jjn4zW1hKjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8q4oAAoJECTWi3JdVIfQQDwH/2uuZ5rkS3Y69aRAt302VzcK
RiyKAkYVseOp2fobDtZZx7GsPOoJXmEFVsDMKwp7wfZOoZr8fw4LpviPlCd+kek4
4LGgBfpRhmCFuptCNZrJcrtUO4weR29h+u23YIgNgLg9tpD1H1krMYEDlIQSOspk
tpYKaP2fWB6uRSiXLVZwTO+JkYd6+2y91slaFV7A0hDmeKdFdvikPvGVG6/Kvwf3
v0vGAecdn8L2OaY/8dViTD6456eR4E4NbFFphnoVTrpFOqyMOFYp3nmhM9FlC2Kh
0pbl7wYSoNXCSwDKjNVTkGmO9lpZCpGZnGxIyArjuSXTskJP+UR4/hygJnOn6Po=
=Y5Ym
-----END PGP SIGNATURE-----

--esct/jjn4zW1hKjT--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

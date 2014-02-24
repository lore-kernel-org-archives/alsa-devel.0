From: "Austin, Brian" <Brian.Austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Mon, 24 Feb 2014 16:32:06 +0000
Message-ID: <FF523989-CEF7-4A91-92A0-63D5FB90D897@cirrus.com>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
 <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
 <20140224160648.GC6132@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_329C7435-941F-4099-B667-9AF20083595A";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140224160648.GC6132@MrMyself>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--Apple-Mail=_329C7435-941F-4099-B667-9AF20083595A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On Feb 24, 2014, at 10:06 AM, Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org> =
wrote:

> On Mon, Feb 24, 2014 at 03:52:24PM +0000, Austin, Brian wrote:
>>>> +	if (!IS_ERR(cs42888->clk))
>>>> +		clk_disable_unprepare(cs42888->clk);
>>>=20
>>> Does the device work without MCLK?
>> Yes, MCLK is required. If you can=92t get the clock you should error =
out.
>=20
> Wait...Regarding this clock part, I just forgot the reason I put the =
code:
>=20
> 385         cs42888->clk =3D devm_clk_get(&i2c->dev, "mclk");
> 386         if (IS_ERR(cs42888->clk))
> 387                 dev_warn(&i2c->dev, "failed to get the clock: =
%ld\n",
> 388                                 PTR_ERR(cs42888->clk));
>=20
> was because the MCLK might be provided from SoC (DAI master) so it =
could
> be totally controlled by CPU DAI driver, ESAI for example has its own
> dividers to derive the HCKT clock (MCLK for Tx) from ahb clock in SoC
> clock tree, in which case we might not easily pass a valid clock =
phandle
> via DT. (RFC to this thought.)
OK, It=92s an external MCLK source, so why not just handle that in the =
machine driver?=20
Usually you would want the clock enabled/disabled in the machine driver =
so if you don=92t get it, you can bail out there.=20
At least that is how I do our MCLK=92s. Since you are only using the =
freq of the clock to derive modes, just put the clock initialization =
outside and just pass in the freq like you do in set_sysclk

--Apple-Mail=_329C7435-941F-4099-B667-9AF20083595A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTC3QGAAoJEHdXZdGWfiO7RQgIAKppnNelAKpiRR/Bmgyby3rB
k0zh4GzYx4bwXoZBTVNQnjuGKcC2DvV9EDvmTEynzhmxKCfrKGRreiksDOO9I3Q3
pb7C2tbudG3nSUAC4xosmMh3U/URPhpWAN5tU9gmN+kPz1M/FHInNlrw5/fWIqhz
4fp7030xcFV0FzLwu3J8rMd434WKEIbEv/dpAJxxwj2q8NnfnIIiSahkjIYSNSJ7
RFuf/lYz1ArnirWRt4NXsEbkWY079GirPePIgvt7OKgxQj3boAqZetJ2mhlPpgpn
B52dtDNhrgYCF1/ihNcayD6+uC6xOMdHdT8pvLGBu2c2jwggrs/Zm/To8kgpbcc=
=h0Jn
-----END PGP SIGNATURE-----

--Apple-Mail=_329C7435-941F-4099-B667-9AF20083595A--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

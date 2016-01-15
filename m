From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Fri, 15 Jan 2016 13:13:25 +0000
Message-ID: <20160115131325.GW6588@sirena.org.uk>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia>
 <56984BE7.2050303@tabi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j+wdmHMkwJXioevW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56984BE7.2050303-N01EOCouUvQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>
Cc: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Caleb Crome <caleb-EebDDntmC0DYtjvyW6yDsg@public.gmane.org>, Xiubo Li <Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--j+wdmHMkwJXioevW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 14, 2016 at 07:31:19PM -0600, Timur Tabi wrote:
> Nicolin Chen wrote:
> >I think DT maintainers may not give a consent towards these two
> >properties as they are not to describe the hardware but to hack
> >software configurations. (And it seems you haven't CCed them.)

> I admit it's a grey area, but the hardware doesn't work if you use the wrong
> value, and it is a fixed value per device.  A p1022ds would use a different
> value than in in i.MX6, and once you pick a value, it's the same no matter
> which sample rate, buffer size, etc you choose.

Caleb's original message suggested this was rate dependant.

--j+wdmHMkwJXioevW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWmPB0AAoJECTWi3JdVIfQoBQH/RScBQjliEB8YD00kgMqAphM
qeqMqi728TCgNwVu73ZXsJg2bE1szryQKR5DjQEvbgU8svZo470nV2qfPd+4dNct
CTANdZ0NjuhpV8IKZZYCYjtyZiQli0MdOlYaD8bhYzeRXaE/mSHD1X0p1yt63tZk
0EzJzaABBysmd8Ywy9vJ2imthGUJoDheZSJsGHfm4IBINgshFn/UwhNUw3f1uW2m
gYxrJwY4MgJwN858n3vd4hQcQoWIiuOASeI8rd00eEf8yZbkKVICUVXHp5DltsPs
XCG+/Yi36TXGNHThYAeh0BSWzLV5+urBOYbqMuhAQaZJJULjEQAkqhI+O0/P+cw=
=n08r
-----END PGP SIGNATURE-----

--j+wdmHMkwJXioevW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

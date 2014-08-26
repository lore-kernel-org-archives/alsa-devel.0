From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Tue, 26 Aug 2014 10:42:11 +0100
Message-ID: <20140826094211.GF17528@sirena.org.uk>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com>
 <874mx7iqgt.wl%kuninori.morimoto.gx@renesas.com>
 <53F9A6EE.5070005@metafoo.de>
 <871ts4nmki.wl%kuninori.morimoto.gx@gmail.com>
 <20140826062558.GR17528@sirena.org.uk>
 <87wq9vmyyc.wl%kuninori.morimoto.gx@gmail.com>
 <20140826091120.GC17528@sirena.org.uk>
 <53FC5105.6070901@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="91FpgGVafXqcwc9i"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53FC5105.6070901-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--91FpgGVafXqcwc9i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 11:19:01AM +0200, Lars-Peter Clausen wrote:
> On 08/26/2014 11:11 AM, Mark Brown wrote:

> >If we're already specifying the DAI links for the (D)PCM code it seems
> >like we shouldn't also have to put DAPM routes for them in DT as well.

> Yes, and I think we shouldn't use anything except for datahsheet pin names
> in the devicetree routing, because otherwise we are leaking driver
> implementation details.

While I agree with the sentiment for this when it comes to DAIs we
probably want to use the name the interfaces get in the documentation
rather than pin names since they involve multiple pins working together.

--91FpgGVafXqcwc9i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/FZvAAoJELSic+t+oim9hU8P/08+GbYltu7rFK24ev1AmZSS
/yTYKxCnZDvDg1p/A33BZOSIJQtkQXvPpyP/7SyTS5KfXn+5B0sMR8bcCZFfWjzy
RmzeaLIXgN2WEbSziduZ84OsRVHRZC9KPXvDBvSKVXF/18RczbBt64JU7vPlOeIe
m/P47zYOHUmVhsiUKVRv9FdpH1ltqMFA4Vr5WGk6R1XB6kedDGwxwo//AwOmzM9v
CVrWdD/BS0O1gj1ULmLWBuZ4Wp8svzZfVtfi3sejT3NVlWPYp8rm5fhkegJ0lIh9
bcw0GNYzSe5qdIVn1IMxYzMydxRTKx4ym06EAxlZsIJUnr41QkbOAOwavqtt7eIN
LvstA2SXZ9t/4K4pCaILVTYbryK/03udBXk6RMrljTH9tEhLvyXRw6vyuVweo7Df
qCYDEZcsQDENSVdT144uDKxMbbx+JtKCr+wRctvAddGYa6vRqLZz6Jx+gRS7XCQs
jqffGgwu2uQeBK/R2MRO3EMdvZWY9thH1bKwtOscaJZa7QksF0Ovn2TLCMhONYG+
6eVxVmEbWsVcLHbq8ctuGFuVjDz1yceTvqT/5nNGoXmfh5gBob9jK/adlYqPlIek
ezn8zrdGfLws2WtmOtVQAHJs5mcv4H0XRZ7fXXnsM+hMPc2bmbx0+SQvJDomJ6E8
h4KqLv0pcxMnmVOFRkc1
=dfve
-----END PGP SIGNATURE-----

--91FpgGVafXqcwc9i--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: kirkwood: add S/PDIF support
Date: Tue, 24 Sep 2013 16:37:01 +0100
Message-ID: <20130924153701.GF3226@sirena.org.uk>
References: <20130924124122.64834b2a@armhf>
 <20130924105127.GB12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130924105127.GB12758-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2013 at 11:51:27AM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 24, 2013 at 12:41:22PM +0200, Jean-Francois Moine wrote:
> > This patch adds S/PDIF input/output for mvebu DT boards.

> Right, so if this goes in, then we're completely fucked for doing this
> the way that Mark apparantly wants it to be done, because once these
> DT properties go in, they're there to stay.

I'm not sure that this is in particular conflict with any other way of
writing things, though it would be redundant.  The best thing would be
to key this off connecting to DAIs so that people just need to make the
connections that exist in their system in the device tree.

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQbGaAAoJELSic+t+oim9PFkQAIkq41++/nPyaS3YVZsSc8WH
PybmS8vFrQXrdGK40t008/6h/uGVSFzCajoVkVR2qHFkpXBxGfhZnIEOzV7qhMP8
iaCEgBelA+JSWcDauuiUkijQCcraLeqXiZwR6I8gIiqnuLjAp+K9Sm3P2oKcxLUW
3DthUakfDwf3QXbKU3UdZT03uVXMB7Azl56BYagFV9U01T1LYuLH9mH4N9VkRUns
K9y7cZv9xe53ArWJaH0QShMyH67TM9YOZJQu7irIqp64wU1pCG2qkFLZrEiNcoiT
ZBWITF++smLszX41NoOKAzangvtVOGMA+XU10S42iO8doo9wKNIaJRLDzQZxS85L
d8AUB/D0el5OQWDSkbJ4a5TSf7v+dEbyaWbcPaycGY/XiM5mr2fTlnQ7NEqQ8dfv
rHcwhRmh2pU9sP64anizCtQ0nph4rWj+Pq8ZL0UKv1AQCsnNhVQG39qSD1tGquZR
MCeTgVNgWaj9YPS4ku2VGRw4yM+zzXrSNuHVpCwK7DibVdp/+y93RjTIjZ726L/2
NmDv6HJWuCSK1higm8SCf75XK3c90ZQLFQVMdHLgST+pmthRc/C9i25u1ZQW7zC0
6dXhu43xURzdE5HJKYp67+vUsorl6KL77v943owS2GzY2ld5dYPNeBetKW/7oeAF
ySpL45ujLYdyDU2LHm/0
=ut2v
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

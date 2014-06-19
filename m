From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4 3/3] ASoC: fsl: add imx-es8328 machine
 driver
Date: Thu, 19 Jun 2014 11:39:22 +0100
Message-ID: <20140619103922.GO5099@sirena.org.uk>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com>
 <1403063242-20840-4-git-send-email-xobs@kosagi.com>
 <20140618100233.GE5099@sirena.org.uk>
 <53A1687C.9010705@kosagi.com>
 <20140618103111.GH5099@sirena.org.uk>
 <53A23E1B.3070008@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ewiTub5oIxhQg78Q"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53A23E1B.3070008-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ewiTub5oIxhQg78Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2014 at 09:34:19AM +0800, Sean Cross wrote:
> On 06/18/14 18:31, Mark Brown wrote:

> > Look at the clock API, this stuff was introduced in the last merge
> > window if it's there yet at all.

> support is going to be merged, I'd like to try using that code.  Is this
> the "assigned-clock-parents" patch you're referring to, or is there a
> patchset that will automatically reparent as necessary?

assigned-clock-parents sounds like it's what I was thinking of.

> machine drivers and codec drivers.  A random sampling of codec drivers
> doesn't yield any drivers grabbing their own power switches.  Is that an

$ grep regulator_get sound/soc/codecs/*.c | wc -l=20
19
$ grep regulator_bulk_get sound/soc/codecs/*.c | wc -l
32

Please put a bit more effort into trying to understand what you're
doing, the common patterns, the terminology and so on - people will
be much more willing to help if it appears that there is active
engagement on your part.

--ewiTub5oIxhQg78Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTor3XAAoJELSic+t+oim9wXoP/RVhyBPtZ7t+qVRNPtWQ/RjR
ZdWe3/v5NNrOLZDv2liJYdrvwHmEaIvEPUrgBrBmQdI6EnrSJVKcjlD7wSl9Jjxr
ed5CPrAUvqLReGGyg9+bBPXuMFznUvJFp+oFFG05xPXR+iKbLfW0U61iWiC6oQDy
1Asn+1Ai8N6I3r1i+em01M22lIoiSxftqEsz4QCIx/j/b1JmTYc/A4ARME7ebC0X
TfgFgUY0wzsDeRpgRNntOws81p+LMkVDbMA9daeiNneZ6Rr9FHNZwiGC+8ci8mMY
dI634k+KNty46hKXSfFaSe31zWDxkzbpnoJguITjXOzVyp3+RoH8ZoSST1/ys83N
fQTUWhxwm2p2kzhL3nwVE2Vh4Lg6JWZMwL5gwM98/77r5LBSRVBD5WIgfQj+hy63
J65j9UJ4lif9JyL50mpoMKycxJD8n3vRLmmawnrz4/fQmaryRvqMYMZAQ6BUZY9m
3USXXVdAEXc44/RIAwPl2AvPRY2vor8Sa5aji3DDD6FGQsPoP1gaMycTDyyawG5t
D8l4ioUqwZQb0XXTV9F8e3U6vQMMvFKcLy3gwLkFQmW9hg7MCd0hQrb41idl7DPv
YyvZPsmz1klGUaSsRatbdxfO5WW/4/dcnr2utR0MwqN8lr1ZIyg8JRki7D/ywJzL
9pEK73sjftb6fVIT2jON
=eGzc
-----END PGP SIGNATURE-----

--ewiTub5oIxhQg78Q--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

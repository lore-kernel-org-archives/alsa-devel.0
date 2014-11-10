From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: twl4030: allow voice port to be connected
 externally.
Date: Mon, 10 Nov 2014 12:11:55 +0000
Message-ID: <20141110121155.GN3815@sirena.org.uk>
References: <20141108002637.6561.19002.stgit@notabene.brown>
 <20141108003803.6561.57464.stgit@notabene.brown>
 <20141108092622.GC2722@sirena.org.uk>
 <20141110102551.2678d342@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghgy3zzpkChQqL5M"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141110102551.2678d342-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ghgy3zzpkChQqL5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 10:25:51AM +1100, NeilBrown wrote:

> says it is a "reference platform".  Does that mean it is a board with a bunch
> of chips soldered onto it?  If it were a board it should be described by a
> dts file, not by a pile of C code (I thought), so I must be wrong about that.

No, like I say please see previous discussion ad nauseum about this.

> The twl4030 needs to know the master/polarity of the clk/frm lines.  The GSM
> module declares that these are.  So presumably we need some sort of linkage.
> Ahhhh... I found Documentation/devicetree/bindings/sound/simple-card.txt

Or just write a machine driver.  simple-card is one such machine driver
but it's not going to be suitable for non-trivial systems.  Possibly
your system is simple enough, possibly it isn't - I don't know anything
about it really.  Regardless of how you do this it shouldn't have
individual devices needing to open code configuration for links, it's
something essentially every device is going to need to do and forcing
the DT to configure the same thing twice for a link isn't a good idea
either.

--ghgy3zzpkChQqL5M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYKuKAAoJECTWi3JdVIfQjGkH+wX0fAdnJ788cNfzTWedEw81
K/BjIh8vHOTnCu8h3zx9qi2fM7oYu9ZrocFkJoNaj4XeilDdaEv86mrKB9neV+2r
RELNoX682GmfY/+5dPIc2tD4JHIf8I2mCOqyNyqmsMHwLIlhv8Ihmv9s58GX2Luy
QiLoZzRn5oPzW+eSx6A7fmNx89B3cBgMRMGaykjsFxd/Iwe/iVmLSNz7lgkwJfak
bV3CeIZL7uiHvyp7a2kPbvgyUyOt7KHB90Ej+WbJUcaby2RZx4BEjbkOWVQtXnuQ
EJOC1SgmH9BQiGFhHpSBU7JqKvL906PkozQ69ARAtUf+9H58clXlHFt+7MXmz6Q=
=QAuy
-----END PGP SIGNATURE-----

--ghgy3zzpkChQqL5M--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

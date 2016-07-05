From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 2/6] ASoC: samsung: Add Samsung Low Power
 Audio Subsystem driver
Date: Tue, 5 Jul 2016 16:25:24 +0200
Message-ID: <20160705142524.GW6247@sirena.org.uk>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-3-git-send-email-s.nawrocki@samsung.com>
 <20160629215757.GX6247@sirena.org.uk>
 <577553FE.6080803@samsung.com>
 <20160701150709.GT6247@sirena.org.uk>
 <57769AE5.4050407@samsung.com>
 <20160702082548.GF6247@sirena.org.uk>
 <577A8BF7.8090900@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xWiEbTquLUstXc+R"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <577A8BF7.8090900-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--xWiEbTquLUstXc+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 06:16:55PM +0200, Sylwester Nawrocki wrote:
> On 07/02/2016 10:25 AM, Mark Brown wrote:

> > So a MFD then?

> It might a best match, however I yet need to figure out what to do with
> the PL330 DMAC which is a child of the amba bus.

There should be nothing in principle that stops you registering AMBA
devices like MFDs currently register platform devices, or you could
perhaps add platform device registration in the PL330 to let it be
registered with either platform or AMBA?

--xWiEbTquLUstXc+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe8M0AAoJECTWi3JdVIfQBBUH/0n01i0jsGvWgr5h7JGQNz9C
3r63u44G6Sc0aooQ26shEQ4ui74G+g6PrltphdZDQkWywYUtCYvRKwqDTHSZ1G4I
nCXj2jNyklbPqpO2srK4+dN23QgtTbhrDoBuLYIfvVv1Nz5dOWdVBe2GdmS4jLrE
rYgXGQKOfoDGzcnIcaiHcx0jJl268qfQUdEBmdQMgNugMxV4tobdSLmQXA9KcLZ2
VhK1IoxFIwip9byOC3jcmzhRqWL3HmZA3alWrlhQ+2OMyMQmYfqmurAytz+Q2hcd
wF3Ta779fOkmpFYwDhBS8xIptAwUmra4YNMRpidw4o6U1e7YuLXhxXfltEcgG04=
=pmwE
-----END PGP SIGNATURE-----

--xWiEbTquLUstXc+R--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

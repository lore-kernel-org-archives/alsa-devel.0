From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5659: Add mclk controls
Date: Thu, 11 Aug 2016 12:34:32 +0100
Message-ID: <20160811113432.GQ9347@sirena.org.uk>
References: <20160728155732.GG11806@sirena.org.uk>
 <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk>
 <20160729161521.GL9681@localhost>
 <20160729163933.GJ10376@sirena.org.uk>
 <c649c3fe-b111-56a8-275e-d967a961dd41@linux.intel.com>
 <20160810170632.GL9347@sirena.org.uk>
 <c794d543-a57a-aad6-1b62-4d101a79cdd3@linux.intel.com>
 <20160810175243.GN9347@sirena.org.uk>
 <ff13c01a-a3f5-b11f-c342-926e98f64be3@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0ZpWocbG2H/Vq+uQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ff13c01a-a3f5-b11f-c342-926e98f64be3-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--0ZpWocbG2H/Vq+uQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2016 at 04:59:03PM -0500, Pierre-Louis Bossart wrote:
> On 8/10/16 12:52 PM, Mark Brown wrote:

> > I'm not just hinting at that, I've openly stated it quite a few times
> > now!  :P  For the simpler CODECs it's kind of marginal if you need to
> > bother but for anything more complex (even things with PLLs) it seems
> > like the way forwards.

> interesting, thanks for the precision. I must admit I missed this concept
> completely and I didn't see any codec vendors work in this direction so far.
> Ironically the x86 part may be the most straightforward...

Architectures like x86 that are unable or unwilling to enable the use of
the clock API are a blocker here, drivers can't make use of the API if
it's not available.  There are more architectures than x86 but it's the
only one with any active ASoC use that I'm aware of, unfortunately the
maintainers didn't react positively to attempts to enable the clock API
in the past.  I just sent a patch to try to fix it from the clock API
side so let's hope that's a bit more helpful.

--0ZpWocbG2H/Vq+uQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXrGLHAAoJECTWi3JdVIfQyaMH/2hFq7j5i+hNtcE4lEQR6zT0
9u8fXLXH/tOMeWnu+LdjwyHwWaQRYzSiNkQaHOad30Hc/APffpWroHtmtzWWlrp3
JQwZFeHhAIWnWzkFqrbC7BEFw3YkV3gYG0SpBbphcMb6htiiHn+4+zA5Bq5jkQly
1Hba2zEngkmE2qFR9e+vltGcWgTGxo/s/fH0Rq3OizhKW/eABlkv7idsehVT20sG
r1ncgoy6UtUxwensxzsNzXfTH7kd5nS2vL4nmYrqXNDybUAtWR0ROeYHkHeQ4o3l
XMq6BeAnjAF0QxhRrDssU3QP/BHEaE7Osq/UhR5uyODivLWJZfRfvRlKc4mpQtk=
=SgME
-----END PGP SIGNATURE-----

--0ZpWocbG2H/Vq+uQ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

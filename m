From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Add DT bindings for Broadcom
 Cygnus audio
Date: Fri, 6 Nov 2015 10:31:47 +0000
Message-ID: <20151106103147.GZ18409@sirena.org.uk>
References: <1446502284-23907-2-git-send-email-ssimran@broadcom.com>
 <20151104140746.GE1717@sirena.org.uk>
 <563BB5B0.5040501@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E9SPMlsjsjqOlA3h"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <563BB5B0.5040501-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arun Parameswaran <arunp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--E9SPMlsjsjqOlA3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 12:01:52PM -0800, Simran Rai wrote:
> On 11/4/2015 6:07 AM, Mark Brown wrote:
> >On Mon, Nov 02, 2015 at 02:11:23PM -0800, Simran Rai wrote:

> >>+  Interfaces grouping of serial port. In multi-channel stereo, use
> >>+  "2_0", in 3.1 multi-channel grouping, use "3_1" and in 5.1
> >>+  multi-channel grouping, use "5_1".

> >I don't really understand what this means or why this is not runtime
> >configured.

> By runtime configured, do you mean passing the channel grouping through
> machine file? Is there any specific callback that I can use?

No, this appears to just be setting the number of channels which is
normally configured depending on how many channels userspace is playing.

--E9SPMlsjsjqOlA3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPIGSAAoJECTWi3JdVIfQMzkH/RbJZgjHPea2lsTTRqSaUY6V
6GFlAq9Wh6bLhWriatoHx73OjtJ+Rq/Z4jZhWuAlbk+6oHXt/+t1Xu+XsFysC0jq
fT2WVc3UiJ91Nc1DFvtZRZU3Xmm7swFa9pK3Z3rkex+CS5uIeLrdEzmWdh7hg70R
PINuJOoEC1Kw+BQLpUas6qIro0lkDi4Steg5Nt2yo2Xryt1HBV0Q6x4IBQXRo8Y2
hI/g2R8n8MUf+qG952/kqUUR5j2C7d0G56oUCfcl4U4de5wqfbukncKsjSbMsEJY
2LXo9V9EEXN2EnKnjMWkcNBTKcADLAmya5XDHBe4CXMEaE1cgUjgVwxhbV+q+rQ=
=GfL5
-----END PGP SIGNATURE-----

--E9SPMlsjsjqOlA3h--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

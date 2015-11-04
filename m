From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Add DT bindings for Broadcom
 Cygnus audio
Date: Wed, 4 Nov 2015 14:07:46 +0000
Message-ID: <20151104140746.GE1717@sirena.org.uk>
References: <1446502284-23907-2-git-send-email-ssimran@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446502284-23907-2-git-send-email-ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arun Parameswaran <arunp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2015 at 02:11:23PM -0800, Simran Rai wrote:

> +- channel-group: Surround sound grouping that controls which channel
> +  outputs belong to a group, specifically useful in Multi-channel
> +  Interfaces grouping of serial port. In multi-channel stereo, use
> +  "2_0", in 3.1 multi-channel grouping, use "3_1" and in 5.1
> +  multi-channel grouping, use "5_1".

I don't really understand what this means or why this is not runtime
configured.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOhExAAoJECTWi3JdVIfQz4IH/0j6pga0sPRPWZOh61JPQBXd
tQfKZpFFqDuq1JoJ57h7XJH9fWf6q8DHz22Y45/GsMg6nQnB8PMpTBJWgQBgxduq
ARL/YWrBd3SLpiYywxpjMdfUsrdg8wC9vqLDr4Y1Dl9JvSSju5hgIupyMJQ6bizH
cChwbkLz8o0VAPmqj3JlBjdVazIkyO3QC+qDlxJ2xK3cVU16X/F/EpTr96QVTzqW
zI2b/UR2g7IqZyxI/GrRk5i0zH3zL97CnGgy6i1qoB3fCTOX35GRVLd1fZhR3DO1
vNiO3c+SScJvT9TSV4Hi0IWjeT/fANBw9YbgX0qthbCbbG+kAkYJzBNraFir4PI=
=9lri
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pcm: allow backend hardware to be freed in pause
 state
Date: Mon, 10 Dec 2012 00:28:06 +0900
Message-ID: <20121209152805.GF6511@opensource.wolfsonmicro.com>
References: <1354819199-28795-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354819199-28795-1-git-send-email-plai@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: lrg@ti.com, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 06, 2012 at 10:39:59AM -0800, Patrick Lai wrote:
> When front-end PCM session is in paused state, back-end
> PCM session will be put in paused state as well if given
> front-end PCM session is the only client of given back-end.
> Then, application closes front-end PCM session, DPCM
> framework will not allow back-end enters HW_FREE state
> so back-end will never get shutdown completely.

I'm not entirely sure what this patch is generated against but it
doesn't appear to apply to either -next or to v3.7-rc7 - can you check
and regenerate please?

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQxK35AAoJELSic+t+oim9V00P/1yFCeAg3gp9Cu2UaVTRZJy+
89AZ20l59C+kTkLWb4As0qJ5O7yiXa/SNcAMWqhZyEZvk7jq78dI+utFbQb8YIVW
Xe7nm/1EMlD8jdWsNiFWAQAFKG+j+DwWIjB1sBm9H7Y8F8J/GEofN51Prf3vt+Nm
7m7vHlrCKNxqnTw6EgF6BOe5+RGDoCEZ7EgqZi+peiWt+72praIYm9ESXM9R+zoF
DtdV89Dr8nb332rB/xrqtNdJr/QkPpdaPgifL+j1gRLuy36gPiv3S6KXlBmPNLZS
CiErKlGc+fZZoECbFY967zI7W/5Wb+NtKDSdhRK6wFtL7Qi86+5mr2FE3vtFTa0p
SyGAL2TF5YmLFlPnSJaeyhK3wnEEM+obZylWXkM6QAFCaPxYP8Su7p7NBFevtBj4
yLll3g+l+sVXZYhLNv/sA1HnnsT0nvMVRCKBmLR3rcg5HayCokO7SfLr1xUSF2C9
EBWcwCTLinhjkO6nrO67xJxIjF/i5XtAxWe86xLQxCnr8cEAAXHa4VZpUbDUVsPi
26y+bZyIDrguc2H4+3rRJkwvv6jxDdF8c1UrHmrbStw6mvoVrkBBlROYrNyxe7p7
IRLgPFQOp650tNXwsbemfBPWLUS1t34KobtWq16u9Sob5O6jQca3GTdf5Wv+cN4V
u4SUlc/nV12p+mzPTEMm
=nE6S
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

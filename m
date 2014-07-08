From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: Provide a CLOCK_MONOTONIC_RAW
	timestamp type
Date: Tue, 8 Jul 2014 18:00:36 +0200
Message-ID: <20140708160036.GA30458@sirena.org.uk>
References: <1404831109-8008-1-git-send-email-broonie@kernel.org>
 <s5hr41vopyt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7967965845334165373=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ADEA2619E9
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 18:03:07 +0200 (CEST)
In-Reply-To: <s5hr41vopyt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Daniel Thompson <daniel.thompson@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7967965845334165373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P6PRkhImOxklJvkF"
Content-Disposition: inline


--P6PRkhImOxklJvkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 05:00:26PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > due to that. A raw monotonic time which does not include any adjustments
> > is available in the kernel from getrawmonotonic() so provide userspace with
> > a new timestamp type SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW which provides
> > timestamps based on this as an option.

> This looks good to me.  Or, thinking of the original use case, should
> we just replace ktime_get_ts() with getrawmonotonic()?  The MONOTONIC
> mode is really to be monotonic.

I'm totally OK with that as well if people don't mind that, I just added
a new clock as the most conservative option.  I can easily respin the
patch for this if you prefer?

> While we're at it: there's been long-standing request from V4L guys
> for improving the timestamps to sync with video streams.  I suggested
> to add a new mode that can be set by the driver.  Worth to consider
> it, too?

Does the wall clock stuff address that?  I've no objection to adding a
further type if the existing ones (and this one aren't sufficient).

--P6PRkhImOxklJvkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvBWhAAoJELSic+t+oim9egoP/0g6Wm3FScaOKNF31joKvleu
oQNXi8+ngXkfsOK+/liwHS3/B8Fc4mQsUKsOJc0t1W5W2E5LRD27IyfG2e6XraNy
ptfce3inrwd9K95F9iaXGgkDV0r2HUvF9O09s4KidQQnqHgCBUwJoGHY2T1wAMVi
yxATW7sUAp/CNIWUGoIp2eZs3UneNlUHhPmp7aORPIERNyM/h3s4NtsvQbMWIeUc
tdy/+/c+iZ+dI9FIUyedlNbBKqJI3ceF9dHO60qCLDZCWKBkGQE0t30iH0bKaAUp
zZtjLbo4O3PWkLLK4iYbu2GkLl7fwYi7VDloh4Afx3h6ZQk0lShGfCSdjVWNq8y8
HcCF3hH3aKbJtxMVBdHUHprBYuZu5Syu1pk1zRm/dCxRXBDIkJSgjCE/jECwuCXS
OzzqRMtiwYTJru0sBrPWDJdazk2qWWUMRYLgKWfLYs4wHpFTDrGRTYkZ4Z6IWdX/
fRLM0beUAGytO1leg6PCRSTt8Wn+FswDR/aWqL/dSrDuaO6LNwOc28ZGHXKTTT1x
gObHS5l7Nqq9dD9QLRZ4FDtNTNp0QGPBjiDyrU4VDOzwMy+G65DC0gootHs0hwc9
dkABsJfK/NZWkyskm936yQByiAIeleovl0cW085Vwhjjqgw0oZugIBD0Poq0lfB1
/ZIiL+eT+WAdzNNmpLP/
=G+vg
-----END PGP SIGNATURE-----

--P6PRkhImOxklJvkF--

--===============7967965845334165373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7967965845334165373==--

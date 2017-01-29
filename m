From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
Date: Sun, 29 Jan 2017 17:50:05 +0000
Message-ID: <20170129175005.2u25l7zd2anlc6tw@sirena.org.uk>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell>
 <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
 <20170124113658.GW16020@dell>
 <a1aaaa20-ac00-b182-f1c1-63152be41135@st.com>
 <20170127101545.g53uah57vgfu55o5@dell>
 <7b3eb38d-4fd1-2006-7423-94f2a7b38b27@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hapx4fny3zdvi7ik"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7b3eb38d-4fd1-2006-7423-94f2a7b38b27-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--hapx4fny3zdvi7ik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2017 at 02:45:49PM +0100, Arnaud Pouliquen wrote:

> Jonathan, Mark, Please could you share your opinion on this topic?

I really don't have enough visbility of what the hardware or software is
doing to say much and though there's extensive backtrace in here it's
not enough to follow.  If it's a generic ADC that happens to have audio
applications then some relationship with IIO might make sense but I
don't know how separate the audio and general purpose bits of the
hardware are.

Please understand that I get copied in on *lots* of threads about MFDs
with drivers getting posted repeatedly for whatever revisions are needed
with little relevance to me so it's very random if I even look at these
things, much less read them with detail.

--hapx4fny3zdvi7ik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliOK0wACgkQJNaLcl1U
h9A1MQf/TRDyJvQa1AT0k+9ghr8Uix9BthcokasfxQBM/I6jauAq7hp3HEPpcTYf
AZ88MjZdxhS8iNgmmZzllGStvUIqgFRkAt++yH0jc0s+KyTRRcM6cZal5Zcii8NE
e3Pui/XMpuoSuaAaS7UKUcy6nnUf43M7QZ4mW866NJvQ1qJSmvJrWqnOODO+IaoC
geSt5v4jGnDOyxhP60llrspideFGs7SpXfHtOK/6G1kRQOslvBGLHtlNwjvr40oa
pRzjZk/loAJ2x0YAq7bA9TkgT7Jjb9yWdd4bTngnmlbHI4b531yjqiPdtRBlQhw3
+O62U1yyrvN9CLGIoQBfG80o9ytlJQ==
=Mbpq
-----END PGP SIGNATURE-----

--hapx4fny3zdvi7ik--

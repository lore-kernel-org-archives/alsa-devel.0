From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4 v2] ASoC: sh: fsi: add fsi-common-codec
	card support
Date: Fri, 6 Apr 2012 18:58:49 +0100
Message-ID: <20120406175848.GN19424@opensource.wolfsonmicro.com>
References: <874nt2aphw.wl%kuninori.morimoto.gx@renesas.com>
	<87zkashytm.wl%kuninori.morimoto.gx@renesas.com>
	<87y5qchyqj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2940184505641290421=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C35A10454B
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 19:58:51 +0200 (CEST)
In-Reply-To: <87y5qchyqj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rafael <rjw@sisk.pl>, Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2940184505641290421==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tfmLD+Hxjexp/STe"
Content-Disposition: inline


--tfmLD+Hxjexp/STe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 03, 2012 at 10:06:48PM -0700, Kuninori Morimoto wrote:
> Current Linux Kernel is using fsi-xxx card driver for SuperH sound card.
> But the differences between these were only value/strings of setting.
> In order to reduce duplicate driver, this patch adds fsi-common-codec.

So, I've been sitting on this stuff.  The reason is not that there's a
problem but rather the opposite - I can't see anything here that is FSI
specific so really it seems like we should make this available to other
platforms by calling it something like "simple-card" and putting it in
some generic folder (perhaps even called "generic").

This would mean that even more people could benefit from your work.

--tfmLD+Hxjexp/STe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfy7SAAoJEBus8iNuMP3dk5oP/3mSu16gL2BQqda761kvgikF
HIhqtUXpDQWmgbQQ6mlNfj1R4XwXydMd7GZSX8wWs9mAlWIouy90tsEv5G07vd10
NWpMOmboii4mAyGeWrbmAWyh4TRO9Bt36xKZ9Sk49+JD/PAe8NLj0YKQHTekiC2t
IkJn6ObxBoLMlTyl/di3zdpRjCZ+xBbAFzJXl2y9A2QRlN+98hoV3kjqpgBkq217
xPlKqUwB29CVp2epu/i+hN47ibMBk5LM0wcdfIeApIbraEnj+0wO2r9APiiaIWTV
H90VFhIdmaEoyerfJXVmbiHdRG9Ufn68LmhS3Po0XPz+pRVLcFrJSLD601TPCe4R
4+x73/Fg0mMKUiXWdmgMR4Ach+gzCA+pVYQenQ97M51xiq+IudH8NyztrOqKyA64
GY89oRAd2bodU+hYIW79CRGrPkOAJ8luhgddjnGAinEaZBWIbOax1riNtCQDr1GX
6ozhw+aISYgWJTFZ8IT1/qttHKaySxi0OKzPdBMVaIHA65Me0weFdpsI+3pUPkVg
uqhHlrMGQz7DOmIHblUYrSEfa6zv5jzwfkQmlzi1fYv84Mg9Gry0XinyMRhTUN3R
9TywX7s+8uqDdb8TXQRSU5n/THGwIclKIsXMZ0FK8k99+61HHTIJuUdTMm276MIU
LSS37rkIFSYq6NI3RSUm
=SsRS
-----END PGP SIGNATURE-----

--tfmLD+Hxjexp/STe--

--===============2940184505641290421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2940184505641290421==--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Q] ASoC: What's the real meaning of
 SND_SOC_DAIFMT_NB_NF?
Date: Fri, 24 Feb 2012 11:53:36 +0000
Message-ID: <20120224115335.GC5450@opensource.wolfsonmicro.com>
References: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
	<20120223151934.GB4553@opensource.wolfsonmicro.com>
	<CACKLOr23+DPp=XZ=RJEPgKYyvw3UOxkWR8xtzYG9Y9NWcicJSg@mail.gmail.com>
	<20120223161446.GA7245@opensource.wolfsonmicro.com>
	<CACKLOr10yUYpMSrebnLvMkc=XQLUXNDxwM+P6U8ysH_Xre3Tmw@mail.gmail.com>
	<4F474B97.6020407@ti.com>
	<CACKLOr14EHqGWcYCfLK0WXiVZsewDVyFPV2tpfYJK4tBZKMUXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3929743865783370328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1709524597
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 12:53:39 +0100 (CET)
In-Reply-To: <CACKLOr14EHqGWcYCfLK0WXiVZsewDVyFPV2tpfYJK4tBZKMUXg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org


--===============3929743865783370328==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 12:05:09PM +0100, javier Martin wrote:
> On 24 February 2012 09:34, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> > I don't think it is going to break. I would guess that the channels are
> > swapped on these machines at the moment. If you correct the CPU dai
> > driver the only thing that will happen is that the channels will jump in
> > their correct place.

> That would be true for stereo. However, mono should not be working right now.

Mono isn't particularly defined for I2S at the best of times; the
clocking is inherently stereo.  You may just pick out the left channel
or you may duplicate things on left and right channels (at which point a
polarity change won't be noticed).  I wouldn't worry too much about it,
it's better to have things the right way round and fix up configuration
for machines that need it.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR3opAAoJEBus8iNuMP3dUCYP/2nuVnThs8r+PSvLgL2y/p0C
pfqvbAogtDhUwnJfvjOyJMr8+WJT3jHAKK2f4MFkQ+FDs9DvktqFUzUjIE1P6oCQ
iFs+2QNlM4P7KwIjFpVT/C6Uk1i6n3cqbucwj0v4KgxheVJrGidiHBO46bemYTHs
tL5dpfKwR4IUqbLM481SrVyhKymGlexk5831uucqUC14nCq931FQWmq7AmoCPPhw
wfT6dxuBx/cwjZikStPgZ0QGPNiP0uaDByQb2oZ4txWUzicLdgZnmKPtXs+xRjSE
colYpO2GWrU9Fyyg5LQ0McMJ6EgeeRxW1phB9hOMHIUTDFWnv5ejW50YIQTZZ7Kj
wxLF9176Hs5LDWUrIIMB1jOO6N7FU7jEwUcPyA51l85pQh47ygNN3+5CQlMIWUc8
75fhrdMny45WEamKaewD0lct53yjSrpf+xVfKWD1nt8xxQ4St7og7b0YsvI5l8eq
FLdIi8YVEdZzBorhNECZsPScjbgkkpJ12revZvoDxsZ2QY4qCjDbT26RrplBg9St
P/nYg0QWY4mM5nay+W8iLwmLOqHfnADiryKhzm8JuOvNrc618kEflSoNcHAXsTB7
iUmDxKVKc0DUJsl6ZIxMQxfI/3oqZ+ygQU7RPt9r+66hKA8KiqOTWJP8aDS+iklZ
FG6jtRAz5aF/Wr9bksQm
=8Su0
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

--===============3929743865783370328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3929743865783370328==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8904: rework FLL handling
Date: Tue, 23 Jul 2019 11:52:48 +0100
Message-ID: <20190723105248.GA5365@sirena.org.uk>
References: <cover.1563817201.git.mirq-linux@rere.qmqm.pl>
 <3e104cf18cb4e26096f0fe065a2c0e80373f861c.1563817201.git.mirq-linux@rere.qmqm.pl>
 <20190723082716.GM54126@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0666719488422948264=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A943F80227
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 12:52:52 +0200 (CEST)
In-Reply-To: <20190723082716.GM54126@ediswmail.ad.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
List-Id: alsa-devel@alsa-project.org


--===============0666719488422948264==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 09:27:16AM +0100, Charles Keepax wrote:
> On Mon, Jul 22, 2019 at 07:57:21PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> > Extract and rework FLL handling. This makes it possible to reuse
> > the code for other Wolfson codecs and makes codec adapt SYSCLK to
> > exactly match frequency required for used sampling rate.

> Do you have thoughts on which CODECs you would be including in
> this? These older parts often have small differences between the
> configuration that might make this challenging so if you have
> plans here would be good to have a look from this end.

Right, it's not like it's the same IP being dropped into multiple chips
in an identical fashion.  There's a lot of high level similarities in
the register interfaces but also many small per device tweaks, and it's
not clear what benefit we get from refactoring at this point.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl025v0ACgkQJNaLcl1U
h9DOowf/WDgZBySU0jWlg/QFS4oUrBe7HjNw+NaR6p/jMVG5sH32OA6j/bqDQqSa
azket/qyOR7WAAIo6bPHx/XC00MsPnE4AD5XONbzqDCs/KnksYKxES9J5xZl3q2I
vYcrFTFzwgrcmhseRBIsBSWhyhs4KdnehDwRjGM4T1TPxmREvd+j7jKl6fT9CNUN
7MGfsIyje8IB/0epyP7Cf9yLq1DtZsY25ZYSCOLG/UevvLVHZaylG+NHqaKk9s+L
aZySTA0/7RkajswN/oEuNRfB/+oef1xYe55kZff11pxv45k5ot6kzfJxBkso40hv
70tjPno1LOppgb54+216zbt8/nNNmA==
=/SRd
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--===============0666719488422948264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0666719488422948264==--

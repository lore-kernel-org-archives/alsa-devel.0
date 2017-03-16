From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/4] sound: bcm2835-analog-audio: Add
	driver for bcm2835(Raspberry PI) headphone jack.
Date: Wed, 15 Mar 2017 17:01:10 -0700
Message-ID: <871sty1455.fsf@eliezer.anholt.net>
References: <20170312063820.19313-1-mzoran@crowfest.net>
 <20170312063820.19313-2-mzoran@crowfest.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5567183529092391332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id DE24B2670AF
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 01:01:17 +0100 (CET)
In-Reply-To: <20170312063820.19313-2-mzoran@crowfest.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.co, stefan.wahren@i2se.com, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Michael Zoran <mzoran@crowfest.net>
List-Id: alsa-devel@alsa-project.org

--===============5567183529092391332==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Michael Zoran <mzoran@crowfest.net> writes:

> Add driver for the bcm2835 analog/headphone jack which
> uses the PWM hardware to generate audio.
>
> Signed-off-by: Michael Zoran <mzoran@crowfest.net>

ALSA folks: is a driver like this acceptable?  In particular, I'm
wondering how you feel about the in-kernel munging of the audio buffers
to something appropriate for the PWM hardware, before we get into review
of driver details.

This driver isn't quite a replacement for the closed source driver in
the firmware (couple of notes: firmware seems to have some dithering of
the audio values in the sigma delta modulation process, and a priority
bump on the DMA because the PWM's fifo is tiny), but I'm definitely
interested in us having something like it in open source.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljJ1cYACgkQtdYpNtH8
nugQfRAAlg2e3XFcDVnW00ELhBEiAQfdJ6JOCIGLwWJdSmy565r0J3VR2h0rqMyC
MGgYhdVoH3A2S6lvvADSvnzwRjhNiOGhsh4Qj/pW6tHqz66ULNdhSdxey94RFOUL
468Wj/fYoSjUP9qOl2DT95BcCkQyyT/w4b98wNk7yV4GaS29wDo5LWJCaX0YiTvJ
hQ+nluoJiJ609q0QbHvGEw444Fw9iXAsk0FzW/QNOx/OprfJe5d3jaDMnwOM7HJw
ktxyr6ib4+xNVN7WOVOgZlUEhB+yoHrhWGicTKQGzdv8vnQIgukOgypte38tnH+p
AkzLn5gZ7gkioI2NOGgm6hBMbdRd8K6ZIdU+9m2Qmeq20wiVS65zf16RPUoIgPDx
gCxHkASFUxgteINsJ4kg5/0kQ8zDn8KHSDhTNQdpkH19vgx8nBpVsr+l3NR970qN
6R31PrJS4Wd9AT1m8SSh1gtvoddxVns5QuE92Aau/mHOJ2HBvTfdwfQqrxfv24Pu
n+lRM3ZzeRcuSOexmg8voujttR6Yga+djeXOS5OXMVt6WYpRGGsXAPVsEKaiH6UK
t8e+WMZ3OWnqih2KHHIres6XX7ntcVr7KGFFTuGaOitVs+A7S4OzRiJWaKCdcBzi
wqdwi4PSJ8Qru2PAzMuwStBz5DFYS7c9pmwIXGp7TSo1zCo3pfY=
=4RZK
-----END PGP SIGNATURE-----
--=-=-=--

--===============5567183529092391332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5567183529092391332==--

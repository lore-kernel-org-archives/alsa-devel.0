From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Tue, 12 Mar 2019 15:03:00 +0000
Message-ID: <20190312150300.GE6983@sirena.org.uk>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
 <20190308172235.GA31189@sirena.org.uk>
 <25dec9c5-af5c-bc54-89dd-2abdeffa9f82@perex.cz>
 <20190311081546.GA8324@workstation>
 <e9ce6844-8239-63a7-1855-7f47ebd97723@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0070201644819477833=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 221E4F806F5
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2019 16:03:04 +0100 (CET)
In-Reply-To: <e9ce6844-8239-63a7-1855-7f47ebd97723@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============0070201644819477833==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2019 at 04:43:39PM +0100, Jaroslav Kysela wrote:

> I would not use any of the "user space" ioctl API to represent the
> hardware bclk requirements. The applications should know just the DMA
> memory layout.

> Also, think about the multiple simultaneous paths for the audio output
> in the sound controller (so one DMA from the user space to the
> controller, but the controller can do multiple simultaneous outputs
> using different clocks combining different wire buses or so). Yes, it's
> the corner case, but it's another reason to have the bclk code totally
> separated from the user space ALSA's PCM API.

There's also a range of devices that either don't have visible buses at
all due to integration or which are on buses that look nothing like the
I2S/DSP mode style of bus, rendering the parameters meaningless.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyHyiMACgkQJNaLcl1U
h9C1lgf/bPRMpiIC4rCVBkCQlA4Gm6guRqBKxzYVzLfKa8OqnCn/oJu0KFI8PWbw
oidJA6/Iv4pYKxL3T3+jWKKSV6WKLkN0WbysvX6X1SPg7jaKnkR29AxXcjyzBvUK
2+4hqXFpPscYu3oz1yLa7Ezcbc75VNaIY1PwuXKTudwzFikf/I7LEr1MzD3JetqG
sjNBBZSgW7Bc3P3j9LyJuRtodvYNhI04X7czV/cdLdOgWBeRWt7vd+z2Q9Q+5i3w
8lo5DnPPlAqC+E+khofGLfgsB3bRV+5vL3ZKDWEZ3dQ+1bBxWCwl655kIBjdtH/O
y3TJFcGUTdzee6CJlVIivcvQuIF2Ug==
=GxPZ
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

--===============0070201644819477833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0070201644819477833==--

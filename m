From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel_pcm: use endian agnostic IO
	accessors
Date: Thu, 26 Mar 2015 10:17:01 -0700
Message-ID: <20150326171701.GV3572@sirena.org.uk>
References: <1427383681-3537-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5749441011778866061=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D47BB265750
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 18:16:49 +0100 (CET)
In-Reply-To: <1427383681-3537-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org


--===============5749441011778866061==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uzkapz4/HjIvV4VZ"
Content-Disposition: inline


--Uzkapz4/HjIvV4VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2015 at 03:28:01PM +0000, Ben Dooks wrote:

> Note, I do not think this is being used in the AVR32 which
> would require a different fix (possible after atmel_io.h is
> merged).

AVR32 uses the same code - there used to be separate at91 and avr32
directories but we merged them together into a single atmel directory.
I don't know how many people are *actually* using the code on AVR32
though.  Is this safe for it?

--Uzkapz4/HjIvV4VZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFD8HAAoJECTWi3JdVIfQ3RoH/14YNcypQTnpthqIJ6BvhrM7
dS/11NbBWj4nTj3RG1h2qmLXm71qK/D4+rjJ00qeSUKJ22Y34gUwRih7m9Vv6QET
3+M1zfaId3NKL9/gfXaBpaSnzIoHYBOKJh5XwP+Q6jztEFqpgR1QxDQxCLr8/LIK
KeDgfxeX/M6+I+dpwCRXuuoNDY2Lawvvrq6toH9MpIGv0UL+OG7tfFzSYf8YNE1D
/4RjBn/DgaJjm/PpuuidHIADRDad797jK0JgWr/zaTSS0S9Emt145PWp3JGbCm7p
lVWI/grQPDJDWt8lq1ySg7oak/594WXxG1xs8OuYyV9jFCgziB3/qkLhTDrkZnk=
=+LGR
-----END PGP SIGNATURE-----

--Uzkapz4/HjIvV4VZ--

--===============5749441011778866061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5749441011778866061==--

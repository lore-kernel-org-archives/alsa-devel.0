From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V2] ARM: dts: bcm283x: Fix probing of
	bcm2835-i2s
Date: Wed, 06 Dec 2017 13:53:42 -0800
Message-ID: <87po7rr09l.fsf@anholt.net>
References: <1511717111-6055-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4414589254701307937=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BBB2267044
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 22:53:46 +0100 (CET)
In-Reply-To: <1511717111-6055-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@martin.sperl.org, Matthias Reichl <hias@horus.com>, phil@raspberrypi.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============4414589254701307937==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
>
> This patch also fixes the dt-bindings accordlingly.
>
> Fixes: 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Tested-by: Matthias Reichl <hias@horus.com>

DT folks, are you happy with the binding change here?  It fixes having
the i2s node also map a very separate hardware block (clocks) which has
its own DT node.

The I2S node is disabled in the upstream DT files.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlooZuYACgkQtdYpNtH8
nug+SQ//dcABfzgWhXBV4bEF5AKgd04BPnhHxcK/s9QilpFdMsE99JZr5U/YyzdB
bAlGOZwdwWeYFyj8O31pEldWPrVns41nduk8S8O8bfKgIVPrRSDXz5GvF3MnBp07
0n9ZzzK+VTWGQFXVtUB0z7hUx7ifHmJAswQTwc28lszbbuho0Oj7WaDTMXqu0HrJ
qNRVf5gDFdFK7JO+nzbXPyzk071sNerdKqM3wdVkXypV1jv2Ru23B4MAnA3wHLrF
0h7wHW9r8EaNgQcRStaAZgQvEl/LkxKyJDx1BYPhHO4U6NRit7laG9XQ6Df9vMEr
PCdlWOWFVMWKFeHJcJr1/fDLGDkq9zS7wvTaPt1nq2qV6aKsFgXLfP/sZZ8fKJ2v
5psCrTVpx3geq2BwwbBLm6iAVLv4AQ3xs1ZqAxcK51BkHp1iSxAzirT65s+Cvp0T
EupRSG9hK89VXi49DphoO1zvX9wJu1y4imq0lLki1T+DtR6uo/FVTJgHqD8Dj6WO
6t2Zmvc5j70DSRL3mlQ1DmdZ3B0yFRdyooGHauCuCjrn0PBnFKQGyaSdaGbtRsMK
58tTPCrzAxU21kvfMTMHwfPBL75U2cuUaIU+dNlyFxk+iPKhYPIIoOo9N3VjiHGZ
upopJXxrgWdPWjRjCUn6DXpycKonRyC5ui2lKWniLxWggXD2/gY=
=xJNs
-----END PGP SIGNATURE-----
--=-=-=--

--===============4414589254701307937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4414589254701307937==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Tue, 2 Jul 2013 13:13:45 +0100
Message-ID: <20130702121345.GL27646@sirena.org.uk>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6469699118543909019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BF97E265463
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 14:13:50 +0200 (CEST)
In-Reply-To: <51D26A18.8040903@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============6469699118543909019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="afReowZ/oS2gITrV"
Content-Disposition: inline


--afReowZ/oS2gITrV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 07:50:16AM +0200, Mike Looijmans wrote:
> On 07/02/2013 05:33 AM, Joel Fernandes wrote:

> But even with much lower loads, I got underruns when recording to SD
> card that I couldn't really explain. I noticed that the SD transfers
> took up a lot of DMA params (about 40), so maybe that was just
> causing too much work for the IRQ or DMA handler routines.

SD cards are generally just slow, it's possible it's just not able to
keep up with the data you're throwing at it.  Things like batching the
writes up into large chunks can help here but you may just be hitting a
genuine limit if you need to record for too long and don't have enough
fast storage (like RAM) to buffer.

> This meant I had to use a DMA PARAM slot for every "period". The
> OMAP L138 has 128 of those slots, so it's no problem to use a bunch
> of them. Because the chain is cyclic, there is no need to update any
> DMA parameter while running. All that ALSA needs to do is empty the
> buffer before the cycle completes and the current position gets
> overwritten.

This sort of cyclic thing tends to be best, ideally you don't need
interrupts at all (other than a timer).

--afReowZ/oS2gITrV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0sP2AAoJELSic+t+oim97qcP/3vsnruN9G5Xdvj+4P9jGrth
5IPAtsdLZOqStxzDq4WnfRBa917kVNPJL83JEuhcp6dCljutQlpY9mUEMyN0If3a
zpC0OFX8o3LWcuq5gylfWx35lZkaXqCX6yAobh8cgchYCjC9NKeuMmnzxAuGQhqy
cy5wzrufXOK/AIP6Qt3Fs+jTjva6BjhwH5zyk980LmII6NbkV3UxlYODJxnnvsY4
w0IIgu8phCteO5egUS2P4/gbw3dm/aRJpk5nQv1hy97uke2Z3Dn07Bqbp8bPzo2I
XHu3vt2DUbHT3AMhKPQ9h2Ocq659GdBnZqX7x9boQfTMUS2cRL8sNdXi3oszO4QW
g4kdaVSp5u3vn0CB82vVTh5VKI2oJB2gnlwtShe8CqqvGx/REUCSILS0Wjm6TebS
6oCHBORtFpdSlE49OP230i4YGzWeERSakXrcX2LxgBcnrPd99gI+ilLxO+/Qu90W
/S0TM6I20hhVDO0q/npX49sH/gxImiOBj9PCsNGjNmQZ/48aITowhyt6Wb33H4Ak
7NIdO/lM+CVuExMXgWWRmE/CaI0sXRg4qR02crOLv8wLv+CMc+8JJxZ7p2cpZLUb
+klN1N4bGpgsf9zRh4x4yvG3Hcva+0jT0hhtMXImXmz1bIQb7YFQr4o9X3Tn0LRY
2pyYm8xsXiFdhN2xAlAl
=XnNM
-----END PGP SIGNATURE-----

--afReowZ/oS2gITrV--

--===============6469699118543909019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6469699118543909019==--

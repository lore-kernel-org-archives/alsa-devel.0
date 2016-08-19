From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Clean up DAPM before the card
	debugfs
Date: Fri, 19 Aug 2016 19:11:23 +0100
Message-ID: <20160819181123.GF22076@sirena.org.uk>
References: <1471545449-29516-1-git-send-email-broonie@kernel.org>
 <20160818232642.GF1041@n2100.armlinux.org.uk>
 <20160819175003.GE22076@sirena.org.uk>
 <20160819180452.GW1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3717402301004482490=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F3AA266605
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 20:11:40 +0200 (CEST)
In-Reply-To: <20160819180452.GW1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3717402301004482490==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2016 at 07:04:52PM +0100, Russell King - ARM Linux wrote:

> I think it was something like the following, but I don't remember
> off hand without re-running the build that caused it and booting it
> again.

> twl6040 0-004b: Unable to sync registers 0xc-0xd. -121

...

> That's probably not regmap's fault, but something else.  I guess TIers
> need to dig into that one.

Yeah, smells like an I/O error - possibly attempting to resync before
the I2C bus is up or something?

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXt0vKAAoJECTWi3JdVIfQmAsH/0/Cyh/UQrYVHilIhGXCDMqE
mOALkyQwflirCB3s60+4U6p8wu27k88/eGBazSWbz1BgiqfHmVnPLJGC0IeJ6iP2
WbPBCuzEUeu/h4WaKYaG7rXNexHqNft7ypTlVX+mNDhbVe3Vxe99F0L988qgs9pX
mDyLSFh+ZnSzg8sz5lGMa7ScDufjLsM2HjbThuQtfa0heelXBDfpiZVnarhYvkm/
uItN8vfRMBWM83fdZpjhxDOxFTWtljt+nVNcTKEZcq/MYb/rWdtDk73VH5p2k7gf
BaeZWjEv3I8wWa3rxIl32jTt7pVJC88judodFg5dogmfaPBlf/i27Kjv4n46Zi8=
=3iJL
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--

--===============3717402301004482490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3717402301004482490==--

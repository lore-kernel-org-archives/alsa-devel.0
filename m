From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: Remove "select
 REGMAP_SPI/REGMAP_I2C"
Date: Fri, 17 Jun 2016 11:30:55 +0100
Message-ID: <20160617103055.GB26099@sirena.org.uk>
References: <1466103612-8424-1-git-send-email-shc_work@mail.ru>
 <5762FE86.4090005@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3588819577045620574=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81B0B26154F
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 12:31:09 +0200 (CEST)
In-Reply-To: <5762FE86.4090005@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3588819577045620574==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 16, 2016 at 09:31:18PM +0200, Lars-Peter Clausen wrote:
> On 06/16/2016 09:00 PM, Alexander Shiyan wrote:
> > REGMAP_SPI and REGMAP_I2C is selected automatically by SND_SOC,
> > so no additional actions is required.

> To be honest I'd rather have this the other way around. Remove them from
> SND_SOC and let every CODEC select them individually. That would be the
> technically correct approach.

Indeed.

> Otherwise if we want argue that a system using ASoC has probably at least
> one CODEC device that either regmap SPI or regmap I2C and that's why it
> makes sense for them to be selected automatically, we can also argue that
> these days any system that has SPI or I2C support has likely one device that
> either uses regmap SPI or regmap I2C, so they should always be enabled.

Well, the reason it's selected at present is that the core has some
regmap code (but that just needs plain regmap) and the legacy code for
the old ASoC I/O being backed by regmap.  We should be able to at least
drop back to just selecting regmap alone at this point, restructuring
the code so we only include the regmap bits in the core if regmap is
selected is probably more trouble than it's worth.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY9FeAAoJECTWi3JdVIfQoRcH/iM61fKp6u3pwoJhraB3Uhp0
8p0XqtT6FSAgdQZnJwBzJF72gVozS+AVSpYD67AmMsUPxKBvbil8TddYgmewPC/Z
VeU1GJd7WHNuWOJoppaPOI3KSnZMQI2nS/QOz74dEKKr8bJ/LxJqddNULO4LPmjQ
x+HyeOUoD9oWHKfwx7DU39UJRUJA63ctjdaAjk1b+S1omtGy112A8zEQs18xUj+p
K+8NiZ/+W0arf7LAugm4eTnMtaN6ly0aMRuqoF+eiOSzeCYc+RvsG+L0dhtD/vH0
Wl6fHz3cDPNeTDM0AH9XM6j3CMtYDBrxhCaXMU6ADoqIKJMUssMewKplpHKJUZk=
=fFlB
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--

--===============3588819577045620574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3588819577045620574==--

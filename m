From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
Date: Tue, 20 Aug 2013 19:50:19 +0100
Message-ID: <20130820185019.GP30073@sirena.org.uk>
References: <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
 <20130810211342.GX23006@n2100.arm.linux.org.uk>
 <1376293215.2385.32.camel@loki>
 <20130812082837.GB23006@n2100.arm.linux.org.uk>
 <1376405952.2617.101.camel@loki>
 <20130820102555.GZ23006@n2100.arm.linux.org.uk>
 <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5622098818678892112=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C61832651DC
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 20:50:30 +0200 (CEST)
In-Reply-To: <20130820133143.GC23006@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5622098818678892112==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kqbdc5qIhvft+WjL"
Content-Disposition: inline


--Kqbdc5qIhvft+WjL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2013 at 02:31:43PM +0100, Russell King - ARM Linux wrote:

> Let's be a little more clear about that: I don't know how to do that
> because that's the approach taken by _these_ very patches which you've
> rejected for "abusing the ASoC core".  That's why I'm asking Liam

The patches I can recall seeing recently have all had some workarounds
in the core which would need to be resolved differently, though it's
possible I missed that being done in some version in your mails as there
have generally also been a lot of modifications adding debug statements
in the core.

If you've got code you think is in a good state to submit then please do
send it as a normal patch series, the last one I've got here has "ASoC:
HACK: avoid creating duplicated widgets" as part of it for example.

Just to be clear when I say either/or I'm talking about a DAI driver
that can either run in S/PDIF mode or run in I2S mode in a given machine
but not support both being hooked up in the same machine.  Obviously
this isn't the end goal but it might be a useful intermediate step if
you find you are are blocked.=20

> Since you continue to refuse to take the patches, but haven't given any
> further reasons why, and I've shown your original objections to be
> provably false, you leave me no other options but to try and bypass

To reiterate please submit patches if you believe everything is OK now
and then let's go through and review them.

> you, especially when you have plainly stated that you don't care about
> Kirkwood stuff.

I think you'll find that anything I've said along those lines has been
in relation to your strongly worded requests for me to make changes for
you.

--Kqbdc5qIhvft+WjL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSE7poAAoJELSic+t+oim9hMsP/iPXZ+PPrt/zlCot5HEAzGXF
pnEzHLB15WvY26o8GmDKerSCCaDJLq1rktOtUDKSNcclRZVsPufu1HJTdbrds3+e
RSosCGKc7DFbiCIYERfn3IqTE8RY3RdN6AggIB4Q0290rDw0QT/wK3gx4rnte588
fsMkHopKG0Ecn5AG4vJSClVO+PgXbWe2o3imfn5Qq0vywLgUrcc12/a05RdP1vlG
aEjrMaoSePzudXyvh/3HIwAOF1+kolN6SRj8pUtuNQe189PCKPyUDdVryiOo+ZL+
uHV+IqUDmyfJ0rLdNaSogZyDgqPizN7dT+6y4R/ZfJLd8gbuOV4nFp6zRdNLFmhf
VPIQ9rf9l744J59R6AYY9K61v5sDMYMq59Uu1Izn984nibPS7I3qQrREykVXsJZF
HyK7G0qTZHZsb1JgkL0XDrV5K5c9kjYOBnFaHabqk4Dhg+YVcKjXR5rveFA3GxVC
xa0yiSF6/Bw1nJr5QLbvqh/8NfHM7zd6jTtwX1arti98J9vC9ykM454Dj0X8hs6E
t1CHcPCu62JROg9vJCiO9tfZVuB3W1z6QpQ/fmN5+O6gdAriNsJFf3a9K7HSz2aN
ZdbEocG2nZiMB4DSNmb/slC77UqTfbr3ZlBhLqpxeyHHDLLW+orjQH8uJI/7+QSp
bI00SC+wI40jfpoUGrPI
=ABTX
-----END PGP SIGNATURE-----

--Kqbdc5qIhvft+WjL--

--===============5622098818678892112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5622098818678892112==--

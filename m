From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Wed, 15 Mar 2017 19:01:08 +0000
Message-ID: <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
References: <20170226144958.GA5543@camel2.lan>
 <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
 <20170226221648.GA10974@camel2.lan>
 <7cef41ee-ef00-22b7-830f-517a9d594ed0@flatmax.org>
 <20170227080433.GA2718@delle.lan>
 <170950f7-354f-e6a9-cefb-834a00fadd1b@flatmax.org>
 <20170227103024.GF2718@delle.lan>
 <7b78c782-28e1-4849-5d00-8caf30847d5c@flatmax.org>
 <20170227115108.GA6732@delle.lan>
 <20170228095929.GH2742@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7790394976269023000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BFAC8266872
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 20:01:26 +0100 (CET)
In-Reply-To: <20170228095929.GH2742@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Eric Anholt <eric@anholt.net>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Matt Flax <flatmax@flatmax.org>, Matthias Reichl <hias@horus.com>, florian.kauer@koalo.de, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7790394976269023000==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="chqdtwvielyvtqqk"
Content-Disposition: inline


--chqdtwvielyvtqqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2017 at 09:59:29AM +0000, Charles Keepax wrote:
> On Mon, Feb 27, 2017 at 12:51:08PM +0100, Matthias Reichl wrote:

> > > I have a bcm2835 (Pi 2 and 3) SoC here. It is producing multichannel (8 out,
> > > 6 in) audio. In ALSA we call that DSP mode - right ?!

> > No. DSP modes are protocol/timing specifications as I2S, PDP, S/PDIF, ...
> > You can look these up in datasheets and if a chip implements such a
> > protocol you can be sure that it adheres to that standard - i.e. it
> > will sync the frames to the pulses on LRclk.

> I agree with the thoughts in this thread really if the AP doesn't
> actually support DSP A mode we shouldn't add DSP A mode.

The trouble here is that this isn't 100% clear, the specifications of
the DSP modes are such that only one edge in the LRCLK matters and so
providing you're doing mono or have exact clocking they interoperate
perfectly well.  We already frequently do similar things the other way,
most of the programmable serial ports can't actually do I2S modes
properly and rely on exact clocking to get things right when operating
as I2S since they only sync on one edge (though they can generally
generate the clocks correctly when operating as master, they just don't
pay attention to the left/right switch edge).

That said unless we're doing something with the data layout or similar
configuration there's a fairly strong case for putting the mangling for
this in the core, something like just falling back to I2S mode if we set
DSP A and so on.  Which would be a lot nicer if we actually got round to
putting mode capability information in the drivers.

--chqdtwvielyvtqqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljJj3MACgkQJNaLcl1U
h9BH5gf/cd4khu/srdSy7HxgS9nfeaWs5m3Zt/+oDcpkWV2S76vvUmz1bLX1P4En
bqd+cMPSn72b6/UbVLDFyXEoJeZFC5OSTD7raY7liTYb7sPrJj3vANJlTpM5HgSi
auL8ReK4GDVeXWydDgZygmwVFFljekbKCwB8OD7XDoKm/pSK18POeSXOxE0HB9cJ
z/O8WWLRnY54XbRNu5hL2jyXL9M4TEN5rA6z+XUf90hwb6xVxfHY5eUOLQ0booZd
uURxR3mbj7JxEdrJoclLv7eURqxIXU9oXWBvtjQaferFCztIQl6RxDM8V6jgBoXB
Ha1TzpJZp56Nsw/1L2Nbwvmlg3jPpQ==
=9fN4
-----END PGP SIGNATURE-----

--chqdtwvielyvtqqk--

--===============7790394976269023000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7790394976269023000==--

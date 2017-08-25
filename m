From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Fri, 25 Aug 2017 14:11:03 +0100
Message-ID: <20170825131103.ow3jwntmeshczhff@sirena.org.uk>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
 <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
 <s5hh8wxjarq.wl-tiwai@suse.de>
 <20170824154947.li6yke5vv5llcxhh@sirena.org.uk>
 <s5hziaphrof.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6796187071956000683=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BB3C266EA7
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 15:11:43 +0200 (CEST)
In-Reply-To: <s5hziaphrof.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6796187071956000683==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cvu5lwoav2ldachl"
Content-Disposition: inline


--cvu5lwoav2ldachl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2017 at 06:11:12PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > But the id table is already empty...?

> > Right, that seems like a bug though.

> Well, that's what the commit ddc9e69b9dc2 does after all: it cleans up
> the legacy usage, and moves all either OF or ACPI matching.

Which is broken since not all the world is ACPI or DT.

> If we want to take back old i2c ids, better to put the explicit
> i2c_match_id() check in rt5677_i2c_probe() instead of sticking with
> the old i2c probe callback.

That's what I said, yes.

--cvu5lwoav2ldachl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmgIecACgkQJNaLcl1U
h9DDSwf+KU/FQFMxf2dDsZRXMd1o5FXHZjFDDUBDOStO0WqvUG8AwB2UfdAyk66s
ygt6iUujLiIGYxnuzYiTr7HT2utID2H6h+7HdI8NIyrpcN6QvqmOOozfpmYlrXb2
mdaimEf6NZF0/COpF9WQqxksOoEuyxv8dvRfL9DxfEF+t7lYv7FIk4mnvcdZjxLy
4WsYgRlQZpbU16+1AGn7qBS9kj7OTK8M0QwCvIrtG54zgNaJpY7FOB8B+SowMEpA
ZAWOyNumdnHOt7w8mzBRL0wPh08plIDicqfigc52Nj3okve3ax0VWB6E5pGb0ftW
z8ieHhf8ZM+A5IPlwyD8i8sIoqBSLg==
=NgHV
-----END PGP SIGNATURE-----

--cvu5lwoav2ldachl--

--===============6796187071956000683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6796187071956000683==--

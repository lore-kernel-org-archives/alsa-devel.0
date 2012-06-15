From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [pulseaudio-discuss] Using UCM with PulseAudio
Date: Fri, 15 Jun 2012 18:34:42 +0100
Message-ID: <20120615173441.GN4482@opensource.wolfsonmicro.com>
References: <1339728813.5228.48.camel@localhost>
	<1339762287.3007.127.camel@laptop> <1339781331.7609.36.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5885604799071886039=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B582B248A6
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 19:34:46 +0200 (CEST)
In-Reply-To: <1339781331.7609.36.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Tanu Kaskinen <tanuk@iki.fi>, Arun Raghavan <arun.raghavan@collabora.co.uk>, jankovac503@gmail.com, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--===============5885604799071886039==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 15, 2012 at 06:28:51PM +0100, Liam Girdwood wrote:
> On Fri, 2012-06-15 at 15:11 +0300, Tanu Kaskinen wrote:

> > This sort of hardware causes trouble for the planned routing system, at
> > least as I have envisioned it to behave. My vision has been that the
> > routing logic in pulseaudio would enable and disable ports based on the
> > streams that exist and their properties. In the OMAP4 case, there aren't
> > any streams created when a cellular call starts, and therefore the
> > routing logic doesn't know that it should do something.

> This is quite common in the smartphone voice call use case. A lot of

It's more than common, I'm only aware of one phone design which does
route the audio via the CPU on call (the N900).  Anything that can't
cope with bypassed on call audio is going to struggle.

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP23IoAAoJEBus8iNuMP3d48sP/1ZOM+Gjble4dMyYXlhCzhUd
hT8XxD7+WhM1XVAU2M84ywx5LyoIb/aR1906Q28Bcd91wocA4ke3L6K+ez/I6e4J
SH/DnHiI+pKPzqTgTZppIS6u6IejIPCsYhAZIUTg+2RzuNJ4cPE8gOuwT1bHWR9L
loY4QBtUL8obdfOBV03CVSrRvBTZNENx50bXFgqgjnNihmNRHdPuACJVZG0sf4A1
4xf1K55lRReURK0FhlrS2ud9893HA9gODJ7iGQTBJNMGqk+dYeE9ns8EPjtbAryv
IoD+8U4VEy+dk1Az5/NBihNK4SG8ZepZ/0NPpu5r9AKzvj0CMd0lh4VqZoovZby4
0e8gfd7Ydo4dm606tg8GxfCAQJkUqP7+cKxOB9jrqWJ6paK3Z4QFPASwwImx6Lrk
d/dyCOxVzhaz6fbb/MVwPnw7ysXyrCcmqkfwHfHpNNEjlFoLEG6ZAPaPzVLtH66A
HEHiT3EEmoESPThUOqXinTMcoYRIbul/XibTrQ8vdmkB7CegJr4/b6xCjMSHBgLi
84BVnUXBHNFtqGifZ1qVNC8h4Kv0aR++D96oixeJ0p0PdQj0uyHtIBl9xKi6nXEs
PYl3W9bhcmUI/PkEf43gAHlglzkOyCMUMN4sCzWQlUsjvStJWXAjxDBnpuLWsLDA
kkc2gunAhh/7x8haTx9u
=9mqM
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--

--===============5885604799071886039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5885604799071886039==--

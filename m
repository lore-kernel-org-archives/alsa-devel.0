From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/11] ASoC: intel: Don't set unused
 struct snd_pcm_hardware fields
Date: Thu, 9 Jan 2014 14:28:00 +0000
Message-ID: <20140109142800.GX31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7482008375480897721=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 325F0261B2D
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:28:08 +0100 (CET)
In-Reply-To: <1389014356-7014-5-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7482008375480897721==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AmqcT2pvsOLWdLHT"
Content-Disposition: inline


--AmqcT2pvsOLWdLHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:10PM +0100, Lars-Peter Clausen wrote:

> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--AmqcT2pvsOLWdLHT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzrHtAAoJELSic+t+oim9MdAP/j55yCXUvhv9JAImrwqCsLD4
S37xPpVGQNjAFME8WPpLwis4YVIr2L2lVp1Kn/syJBjSBIPk26TBhv2ppCjEgB1j
N8KDWV1RgGXl2OuLOSHrfri8GZU9fVdc2TCKKlDFHOghnzOuoFjQ9AqSSrhKK0fT
INBM8gQRrX0cGgLX/gkXuRpmpmZQLheNxHbNe6qybq6vmVdEcqva6pz9G1kUpiLk
E30ONt7wditOiZrTI+jISVozKztHKFqzotdZYwL3vahL9f4CGAtO5Uzlzav/jLjP
SCUs9kArLgP/Oc9pmS6f/W/nYZurD/esn0GUOiKjtNUUoDVBEhK0xMEO/3Hmutiz
mbDFTUZDYA9SxVzdCG1bHkZckKp4Ugr7U1k61Y03Z2RYUVKiVcwQBQkSmdjOQjb3
GgQ+pb4IE2Rjw5jI+QaNLmRikytBFewPQDq4l+koURfUmomRLXOt1ZvxE0NrWLSn
p185eaZE4I9iQJ8PNQhbcnTqrOPgW6tUu4xnj+Tj9VH0ueMiOeUgkQk5kC1TUOVU
ZhfKCO8wlP43d1ymtRJX9Enx6BXc0t61uK2XkdLNpyjcZBqKFqdzFy6THJxqBZkE
t+M+cFRU+meeN0InORA1WShSW7W6w30YG2ikC9TLtYf6VxKLln9HkqX1Bdqp0tYJ
dKRq1sFL0uHpi3PuB+5j
=TlWk
-----END PGP SIGNATURE-----

--AmqcT2pvsOLWdLHT--

--===============7482008375480897721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7482008375480897721==--

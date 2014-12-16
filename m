From: Mark Brown <broonie@kernel.org>
Subject: Re: Streaming wake-up buffer from DSP to SoC over SPI
Date: Tue, 16 Dec 2014 11:42:00 +0000
Message-ID: <20141216114200.GP11764@sirena.org.uk>
References: <CAEUnVG6n15vNYgZoZXzRZvgAqej1Lb3bHDEy9cyQ+UCJbuv2kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6664283864614753458=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D6C7260541
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 12:42:15 +0100 (CET)
In-Reply-To: <CAEUnVG6n15vNYgZoZXzRZvgAqej1Lb3bHDEy9cyQ+UCJbuv2kg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@google.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6664283864614753458==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poAjhhkjx0WzNZgL"
Content-Disposition: inline


--poAjhhkjx0WzNZgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 15, 2014 at 06:45:37PM -0800, Dylan Reid wrote:

> I was thinking of making a separate PCM device.  The odd things are
> that it would have to originate from soc/codecs, the codec would own
> the codec and cpu end of the link, and the hw_ptr position would need
> to be queried over SPI.  But it would make userspace access to it more
> standard looking.

That's all totally fine from a framework point of view, if the data
comes from the CODEC with no SoC side involvement other than the control
interface bus then it's a good way to model things.  The component model
should make this a more natural fit than it is currently, you can just
add a DAI to the CODEC device.

--poAjhhkjx0WzNZgL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUkBqIAAoJECTWi3JdVIfQNtAH/R6/1mwvXYEf8lGx7XoQHhLA
z0+S/hV+j5KRcFxvA4jsUMWIo/ZxBLhn+tYskCWOtG1gHglxTgmw14xlErp9+KdA
qWtQ5cJGxQ2b+10FXVGcgsx2htJjXpT4vPQaiM+PpMUZR/+KAAENZCcP9DhVH+ms
t46K162d/gEldWlsR+0aU10HPXiCw9gKDg8SwAxxh8z7mc8+ffD6SMplkBLz7Uip
+KaMaX8leT0g9+2bZnlglkB0EqWWxjc+0UbfAyN8QQ8JhKViJBZlHjXKdVPscNiZ
/rqCeZLQrcrO4d5V7wTys2b4tAjhEn9obJJQgZDKt72g/BrOXAIFFJLcPJ0+MuA=
=00tJ
-----END PGP SIGNATURE-----

--poAjhhkjx0WzNZgL--

--===============6664283864614753458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6664283864614753458==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Mon, 17 Aug 2015 11:20:40 -0700
Message-ID: <20150817182040.GS10748@sirena.org.uk>
References: <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
 <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
 <20150811163954.GM10748@sirena.org.uk>
 <CAOMFOmWTahWyq3Oto2h3bVEwke7=FzGpJ2sG48vqkRrNb_--QA@mail.gmail.com>
 <20150813112639.GB1654@sirena.org.uk>
 <CAOMFOmXm66VgFPfD=NBMJNbqUvE0mbBSq5mRPk_4APuUJPcF_A@mail.gmail.com>
 <20150813223339.GN10748@sirena.org.uk>
 <CAOMFOmVtw9sXBRp6hkNu+AfhQR2TF-uJeyyB0SmHTtgLd8ZoQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3338826008536362329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id BA42C260412
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 20:20:45 +0200 (CEST)
In-Reply-To: <CAOMFOmVtw9sXBRp6hkNu+AfhQR2TF-uJeyyB0SmHTtgLd8ZoQw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: mfelton1@nuvoton.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dylan Reid <dgreid@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============3338826008536362329==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3nbTfX4V9Gs/5Yhz"
Content-Disposition: inline


--3nbTfX4V9Gs/5Yhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 16, 2015 at 12:38:41AM -0700, Anatol Pomozov wrote:
> On Thu, Aug 13, 2015 at 3:33 PM, Mark Brown <broonie@kernel.org> wrote:

> > So ACPI based platforms have to deal with providing clocks in some other
> > way, that's something that is abstracted away by the clock API.  There
> > are a number of drivers for both board file based and ACPI based systems
> > already in tree which manage to make use of the clock API.

> What is the best example of driver that uses clk API in both DT and
> ACPI friendly way? I will use it as a template for my driver.

Any driver using the clock API should provide a suitable reference.  The
mechanism used to resolve clocks is completely opaque to the driver
using the clock API.

--3nbTfX4V9Gs/5Yhz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0iX3AAoJECTWi3JdVIfQphAH/iwVzQjAqR0gexc1mfL+T0YA
rp1czj3a87gX9jGvSGRCHTdOo8tisAAJkf8Q+42qcjE2fldvUxgyZMh/RRYLXiqn
OUP1eIjKxIWB/WhyW4MzXuzwbC5xeCQoUoT7sRJrXQzdABzqf0kGN/a28FeFyXKE
VUKESF8I40tfIoPf9Zv5bYtvn9HqSt72/7PhqAOdPXAu+HDv1RPFhPy1T4VVdrbI
p8XxVNh9QKnQL3ZB7/lElqdQXcW0vCUNOpdNeBo1wr1w6evem4q0oc4wmZP04nor
nkpgS7+zOykTufkWsuyRXbTylVyfRpd3vXIi6QZTPIEoK616JHBErjeC9WvYDS0=
=xkvv
-----END PGP SIGNATURE-----

--3nbTfX4V9Gs/5Yhz--

--===============3338826008536362329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3338826008536362329==--

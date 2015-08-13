From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Thu, 13 Aug 2015 23:33:40 +0100
Message-ID: <20150813223339.GN10748@sirena.org.uk>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
 <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
 <20150811163954.GM10748@sirena.org.uk>
 <CAOMFOmWTahWyq3Oto2h3bVEwke7=FzGpJ2sG48vqkRrNb_--QA@mail.gmail.com>
 <20150813112639.GB1654@sirena.org.uk>
 <CAOMFOmXm66VgFPfD=NBMJNbqUvE0mbBSq5mRPk_4APuUJPcF_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0748871337370427592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68658264F28
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 00:33:55 +0200 (CEST)
In-Reply-To: <CAOMFOmXm66VgFPfD=NBMJNbqUvE0mbBSq5mRPk_4APuUJPcF_A@mail.gmail.com>
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
Cc: mfelton1@nuvoton.com, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


--===============0748871337370427592==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0yM48dKbQb4SmPLM"
Content-Disposition: inline


--0yM48dKbQb4SmPLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 13, 2015 at 12:44:33PM -0700, Anatol Pomozov wrote:
> On Thu, Aug 13, 2015 at 4:26 AM, Mark Brown <broonie@kernel.org> wrote:

> > No, that is not the case at all - what makes you claim that devm_clk_get()
> > is DT specific?

> clk_dev uses of_clk_get_by_name() that is implemented for DTS only.
> See include/linux/clk.h.

That means that the clock API can work with DT, not that DT is
mandatory - notice how there are stubs for the non-DT case.

> ACPI has a compatible API for getting simple properties
> (strings/numbers), but no API for dealing with clocks.

So ACPI based platforms have to deal with providing clocks in some other
way, that's something that is abstracted away by the clock API.  There
are a number of drivers for both board file based and ACPI based systems
already in tree which manage to make use of the clock API.

> > I very much doubt that this will be a problem for all boards.  To repeat
> > what I said in my previous reply:

> > | The assumption would be that if the system doesn't have or need jack
> > | detection then the jack pins won't be reconfigurable anyway.

> > Your board may be wired up with jack detection configured in a way that
> > needs this, I would be surprised if all boards were.

> I am still trying to understand the use-case for NAU8825 without jack
> detection functionality. Are you talking about a board configuration
> that does not wire jack to JKDET codec pin and (maybe) statically
> connects output to speakers?

I'm not specifically familiar with this CODEC, however this sort of
detection circuitry is all pretty standard.  I'm thinking of the sort of
straightforward configurations where the detection inputs and any
outputs required to flip polarity of the jack are just not wired up.

> If platform driver does not enable jack detection, what NAU8825
> functionality suppose to work? Does output (HPL/HPR) suppose to work?
> Does mic suppose to work? Is OMTP/CTIA mic detection functionality
> needed?

I'd expect the detection functionality wouldn't work without being wired
up as expected but I'd expect it to be perfectly possible to support the
headphones with the default ground confirguration.  I'd also expect mics
to work, either connected to the headset with a fixed polarity or just
elsewhere in the system.  If the device is capable of supprorting
headphones it must be capable of supporting them with a fixed ground,
and similarly for microphones.

--0yM48dKbQb4SmPLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzRs/AAoJECTWi3JdVIfQCcEH/28UjqWMg3L2GL5q4XZMffjm
2jBx9pbI1YJQS0bNe+FFfhtQCjxcc8tl7LIIGFvbPvJ9iq2bKyfhdcvPoUuajKgj
Ggu1yLX9Kxv1rm6yVKRJzNcbu0ycbOoKR2goS5bq7beLtOwKx2Yvy7bhAsoQmsr5
maPJa47SSNCwZyjBfwdiLvIApv/3Ceo2zMniOuaYJ3EjDseO6gsvqpGVRcFyJsTr
/hkXApSt0aI1jeqquEqHZJr4QKpnTzFBwDP9AuVAiB3n6cz+cCsC1XFbRZ6wZ37z
/1TEMaM9T/gmsBCVfscXiSC51y0lOwl32axKWVrzk7f3vYIJNjGbQH/WOZe9HKk=
=ylLk
-----END PGP SIGNATURE-----

--0yM48dKbQb4SmPLM--

--===============0748871337370427592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0748871337370427592==--

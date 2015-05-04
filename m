From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 3/4] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Mon, 4 May 2015 14:57:26 +0100
Message-ID: <20150504135726.GB15510@sirena.org.uk>
References: <1430697619-22773-1-git-send-email-cernekee@chromium.org>
 <1430697619-22773-4-git-send-email-cernekee@chromium.org>
 <20150504114558.GD15510@sirena.org.uk>
 <CAJzqFtYm6W40B05DG5yfa5iOaUo3ShJOm6AXcOQ1ehUOG0yO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z4ZSWl3cPHKQyRxO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtYm6W40B05DG5yfa5iOaUo3ShJOm6AXcOQ1ehUOG0yO6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--Z4ZSWl3cPHKQyRxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2015 at 06:51:32AM -0700, Kevin Cernekee wrote:
> On Mon, May 4, 2015 at 4:45 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Sun, May 03, 2015 at 05:00:18PM -0700, Kevin Cernekee wrote:
> >> +     if (dev->of_node) {
> >> +             const struct of_device_id *of_id;
> >> +
> >> +             of_id = of_match_device(tas571x_of_match, dev);
> >> +             if (of_id)
> >> +                     priv->chip = of_id->data;
> >> +     }

> > Doesn't of_match_device() do the right thing with devices not registered
> > from DT?

> Not sure.  What kinds of situations are you concerned about?

I'm wondering why we need to bother checking for dev->of_node before
calling it.

--Z4ZSWl3cPHKQyRxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR3rFAAoJECTWi3JdVIfQU3sH/3xpSxPuskfBeUXqWulyo4If
R6lxf+zSmrIBZn2gXxzoyL19HhlSYpRCYlST5CqHwYq4fN7MOrM4SWLkToGXhYfa
mYk6CZ6lMQU/cSEN8Q8ngZ5V+RsYcTf7vjRlGrJvBILXN3QfZy3WLwZ9Usol4XSc
V/P3cqDN/BM6DHIbjENrK/OUt42GWmNX/2eruPPRJlM2ax5DlSF0Qggkiufds/Ee
FXmpaOXUkzhF1Ocd7xzJYP1U9n5T5wccAVfQVmEp4GNpMDWRHCxyq+0NWeaien0Z
Cagf0PADPnwSYFcwl1EL559UEuKwbh7/NJGh5PXiILl0e3p1kEFfycLka5UbIKM=
=acyP
-----END PGP SIGNATURE-----

--Z4ZSWl3cPHKQyRxO--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/4] regmap: cache: Add "was_reset" argument to
 regcache_sync_region()
Date: Wed, 29 Apr 2015 18:34:02 +0100
Message-ID: <20150429173402.GP22845@sirena.org.uk>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
 <1429915008-22015-2-git-send-email-cernekee@chromium.org>
 <20150425113235.GA31708@sirena.org.uk>
 <CAJzqFtYkSds+s2HA3uKrMQes+D2K1TxOdzm5jJhtt2iZvyqxCA@mail.gmail.com>
 <20150429104042.GB22845@sirena.org.uk>
 <CAJzqFta=ndErf012QEV37kE0oSPp6dF_D7w_i_HsCkx5ytPgdA@mail.gmail.com>
 <20150429164632.GO22845@sirena.org.uk>
 <CAJzqFtbTbUG=s7sxNBEYG1Haq5tzaCrMB=j55okZnwdVmzUAYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3VjAXQKlB2CdpQtt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtbTbUG=s7sxNBEYG1Haq5tzaCrMB=j55okZnwdVmzUAYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--3VjAXQKlB2CdpQtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2015 at 10:02:03AM -0700, Kevin Cernekee wrote:
> On Wed, Apr 29, 2015 at 9:46 AM, Mark Brown <broonie@kernel.org> wrote:

> > We just need a single boolean?

> Right, so if we add a per-regmap bool that tells us whether the device
> has been reset, then in the case of "not reset" we will have to write
> every regcache entry out to the device.  Even the ones that weren't
> touched while in cache_only mode.  This makes the "not reset" case
> much less efficient than the "reset" case.

The immediate point is to provide a useful external interface, the
internal optimisation is much less urgent (and it's less clear to me how
often we're going to need to do that at all - generally cache only and
power loss go together.

> BTW, any preferences on naming for the bool or for the renamed
> mark_dirty function?

Not urgently.  Note that I'm *not* suggesting an immediate rename,
that's definitely a separate change (which will be a lot more painful to
merge due to cross tree issues).

> >> i.e. regcache_sync() finds a register value marked "present".  How do
> >> we know whether we need to write it back to the hardware?  For the
> >> special case of "cached non default register values immediately after
> >> a HW reset" you can mostly figure this out, but if there was no HW
> >> reset how do we know which entries changed while the HW was
> >> inaccessible?

> > In the first instance do we care?

> I'm not sure I understand the question.

Do we actually care about getting a list of the changed registers that
much?

--3VjAXQKlB2CdpQtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQRYKAAoJECTWi3JdVIfQfYsIAIKxW37dqidzwS5ArJBIpzd9
c5aJ5bmWP+r3aJXEY2NIGvg/lTtELe45uFOFltPfygWogYDxyp8j14Q0lFbBzytP
m5o2rm+HmaOxtglvjM1q+qqhdDkDWq7tjuZ1gg05n0GCBt6eZLaV1iJrqQ8gMrgG
vV9caW9J61hftHiZLMbTXP7l4bggj3zJmGX6id685iMBqApbpTsXvxJW0bm03tEE
82iQ6qIOvXqBV/DUI7tYZdR8liFcff1p+2l+jXKXtUWz2qL6PzKJ7zusYB9ANDEY
kzQpZCPFaCv5o4a0ZC/bIzUjd4+6zmZv6AKfW+PvnUOFBFrMeOxEkOuNL/z4+Tg=
=joo2
-----END PGP SIGNATURE-----

--3VjAXQKlB2CdpQtt--

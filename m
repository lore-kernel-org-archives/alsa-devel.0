From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/4] regmap: cache: Add "was_reset" argument to
 regcache_sync_region()
Date: Wed, 29 Apr 2015 17:46:32 +0100
Message-ID: <20150429164632.GO22845@sirena.org.uk>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
 <1429915008-22015-2-git-send-email-cernekee@chromium.org>
 <20150425113235.GA31708@sirena.org.uk>
 <CAJzqFtYkSds+s2HA3uKrMQes+D2K1TxOdzm5jJhtt2iZvyqxCA@mail.gmail.com>
 <20150429104042.GB22845@sirena.org.uk>
 <CAJzqFta=ndErf012QEV37kE0oSPp6dF_D7w_i_HsCkx5ytPgdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KhnGy1eznWbC2o3B"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFta=ndErf012QEV37kE0oSPp6dF_D7w_i_HsCkx5ytPgdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--KhnGy1eznWbC2o3B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2015 at 07:13:27AM -0700, Kevin Cernekee wrote:
> On Wed, Apr 29, 2015 at 3:40 AM, Mark Brown <broonie@kernel.org> wrote:

> > Like I said above we can tell if the hardware was reset because
> > mark_dirty() is called.

> That covers the public API, but I do not understand how you intended
> for this data to be stored in the rbtree if the use of a dirty bitmask
> is discouraged.

We just need a single boolean?

> i.e. regcache_sync() finds a register value marked "present".  How do
> we know whether we need to write it back to the hardware?  For the
> special case of "cached non default register values immediately after
> a HW reset" you can mostly figure this out, but if there was no HW
> reset how do we know which entries changed while the HW was
> inaccessible?

In the first instance do we care?

> > I'm not suggesting that we do anything based on the presence of a cache
> > entry, I'm suggesting that we could avoid having to ever cache values
> > that never get referenced on a system (which can be a lot of them for
> > common use cases) saving us memory.

> This seems to be solving a different problem.  It sounds like you are
> more worried about regcache_sync() writing back lots of default values
> for registers that were never touched, than performing unnecessary
> writes to a few (actively used) registers that weren't changed while
> we were in cache_only mode.  Is that accurate?

No.  This is nothing to do with sync, it's just something that might be
nice.

--KhnGy1eznWbC2o3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQQrnAAoJECTWi3JdVIfQUFcH/0SynwjyXdpOG0FDUKg3hGRt
DoXVSeih4qZKgGl6JXcaiDAF2JbXsi66XBkDt45qI7Rpid1TScuczKzy4kSfgalc
+vYRwu8/8Z46+F0+9yUuY5GkEDatwqbhXRVpJ4e8afS3fYkyuBy8lTgUw5OWmRgk
hvF0mqlfq3F9uw6E0GVMkb65ZiYYIUkYPTGBXWCUSGxNJpknkNyeyN8pdoo7Nn6e
5AoDELu2JjhoB7NpGSPDBoGn6Vo2d5kuXgNgk4BvI/IzXfsQo8KZTBK/ijBPznyB
2QWflf0f8yJVg+6dNHdZ4ydCbUCWlyix++JdDJEoZExEHJPwfU1mSw2d7ZkpzeI=
=RIM5
-----END PGP SIGNATURE-----

--KhnGy1eznWbC2o3B--

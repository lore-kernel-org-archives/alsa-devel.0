From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/4] regmap: cache: Add "was_reset" argument to
 regcache_sync_region()
Date: Wed, 29 Apr 2015 11:40:42 +0100
Message-ID: <20150429104042.GB22845@sirena.org.uk>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
 <1429915008-22015-2-git-send-email-cernekee@chromium.org>
 <20150425113235.GA31708@sirena.org.uk>
 <CAJzqFtYkSds+s2HA3uKrMQes+D2K1TxOdzm5jJhtt2iZvyqxCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I/mxowL+bREwzm2b"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtYkSds+s2HA3uKrMQes+D2K1TxOdzm5jJhtt2iZvyqxCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--I/mxowL+bREwzm2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 09:58:48PM -0700, Kevin Cernekee wrote:
> On Sat, Apr 25, 2015 at 4:32 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > What we should be doing here is providing a way for users to tell regmap
> > if they've reset the register map and actually we already have that
> > interface, it's just not got the best name - regcache_mark_dirty() is
> > effectively it since there's really not a lot of other reasons why a
> > driver would need to mark the cache as dirty.  We're just not handling

> 1) How do we tell the difference between "regcache contains a
> non-default value that correctly reflects the hardware register
> contents" versus "regcache contains a non-default value that is
> waiting to be written when we exit cache_only mode"?

Like I said above we can tell if the hardware was reset because
mark_dirty() is called.

> 2) Does that also mean that we should store default values in the
> rbtree if they are part of a deferred cache_only write, but not store
> them if the write went through to the hardware?

Well, remember that it's very expensive to remove a value from the cache
so actively trying to prune the cache would be bad.

> 3) If we're caching the default values lazily, does that mean that
> every regcache read would incur both an rbtree lookup and a bsearch of
> the reg_defaults array?

That'd happen on first read, yes.

> 4) If "the only things in the cache will be things that have been
> explicitly changed," that could impact the semantics of
> regcache_drop_region().  Which fortunately has no users.

Could you articulate what changes you believe would be seen?

> Seems like it would be more straightforward just to add an
> rbnode->dirty bitmask alongside rbnode->cache_present, rather than
> trying to infer the hardware state from the presence/absence of the
> cache entry.  Knowing whether each individual register is out of sync
> with the hardware lets us avoid unnecessary writes in both situations:
> full reset, and temporary loss of register access.

I'm not suggesting that we do anything based on the presence of a cache
entry, I'm suggesting that we could avoid having to ever cache values
that never get referenced on a system (which can be a lot of them for
common use cases) saving us memory.  Maintaining a dirty bitmask would
work too, but it does push the memory consumption up further which might
be a concern.

--I/mxowL+bREwzm2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQLUpAAoJECTWi3JdVIfQbLgH/1FqJkNRfN4Fy+sxfxlwixrQ
0zlqVSCtwt2jVFCq+9YBQkJFSZ92qgCqV9AW0RtaNMqQIAA2DF9mSPGDP7oWqoMD
kMrVL1geuk1ph+GsfQP/5BN0q9CklrQ5mjaJ/2PronxmDAWBB6l6StwU0YLuNzOO
AcG55QleFjGmEBCmMLLZ65/LW4aV7lYLRruU+XA6FHUjfPzjaF96csCXtqf3Ktss
wT8/A6YWtkDKLkEqYAQINEEsg/Yb+sF8OGR92htAp4ZQrC9yevAXpwm5SyXI5lOV
VYBCZBVJxPyrQlHoTHnyDSPrIBlns2gsh3oC/BscHthFlmmibkne+679vYSxShI=
=2I4L
-----END PGP SIGNATURE-----

--I/mxowL+bREwzm2b--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

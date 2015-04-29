From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH V2 1/4] regmap: cache: Add "was_reset" argument to regcache_sync_region()
Date: Tue, 28 Apr 2015 21:58:48 -0700
Message-ID: <CAJzqFtYkSds+s2HA3uKrMQes+D2K1TxOdzm5jJhtt2iZvyqxCA@mail.gmail.com>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
 <1429915008-22015-2-git-send-email-cernekee@chromium.org> <20150425113235.GA31708@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150425113235.GA31708@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 25, 2015 at 4:32 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 24, 2015 at 03:36:45PM -0700, Kevin Cernekee wrote:
>
>> index 116655d92269..ece122a6fdeb 100644
>> --- a/include/linux/regmap.h
>> +++ b/include/linux/regmap.h
>> @@ -438,7 +438,7 @@ bool regmap_can_raw_write(struct regmap *map);
>>
>>  int regcache_sync(struct regmap *map);
>>  int regcache_sync_region(struct regmap *map, unsigned int min,
>> -                      unsigned int max);
>> +                      unsigned int max, bool was_reset);
>
> This seems pretty ugly - both the fact that we're changing the signature
> of the function and the naming of the argument feel inelegant.  The
> point isn't if the device has been reset, the point is if the device
> currently has the default register values or not, and this means that
> the user is responsible for tracking that state until the next time it
> does the sync.  That may be immediately like in your case but there's no
> reason that has to be the case.  The fact that we're passing in
> something called "is_reset" which sounds like a state value for the
> register map is a bit of a warning sign here.
>
> What we should be doing here is providing a way for users to tell regmap
> if they've reset the register map and actually we already have that
> interface, it's just not got the best name - regcache_mark_dirty() is
> effectively it since there's really not a lot of other reasons why a
> driver would need to mark the cache as dirty.  We're just not handling
> it properly.  What we should do instead is to keep the interface as it
> is for now and make it behave in a more expected fashion so that if the
> cache is explicitly marked dirty we assume that the hardware is in the
> default state and otherwise we don't.
>
> Ideally what we'd do is both improve the naming of mark_dirty() (though
> that's API churn which is nasty) and arrange for rbtree to cache the
> default values lazily, that way the only things in the cache will be
> things that have been explicitly changed (we will still want default
> checking but it makes life easier and means we don't end up having to do
> a full writeout for cases where things have been put into cache mode
> without a reset).

Hi Mark,

I started prototyping this, but ran into a couple of issues:

1) How do we tell the difference between "regcache contains a
non-default value that correctly reflects the hardware register
contents" versus "regcache contains a non-default value that is
waiting to be written when we exit cache_only mode"?

2) Does that also mean that we should store default values in the
rbtree if they are part of a deferred cache_only write, but not store
them if the write went through to the hardware?

3) If we're caching the default values lazily, does that mean that
every regcache read would incur both an rbtree lookup and a bsearch of
the reg_defaults array?

4) If "the only things in the cache will be things that have been
explicitly changed," that could impact the semantics of
regcache_drop_region().  Which fortunately has no users.

Seems like it would be more straightforward just to add an
rbnode->dirty bitmask alongside rbnode->cache_present, rather than
trying to infer the hardware state from the presence/absence of the
cache entry.  Knowing whether each individual register is out of sync
with the hardware lets us avoid unnecessary writes in both situations:
full reset, and temporary loss of register access.

What do you think?

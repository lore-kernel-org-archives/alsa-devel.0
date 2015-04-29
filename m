From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH V2 1/4] regmap: cache: Add "was_reset" argument to regcache_sync_region()
Date: Wed, 29 Apr 2015 07:13:27 -0700
Message-ID: <CAJzqFta=ndErf012QEV37kE0oSPp6dF_D7w_i_HsCkx5ytPgdA@mail.gmail.com>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
 <1429915008-22015-2-git-send-email-cernekee@chromium.org> <20150425113235.GA31708@sirena.org.uk>
 <CAJzqFtYkSds+s2HA3uKrMQes+D2K1TxOdzm5jJhtt2iZvyqxCA@mail.gmail.com> <20150429104042.GB22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429104042.GB22845@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2015 at 3:40 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Apr 28, 2015 at 09:58:48PM -0700, Kevin Cernekee wrote:
>> On Sat, Apr 25, 2015 at 4:32 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > What we should be doing here is providing a way for users to tell regmap
>> > if they've reset the register map and actually we already have that
>> > interface, it's just not got the best name - regcache_mark_dirty() is
>> > effectively it since there's really not a lot of other reasons why a
>> > driver would need to mark the cache as dirty.  We're just not handling
>
>> 1) How do we tell the difference between "regcache contains a
>> non-default value that correctly reflects the hardware register
>> contents" versus "regcache contains a non-default value that is
>> waiting to be written when we exit cache_only mode"?
>
> Like I said above we can tell if the hardware was reset because
> mark_dirty() is called.

That covers the public API, but I do not understand how you intended
for this data to be stored in the rbtree if the use of a dirty bitmask
is discouraged.

i.e. regcache_sync() finds a register value marked "present".  How do
we know whether we need to write it back to the hardware?  For the
special case of "cached non default register values immediately after
a HW reset" you can mostly figure this out, but if there was no HW
reset how do we know which entries changed while the HW was
inaccessible?

> I'm not suggesting that we do anything based on the presence of a cache
> entry, I'm suggesting that we could avoid having to ever cache values
> that never get referenced on a system (which can be a lot of them for
> common use cases) saving us memory.

This seems to be solving a different problem.  It sounds like you are
more worried about regcache_sync() writing back lots of default values
for registers that were never touched, than performing unnecessary
writes to a few (actively used) registers that weren't changed while
we were in cache_only mode.  Is that accurate?

FWIW, in the current iteration of the tas571x driver, there are few if
any registers that meet this criteria.

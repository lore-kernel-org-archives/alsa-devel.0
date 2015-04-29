From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH V2 1/4] regmap: cache: Add "was_reset" argument to regcache_sync_region()
Date: Wed, 29 Apr 2015 10:02:03 -0700
Message-ID: <CAJzqFtbTbUG=s7sxNBEYG1Haq5tzaCrMB=j55okZnwdVmzUAYQ@mail.gmail.com>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
 <1429915008-22015-2-git-send-email-cernekee@chromium.org> <20150425113235.GA31708@sirena.org.uk>
 <CAJzqFtYkSds+s2HA3uKrMQes+D2K1TxOdzm5jJhtt2iZvyqxCA@mail.gmail.com>
 <20150429104042.GB22845@sirena.org.uk> <CAJzqFta=ndErf012QEV37kE0oSPp6dF_D7w_i_HsCkx5ytPgdA@mail.gmail.com>
 <20150429164632.GO22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429164632.GO22845@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2015 at 9:46 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 29, 2015 at 07:13:27AM -0700, Kevin Cernekee wrote:
>> On Wed, Apr 29, 2015 at 3:40 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Like I said above we can tell if the hardware was reset because
>> > mark_dirty() is called.
>
>> That covers the public API, but I do not understand how you intended
>> for this data to be stored in the rbtree if the use of a dirty bitmask
>> is discouraged.
>
> We just need a single boolean?

Right, so if we add a per-regmap bool that tells us whether the device
has been reset, then in the case of "not reset" we will have to write
every regcache entry out to the device.  Even the ones that weren't
touched while in cache_only mode.  This makes the "not reset" case
much less efficient than the "reset" case.

Maybe that's good enough for most purposes.  It's no worse than what
my original patch submission did, anyway.

BTW, any preferences on naming for the bool or for the renamed
mark_dirty function?

>> i.e. regcache_sync() finds a register value marked "present".  How do
>> we know whether we need to write it back to the hardware?  For the
>> special case of "cached non default register values immediately after
>> a HW reset" you can mostly figure this out, but if there was no HW
>> reset how do we know which entries changed while the HW was
>> inaccessible?
>
> In the first instance do we care?

I'm not sure I understand the question.

>> > I'm not suggesting that we do anything based on the presence of a cache
>> > entry, I'm suggesting that we could avoid having to ever cache values
>> > that never get referenced on a system (which can be a lot of them for
>> > common use cases) saving us memory.
>
>> This seems to be solving a different problem.  It sounds like you are
>> more worried about regcache_sync() writing back lots of default values
>> for registers that were never touched, than performing unnecessary
>> writes to a few (actively used) registers that weren't changed while
>> we were in cache_only mode.  Is that accurate?
>
> No.  This is nothing to do with sync, it's just something that might be
> nice.

Thanks, that clarifies things.  I was not aware that other drivers
even had an issue with excessively large regcache rbtrees, as my
reg_defaults list is short.

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/9] tools: convert comm_str.refcnt from atomic_t to
 refcount_t
Date: Thu, 23 Feb 2017 10:02:17 -0300
Message-ID: <20170223130217.GC3595@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <1487691303-31858-4-git-send-email-elena.reshetova@intel.com>
 <20170222203350.GE20447@kernel.org>
 <20170222222045.GJ20447@kernel.org>
 <20170222223104.GK20447@kernel.org>
 <2236FBA76BA1254E88B949DDB74E612B41C4F3BD@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C4F3BD@IRSMSX102.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Peter Zijlstra <peterz@infradead.org>, gregkh@linuxfoundation.org, Ingo Molnar <mingo@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, akpm@linux-foundation.org, matija.glavinic-pecotic.ext@nokia.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

Em Thu, Feb 23, 2017 at 09:16:07AM +0000, Reshetova, Elena escreveu:
> > Em Wed, Feb 22, 2017 at 07:20:45PM -0300, Arnaldo Carvalho de Melo
> > > > make: *** [install-bin] Error 2
> > > > make: Leaving directory '/home/acme/git/linux/tools/perf'
> > > > [acme@jouet linux]$

> > > > 3) not test building your patches :-\
 
> Sorry about compilation errors: I totally forgot that tools is not
> getting compiled automatically when you build the whole tree with all
> configs on, so these patches really slipped through untested.

np, each component in the tree has its own idiosyncrasies, its really
difficult to test something so sweeping like this change, thanks again
for doing this work, use-after-free is evil, we should do more things
like this :-)

> > > > I'll let this pass this time, minor, I am removing the now unused
> > > > comm_str__get() function.

> > > But it can't get unused, because the comm_str__findnew() may return an
> > > existing entry, that _needs_ to get its refcount bumped, that is the
> > > reason for this refcount to be there... reinstating it:
 
> True, we missed that it was reused behind the scenes. Your fix below
> does it correctly.  The object resuse seems to be one of the main
> issues of this atomic_t to refcount_t conversions through the kernel.
> We have sooo many places where this happens (obvious and not so
> obvious ones) and every single of them would fail in run-time, unless
> we can modify the code not to do increments on zero. 

Yeah, but this code wasn't using the right idiom, which is to, in a
"__findnew()" method to lock it and before dropping the lock to bump the
refcount of whatever is going to be returned, so that after the lock is
dropped we don't open a window where that object can get removed from
the rbtree and hit the bit bucket.
 
> > > #0  0x00007ffff522491f in raise () from /lib64/libc.so.6
> > > #1  0x00007ffff522651a in abort () from /lib64/libc.so.6
> > > #2  0x00007ffff5268200 in __libc_message () from /lib64/libc.so.6
> > > #3  0x00007ffff527188a in _int_free () from /lib64/libc.so.6
> > > #4  0x00007ffff52752bc in free () from /lib64/libc.so.6
> > > #5  0x000000000051125f in comm_str__put (cs=0x35038e0) at util/comm.c:20
> > > #6  0x00000000005115b3 in comm__free (comm=0x6f4ee90) at

> > > And this brings us to my learning experience, i.e. this should've been caught
> > > by this machinery, right? But that only if I leaked this object, right?
> > >
> > > I need to read more on this, that is for sure ;-)
 
> The way how current refcount_t implemented it would refuse to do any
> increments/decrements on zero, or increments/decrements on max values.
> Also, it should WARN about this cases so that people can trace the
> issue.

Humm, but the sequence is:

1. refcount_set(1)

2. recount_dec_and_test(1) -> 0
      delete object, _free_ it

3. if there is any reference to it yet, without holding a refcount_inc()
   obtained reference (a __get() method for the protected object) it may
   well be pointing to something that was reused for another unrelated
   object, so it can get a value != 0 and then the next
   refcount_dec_and_test() will not catch it being zero as set in step #2.

   To really catch this we would have to just not delete it when it
   refcunt_dec_and_test(1) sets it to zero, i.e. _leak_ it, right?

I'll check some other conversion done in the kernel to see where I am
missing something...

> > For reference, this is the patch on top of this:
> > 
> > +++ b/tools/perf/util/comm.c
> > @@ -13,6 +13,13 @@ struct comm_str {

<SNIP>
 
> This looks correct now.

Thanks for checking,

- Arnaldo 

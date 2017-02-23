From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH 1/9] tools: convert cgroup_sel.refcnt from atomic_t to
 refcount_t
Date: Thu, 23 Feb 2017 13:10:21 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C4F509@IRSMSX102.ger.corp.intel.com>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <1487691303-31858-2-git-send-email-elena.reshetova@intel.com>
 <20170221154356.GF5052@kernel.org>
 <2236FBA76BA1254E88B949DDB74E612B41C4EC7E@IRSMSX102.ger.corp.intel.com>
 <20170222153754.GA20447@kernel.org>
 <2236FBA76BA1254E88B949DDB74E612B41C4EE30@IRSMSX102.ger.corp.intel.com>
 <20170222202819.GC20447@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170222202819.GC20447@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "peterz@infradead.org" <peterz@infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matija.glavinic-pecotic.ext@nokia.com" <matija.glavinic-pecotic.ext@nokia.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

> Em Wed, Feb 22, 2017 at 04:10:59PM +0000, Reshetova, Elena escreveu:
> > > Em Wed, Feb 22, 2017 at 02:29:18PM +0000, Reshetova, Elena escreveu:
> > > > > Em Tue, Feb 21, 2017 at 05:34:55PM +0200, Elena Reshetova escreveu:
> > > > > > refcount_t type and corresponding API should be
> > > > > > used instead of atomic_t when the variable is used as
> > > > > > a reference counter. This allows to avoid accidental
> > > > > > refcounter overflows that might lead to use-after-free
> > > > > > situations.
> > > > > >  #define __CGROUP_H__
> > > > > >
> > > > > > -#include <linux/atomic.h>
> > > > > > +#include <linux/refcount.h>
> > > > >
> > > > > So this is the first one, I was expecting the copy from
> > > > > include/linux/refcount.h to be made to tools/include/linux/refcount.h,
> > > > > as was done for tools/include/linux/atomic.h and all the other stuff in
> > > > > tools/include/
> > > > >
> > > > > See:
> > > > >
> > > > > commit c4b6014e8bb0c8d47fe5c71ebc604f31091e5d3f
> > > > > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date:   Mon Jul 11 10:28:48 2016 -0300
> > > > >
> > > > >     tools: Add copy of perf_event.h to tools/include/linux/
> > > > >
> > > > > --------------
> > > > >
> > > > > For one of the reasons we've been doing this.
> > >
> > > > Hm.. I have taken a look on it and I am confused.  refcount.h is not
> > > > exactly standalone header and seems to bring in quite some many
> > > > dependencies to other headers (linux/bug.h, linux/mutex.h etc.), which
> > > > are not present in tools headers dirs.
> > >
> > > > I tried to compile perf tool as a start, copied the refcount.h to
> > > > tools/include/linux/ and somewhere after it wanted me to bring the
> > > > 10th header I stopped, because this cannot be right, or?
> > >
> > > So, it doesn't have to be a straight copy, and it just shows the problem
> > > with using the kernel headers directly, i.e. tools/perf/ uses atomic.h,
> > > and uses that for refcounting, but not all of include/linux/refcount.h
> > > should be copied to tools/include/linux/refcount.h.
> 
> > Oh, this is a good hint. Actually when I drop the *_lock and
> > *_mutex_lock functions (which are not needed by tools anyway), indeed
> > most of the issues with header inclusions are gone.  However, there
> > are still some additional atomic functions needed that are not present
> > in current atomic headers of tools.
> 
> I did it, needed a good number of bits and pieces into
> tools/{include,arch}/, now I am processing your patches and...
> 
> > > I'll try doing the work, that way I'll read about this new stuff, will
> > > come back here with what I find, so you can continue on the kernel bits
> > > for now, ok?
> 
> > Sure, if you want to take it over, nobosy won't complain! We need many
> > of such changes merged and not everyone is so nice to help :) I think
> > after the needed headers/functions from refcount/atomic are in place
> > in tools, the current patches should compile with no or almost no
> > changes, so hopefully it still makes your work easier!
> 
> You use things in refcount.h for which you are not adding the relevant
> headers, like UINT_MAX, that is defined in linux/kernel.h, but that file
> is not included in refcount.h, most of the time it is available by luck,
> being something so commonly included, but some of your patches don't
> build because of that, so I am moving the include <linux/refcount.h> to
> after other headers to continue.
> 
> The right thing tho is to fix linux/refcount.h (and then its trimmed
> down copy in tools/) to have everything it needs not to contribute to
> the header messentropy. 8-)

I agree that fixing refcount.h is the correct way to resolve this. 
I just send this one line patch to Peter directly. 

Best Regards,
Elena.

> 
> Anyway, I'll put this in a branch later so that you can take a look.
> 
> - Arnaldo

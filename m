From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/9] tools: convert cgroup_sel.refcnt from atomic_t to
 refcount_t
Date: Wed, 22 Feb 2017 12:37:54 -0300
Message-ID: <20170222153754.GA20447@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <1487691303-31858-2-git-send-email-elena.reshetova@intel.com>
 <20170221154356.GF5052@kernel.org>
 <2236FBA76BA1254E88B949DDB74E612B41C4EC7E@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C4EC7E@IRSMSX102.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "peterz@infradead.org" <peterz@infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matija.glavinic-pecotic.ext@nokia.com" <matija.glavinic-pecotic.ext@nokia.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

Em Wed, Feb 22, 2017 at 02:29:18PM +0000, Reshetova, Elena escreveu:
> > Em Tue, Feb 21, 2017 at 05:34:55PM +0200, Elena Reshetova escreveu:
> > > refcount_t type and corresponding API should be
> > > used instead of atomic_t when the variable is used as
> > > a reference counter. This allows to avoid accidental
> > > refcounter overflows that might lead to use-after-free
> > > situations.
> > >  #define __CGROUP_H__
> > >
> > > -#include <linux/atomic.h>
> > > +#include <linux/refcount.h>
> > 
> > So this is the first one, I was expecting the copy from
> > include/linux/refcount.h to be made to tools/include/linux/refcount.h,
> > as was done for tools/include/linux/atomic.h and all the other stuff in
> > tools/include/
> > 
> > See:
> > 
> > commit c4b6014e8bb0c8d47fe5c71ebc604f31091e5d3f
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Mon Jul 11 10:28:48 2016 -0300
> > 
> >     tools: Add copy of perf_event.h to tools/include/linux/
> > 
> > --------------
> > 
> > For one of the reasons we've been doing this.
 
> Hm.. I have taken a look on it and I am confused.  refcount.h is not
> exactly standalone header and seems to bring in quite some many
> dependencies to other headers (linux/bug.h, linux/mutex.h etc.), which
> are not present in tools headers dirs.

> I tried to compile perf tool as a start, copied the refcount.h to
> tools/include/linux/ and somewhere after it wanted me to bring the
> 10th header I stopped, because this cannot be right, or?

So, it doesn't have to be a straight copy, and it just shows the problem
with using the kernel headers directly, i.e. tools/perf/ uses atomic.h,
and uses that for refcounting, but not all of include/linux/refcount.h
should be copied to tools/include/linux/refcount.h.

I'll try doing the work, that way I'll read about this new stuff, will
come back here with what I find, so you can continue on the kernel bits
for now, ok?

- Arnaldo

From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH 0/9] tools subsystem refcounter conversions
Date: Thu, 23 Feb 2017 11:39:10 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C4F449@IRSMSX102.ger.corp.intel.com>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <20170221153935.GE5052@kernel.org> <20170222232329.GN20447@kernel.org>
 <20170222232917.GO20447@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170222232917.GO20447@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "peterz@infradead.org" <peterz@infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matija.glavinic-pecotic.ext@nokia.com" <matija.glavinic-pecotic.ext@nokia.com>
List-Id: alsa-devel@alsa-project.org

> Em Wed, Feb 22, 2017 at 08:23:29PM -0300, Arnaldo Carvalho de Melo
> escreveu:
> > Em Tue, Feb 21, 2017 at 12:39:35PM -0300, Arnaldo Carvalho de Melo
> escreveu:
> > > Em Tue, Feb 21, 2017 at 05:34:54PM +0200, Elena Reshetova escreveu:
> > > > Now when new refcount_t type and API are finally merged
> > > > (see include/linux/refcount.h), the following
> > > > patches convert various refcounters in the tools susystem from atomic_t
> > > > to refcount_t. By doing this we prevent intentional or accidental
> > > > underflows or overflows that can led to use-after-free vulnerabilities.
> > >
> > > Thanks for working on this! I was almost going to jump on doing this
> > > myself!
> > >
> > > I'll try and get this merged ASAP.
> >
> > So, please take a look at my tmp.perf/refcount branch at:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

I took a look on it and it looks good. Just one thing I want to double check with regards to this commit:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/acme/linux/+/58d561002587bf2572f9e6f4d222659e4068fadf%5E%21/#F0

And more specifically to this chunk:

@@ -937,7 +937,7 @@
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
 		map->fd = -1;
-		atomic_set(&map->refcnt, 0);
+		refcount_set(&map->refcnt, 0);
 	}
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }

So, when the refcount set to zero in this place, what exactly happens to the perf_map object after? 
I just want to double check that we don't have  another hiding reusage case here when refcounter later on is simply incremented vs. set to "2." 


> >
> > There are multiple fixes in it to get it to build and test it, so far,
> > with:
> >
> >   perf top -F 15000 -d 0
> >
> > while doing kernel builds and tight usleep 1 loops to create lots of
> > short lived threads with its map_groups, maps, dsos, etc.
> >
> > Now running some build tests in some 36 containers with assorted distros
> > and cross compilers.
> 
> Tomorrow I'll inject some refcount errors to test this all.


Thank you!

Best Regards,
Elena.

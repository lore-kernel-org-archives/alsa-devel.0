From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 0/9] tools subsystem refcounter conversions
Date: Thu, 23 Feb 2017 13:23:44 -0300
Message-ID: <20170223162344.GD3595@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <20170221153935.GE5052@kernel.org>
 <20170222232329.GN20447@kernel.org>
 <20170222232917.GO20447@kernel.org>
 <2236FBA76BA1254E88B949DDB74E612B41C4F449@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id D4F3E266860
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 17:23:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C4F449@IRSMSX102.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "peterz@infradead.org" <peterz@infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "matija.glavinic-pecotic.ext@nokia.com" <matija.glavinic-pecotic.ext@nokia.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Em Thu, Feb 23, 2017 at 11:39:10AM +0000, Reshetova, Elena escreveu:
> > Em Wed, Feb 22, 2017 at 08:23:29PM -0300, Arnaldo Carvalho de Melo
> > escreveu:
> > > Em Tue, Feb 21, 2017 at 12:39:35PM -0300, Arnaldo Carvalho de Melo
> > escreveu:
> > > > Em Tue, Feb 21, 2017 at 05:34:54PM +0200, Elena Reshetova escreveu:
> > > > > Now when new refcount_t type and API are finally merged
> > > > > (see include/linux/refcount.h), the following
> > > > > patches convert various refcounters in the tools susystem from atomic_t
> > > > > to refcount_t. By doing this we prevent intentional or accidental
> > > > > underflows or overflows that can led to use-after-free vulnerabilities.
> > > >
> > > > Thanks for working on this! I was almost going to jump on doing this
> > > > myself!
> > > >
> > > > I'll try and get this merged ASAP.
> > >
> > > So, please take a look at my tmp.perf/refcount branch at:
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> 
> I took a look on it and it looks good. Just one thing I want to double check with regards to this commit:
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/acme/linux/+/58d561002587bf2572f9e6f4d222659e4068fadf%5E%21/#F0
> 
> And more specifically to this chunk:
> 
> @@ -937,7 +937,7 @@
>  		munmap(map->base, perf_mmap__mmap_len(map));
>  		map->base = NULL;
>  		map->fd = -1;
> -		atomic_set(&map->refcnt, 0);
> +		refcount_set(&map->refcnt, 0);
>  	}
>  	auxtrace_mmap__munmap(&map->auxtrace_mmap);
>  }
> 
> So, when the refcount set to zero in this place, what exactly happens to the perf_map object after? 
> I just want to double check that we don't have  another hiding reusage case here when refcounter later on is simply incremented vs. set to "2." 

So, this is an odd use of a reference count, the patch below should help
understand it?

Those perf_mmap objects are created in a batch fashion, it being zero
just means it isn't yet mmaped at all, and we check for that before
using it.

So, it remains a bug to do a dec for a zeroed refcount, and the
refcount_t infrastructure will catch it, which helps tools/.

- Arnaldo

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 564b924fb48a..5a70f08d2518 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -974,8 +974,19 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist)
 	if (!map)
 		return NULL;
 
-	for (i = 0; i < evlist->nr_mmaps; i++)
+	for (i = 0; i < evlist->nr_mmaps; i++) {
 		map[i].fd = -1;
+		/*
+		 * When the perf_mmap() call is made we grab one refcount, plus
+		 * one extra to let perf_evlist__mmap_consume() get the last
+		 * events after all real references (perf_mmap__get()) are
+		 * dropped.
+		 *
+		 * Each PERF_EVENT_IOC_SET_OUTPUT points to this mmap and
+		 * thus does perf_mmap__get() on it.
+ 		 */
+		refcount_set(&map[i].refcnt, 0);
+	}
 	return map;
 }
 
@@ -988,6 +999,7 @@ struct mmap_params {
 static int perf_mmap__mmap(struct perf_mmap *map,
 			   struct mmap_params *mp, int fd)
 {
+	perf_mmap__get(map);
 	/*
 	 * The last one will be done at perf_evlist__mmap_consume(), so that we
 	 * make sure we don't prevent tools from consuming every last event in
@@ -1001,7 +1013,7 @@ static int perf_mmap__mmap(struct perf_mmap *map,
 	 * evlist layer can't just drop it when filtering events in
 	 * perf_evlist__filter_pollfd().
 	 */
-	refcount_set(&map->refcnt, 2);
+	perf_mmap__get(map); /* This is not a dup, see the comment above! */
 	map->prev = 0;
 	map->mask = mp->mask;
 	map->base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
 
> > > There are multiple fixes in it to get it to build and test it, so far,
> > > with:
> > >
> > >   perf top -F 15000 -d 0
> > >
> > > while doing kernel builds and tight usleep 1 loops to create lots of
> > > short lived threads with its map_groups, maps, dsos, etc.
> > >
> > > Now running some build tests in some 36 containers with assorted distros
> > > and cross compilers.
> > 
> > Tomorrow I'll inject some refcount errors to test this all.
> 
> 
> Thank you!
> 
> Best Regards,
> Elena.

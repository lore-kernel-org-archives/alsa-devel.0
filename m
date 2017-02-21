From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 0/9] tools subsystem refcounter conversions
Date: Tue, 21 Feb 2017 12:39:35 -0300
Message-ID: <20170221153935.GE5052@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, peterz@infradead.org, gregkh@linuxfoundation.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org, matija.glavinic-pecotic.ext@nokia.com
List-Id: alsa-devel@alsa-project.org

Em Tue, Feb 21, 2017 at 05:34:54PM +0200, Elena Reshetova escreveu:
> Now when new refcount_t type and API are finally merged
> (see include/linux/refcount.h), the following
> patches convert various refcounters in the tools susystem from atomic_t
> to refcount_t. By doing this we prevent intentional or accidental
> underflows or overflows that can led to use-after-free vulnerabilities.

Thanks for working on this! I was almost going to jump on doing this
myself!

I'll try and get this merged ASAP.

- Arnaldo
 
> The below patches are fully independent and can be cherry-picked separately.
> Since we convert all kernel subsystems in the same fashion, resulting
> in about 300 patches, we have to group them for sending at least in some
> fashion to be manageable. Please excuse the long cc list.
> 
> Elena Reshetova (9):
>   tools: convert cgroup_sel.refcnt from atomic_t to refcount_t
>   tools: convert cpu_map.refcnt from atomic_t to refcount_t
>   tools: convert comm_str.refcnt from atomic_t to refcount_t
>   tools: convert dso.refcnt from atomic_t to refcount_t
>   tools: convert map.refcnt from atomic_t to refcount_t
>   tools: convert map_groups.refcnt from atomic_t to refcount_t
>   tools: convert perf_map.refcnt from atomic_t to refcount_t
>   tools: convert thread.refcnt from atomic_t to refcount_t
>   tools: convert thread_map.refcnt from atomic_t to refcount_t
> 
>  tools/perf/util/cgroup.c     |  6 +++---
>  tools/perf/util/cgroup.h     |  4 ++--
>  tools/perf/util/comm.c       | 13 +++++--------
>  tools/perf/util/cpumap.c     | 16 ++++++++--------
>  tools/perf/util/cpumap.h     |  4 ++--
>  tools/perf/util/dso.c        |  6 +++---
>  tools/perf/util/dso.h        |  4 ++--
>  tools/perf/util/evlist.c     | 18 +++++++++---------
>  tools/perf/util/evlist.h     |  4 ++--
>  tools/perf/util/map.c        | 10 +++++-----
>  tools/perf/util/map.h        | 10 +++++-----
>  tools/perf/util/thread.c     |  6 +++---
>  tools/perf/util/thread.h     |  4 ++--
>  tools/perf/util/thread_map.c | 20 ++++++++++----------
>  tools/perf/util/thread_map.h |  4 ++--
>  15 files changed, 63 insertions(+), 66 deletions(-)
> 
> -- 
> 2.7.4

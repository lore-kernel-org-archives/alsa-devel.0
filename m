From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 0/9] tools subsystem refcounter conversions
Date: Wed, 22 Feb 2017 20:23:29 -0300
Message-ID: <20170222232329.GN20447@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <20170221153935.GE5052@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170221153935.GE5052@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, peterz@infradead.org, gregkh@linuxfoundation.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org, matija.glavinic-pecotic.ext@nokia.com
List-Id: alsa-devel@alsa-project.org

Em Tue, Feb 21, 2017 at 12:39:35PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Feb 21, 2017 at 05:34:54PM +0200, Elena Reshetova escreveu:
> > Now when new refcount_t type and API are finally merged
> > (see include/linux/refcount.h), the following
> > patches convert various refcounters in the tools susystem from atomic_t
> > to refcount_t. By doing this we prevent intentional or accidental
> > underflows or overflows that can led to use-after-free vulnerabilities.
> 
> Thanks for working on this! I was almost going to jump on doing this
> myself!
> 
> I'll try and get this merged ASAP.

So, please take a look at my tmp.perf/refcount branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

There are multiple fixes in it to get it to build and test it, so far,
with:

  perf top -F 15000 -d 0

while doing kernel builds and tight usleep 1 loops to create lots of
short lived threads with its map_groups, maps, dsos, etc.

Now running some build tests in some 36 containers with assorted distros
and cross compilers.

- Arnaldo

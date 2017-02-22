From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/9] tools: convert comm_str.refcnt from atomic_t to
 refcount_t
Date: Wed, 22 Feb 2017 17:33:50 -0300
Message-ID: <20170222203350.GE20447@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <1487691303-31858-4-git-send-email-elena.reshetova@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487691303-31858-4-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, peterz@infradead.org, gregkh@linuxfoundation.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org, matija.glavinic-pecotic.ext@nokia.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

Em Tue, Feb 21, 2017 at 05:34:57PM +0200, Elena Reshetova escreveu:
> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.
> 
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>

You are doing two things (well three) things here:

1. converting to refcnt.h

2. Initiationg the refcount to 1, which makes this take place:

[acme@jouet linux]$ m
make: Entering directory '/home/acme/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
  CC       /tmp/build/perf/util/comm.o
  INSTALL  trace_plugins
util/comm.c:16:25: error: ‘comm_str__get’ defined but not used [-Werror=unused-function]
 static struct comm_str *comm_str__get(struct comm_str *cs)
                         ^~~~~~~~~~~~~
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.comm.o.tmp': No such file or directory
/home/acme/git/linux/tools/build/Makefile.build:101: recipe for target '/tmp/build/perf/util/comm.o' failed
make[4]: *** [/tmp/build/perf/util/comm.o] Error 1
/home/acme/git/linux/tools/build/Makefile.build:144: recipe for target 'util' failed
make[3]: *** [util] Error 2
Makefile.perf:523: recipe for target '/tmp/build/perf/libperf-in.o' failed
make[2]: *** [/tmp/build/perf/libperf-in.o] Error 2
Makefile.perf:204: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:108: recipe for target 'install-bin' failed
make: *** [install-bin] Error 2
make: Leaving directory '/home/acme/git/linux/tools/perf'
[acme@jouet linux]$

3) not test building your patches :-\

I'll let this pass this time, minor, I am removing the now unused
comm_str__get() function.

- Arnaldo

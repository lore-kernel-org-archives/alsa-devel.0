From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/9] tools: convert comm_str.refcnt from atomic_t to
 refcount_t
Date: Wed, 22 Feb 2017 19:31:04 -0300
Message-ID: <20170222223104.GK20447@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <1487691303-31858-4-git-send-email-elena.reshetova@intel.com>
 <20170222203350.GE20447@kernel.org>
 <20170222222045.GJ20447@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170222222045.GJ20447@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, peterz@infradead.org, gregkh@linuxfoundation.org, Ingo Molnar <mingo@kernel.org>, alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org, matija.glavinic-pecotic.ext@nokia.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

Em Wed, Feb 22, 2017 at 07:20:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Feb 22, 2017 at 05:33:50PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Feb 21, 2017 at 05:34:57PM +0200, Elena Reshetova escreveu:
> > > refcount_t type and corresponding API should be
> > > used instead of atomic_t when the variable is used as
> > > a reference counter. This allows to avoid accidental
> > > refcounter overflows that might lead to use-after-free
> > > situations.
> > > 
> > > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > > Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > 
> > You are doing two things (well three) things here:
> > 
> > 1. converting to refcnt.h
> > 
> > 2. Initiationg the refcount to 1, which makes this take place:
> > 
> > [acme@jouet linux]$ m
> > make: Entering directory '/home/acme/git/linux/tools/perf'
> >   BUILD:   Doing 'make -j4' parallel build
> > Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
> >   CC       /tmp/build/perf/util/comm.o
> >   INSTALL  trace_plugins
> > util/comm.c:16:25: error: ‘comm_str__get’ defined but not used [-Werror=unused-function]
> >  static struct comm_str *comm_str__get(struct comm_str *cs)
> >                          ^~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > mv: cannot stat '/tmp/build/perf/util/.comm.o.tmp': No such file or directory
> > /home/acme/git/linux/tools/build/Makefile.build:101: recipe for target '/tmp/build/perf/util/comm.o' failed
> > make[4]: *** [/tmp/build/perf/util/comm.o] Error 1
> > /home/acme/git/linux/tools/build/Makefile.build:144: recipe for target 'util' failed
> > make[3]: *** [util] Error 2
> > Makefile.perf:523: recipe for target '/tmp/build/perf/libperf-in.o' failed
> > make[2]: *** [/tmp/build/perf/libperf-in.o] Error 2
> > Makefile.perf:204: recipe for target 'sub-make' failed
> > make[1]: *** [sub-make] Error 2
> > Makefile:108: recipe for target 'install-bin' failed
> > make: *** [install-bin] Error 2
> > make: Leaving directory '/home/acme/git/linux/tools/perf'
> > [acme@jouet linux]$
> > 
> > 3) not test building your patches :-\
> > 
> > I'll let this pass this time, minor, I am removing the now unused
> > comm_str__get() function.
> 
> But it can't get unused, because the comm_str__findnew() may return an
> existing entry, that _needs_ to get its refcount bumped, that is the
> reason for this refcount to be there... reinstating it:
> 
> #0  0x00007ffff522491f in raise () from /lib64/libc.so.6
> #1  0x00007ffff522651a in abort () from /lib64/libc.so.6
> #2  0x00007ffff5268200 in __libc_message () from /lib64/libc.so.6
> #3  0x00007ffff527188a in _int_free () from /lib64/libc.so.6
> #4  0x00007ffff52752bc in free () from /lib64/libc.so.6
> #5  0x000000000051125f in comm_str__put (cs=0x35038e0) at util/comm.c:20
> #6  0x00000000005115b3 in comm__free (comm=0x6f4ee90) at util/comm.c:113
> #7  0x0000000000511e10 in thread__delete (thread=0x6f4ee10) at util/thread.c:81
> #8  0x0000000000511f0e in thread__put (thread=0x6f4ee10) at util/thread.c:103
> #9  0x0000000000504ea6 in machine__process_fork_event (machine=0x21f4bf8, event=0x7fffed6b54a0, sample=0x7fffffff8420) at util/machine.c:1496
> #10 0x0000000000505092 in machine__process_event (machine=0x21f4bf8, event=0x7fffed6b54a0, sample=0x7fffffff8420) at util/machine.c:1544
> #11 0x0000000000451ae9 in perf_top__mmap_read_idx (top=0x7fffffffa7c0, idx=3) at builtin-top.c:844
> #12 0x0000000000451bb6 in perf_top__mmap_read (top=0x7fffffffa7c0) at builtin-top.c:857
> #13 0x0000000000452229 in __cmd_top (top=0x7fffffffa7c0) at builtin-top.c:1002
> #14 0x00000000004536a3 in cmd_top (argc=0, argv=0x7fffffffe150, prefix=0x0) at builtin-top.c:1332
> #15 0x00000000004b82a8 in run_builtin (p=0xa17cd0 <commands+336>, argc=4, argv=0x7fffffffe150) at perf.c:359
> #16 0x00000000004b8515 in handle_internal_command (argc=4, argv=0x7fffffffe150) at perf.c:421
> #17 0x00000000004b865a in run_argv (argcp=0x7fffffffdf9c, argv=0x7fffffffdf90) at perf.c:467
> #18 0x00000000004b8a5d in main (argc=4, argv=0x7fffffffe150) at perf.c:614 
> 
> And this brings us to my learning experience, i.e. this should've been caught
> by this machinery, right? But that only if I leaked this object, right?
> 
> I need to read more on this, that is for sure ;-)

For reference, this is the patch on top of this:

+++ b/tools/perf/util/comm.c
@@ -13,6 +13,13 @@ struct comm_str {
 /* Should perhaps be moved to struct machine */
 static struct rb_root comm_str_root;
 
+static struct comm_str *comm_str__get(struct comm_str *cs)
+{
+       if (cs)
+               refcount_inc(&cs->refcnt);
+       return cs;
+}
+
 static void comm_str__put(struct comm_str *cs)
 {
        if (cs && refcount_dec_and_test(&cs->refcnt)) {
@@ -54,7 +61,7 @@ static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
 
                cmp = strcmp(str, iter->str);
                if (!cmp)
-                       return iter;
+                       return comm_str__get(iter);
 
                if (cmp < 0)
                        p = &(*p)->rb_left;
[acme@jouet linux]$

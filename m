From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 8/9] tools: convert thread.refcnt from atomic_t to
 refcount_t
Date: Wed, 22 Feb 2017 20:06:28 -0300
Message-ID: <20170222230628.GM20447@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <1487691303-31858-9-git-send-email-elena.reshetova@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487691303-31858-9-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, peterz@infradead.org, gregkh@linuxfoundation.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org, matija.glavinic-pecotic.ext@nokia.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

Em Tue, Feb 21, 2017 at 05:35:02PM +0200, Elena Reshetova escreveu:
> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.

You forgot this one, fixing it...

@@ -1439,7 +1439,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
        if (machine->last_match == th)
                machine->last_match = NULL;
 
-       BUG_ON(atomic_read(&th->refcnt) == 0);
+       BUG_ON(refcount_read(&th->refcnt) == 0);
        if (lock)
                pthread_rwlock_wrlock(&machine->threads_lock);
        rb_erase_init(&th->rb_node, &machine->threads);
[acme@jouet linux]$
 
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  tools/perf/util/thread.c | 6 +++---
>  tools/perf/util/thread.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index f5af87f..74e79d2 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -53,7 +53,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
>  			goto err_thread;
>  
>  		list_add(&comm->list, &thread->comm_list);
> -		atomic_set(&thread->refcnt, 1);
> +		refcount_set(&thread->refcnt, 1);
>  		RB_CLEAR_NODE(&thread->rb_node);
>  	}
>  
> @@ -88,13 +88,13 @@ void thread__delete(struct thread *thread)
>  struct thread *thread__get(struct thread *thread)
>  {
>  	if (thread)
> -		atomic_inc(&thread->refcnt);
> +		refcount_inc(&thread->refcnt);
>  	return thread;
>  }
>  
>  void thread__put(struct thread *thread)
>  {
> -	if (thread && atomic_dec_and_test(&thread->refcnt)) {
> +	if (thread && refcount_dec_and_test(&thread->refcnt)) {
>  		/*
>  		 * Remove it from the dead_threads list, as last reference
>  		 * is gone.
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 99263cb..e571885 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -1,7 +1,7 @@
>  #ifndef __PERF_THREAD_H
>  #define __PERF_THREAD_H
>  
> -#include <linux/atomic.h>
> +#include <linux/refcount.h>
>  #include <linux/rbtree.h>
>  #include <linux/list.h>
>  #include <unistd.h>
> @@ -23,7 +23,7 @@ struct thread {
>  	pid_t			tid;
>  	pid_t			ppid;
>  	int			cpu;
> -	atomic_t		refcnt;
> +	refcount_t		refcnt;
>  	char			shortname[3];
>  	bool			comm_set;
>  	int			comm_len;
> -- 
> 2.7.4

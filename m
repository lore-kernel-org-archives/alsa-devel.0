From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/9] tools: convert cgroup_sel.refcnt from atomic_t to
 refcount_t
Date: Tue, 21 Feb 2017 12:43:56 -0300
Message-ID: <20170221154356.GF5052@kernel.org>
References: <1487691303-31858-1-git-send-email-elena.reshetova@intel.com>
 <1487691303-31858-2-git-send-email-elena.reshetova@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487691303-31858-2-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, peterz@infradead.org, gregkh@linuxfoundation.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org, matija.glavinic-pecotic.ext@nokia.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

Em Tue, Feb 21, 2017 at 05:34:55PM +0200, Elena Reshetova escreveu:
> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.
>  #define __CGROUP_H__
>  
> -#include <linux/atomic.h>
> +#include <linux/refcount.h>

So this is the first one, I was expecting the copy from
include/linux/refcount.h to be made to tools/include/linux/refcount.h,
as was done for tools/include/linux/atomic.h and all the other stuff in
tools/include/

See:

commit c4b6014e8bb0c8d47fe5c71ebc604f31091e5d3f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jul 11 10:28:48 2016 -0300

    tools: Add copy of perf_event.h to tools/include/linux/

--------------

For one of the reasons we've been doing this.

- Arnaldo
  
>  struct option;
>  
>  struct cgroup_sel {
>  	char *name;
>  	int fd;
> -	atomic_t refcnt;
> +	refcount_t refcnt;
>  };
>  
>  
> -- 
> 2.7.4

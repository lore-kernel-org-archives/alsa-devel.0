From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Bug#916052: alsa-oss FTBFS with glibc 2.28
Date: Thu, 13 Dec 2018 07:32:57 +0900
Message-ID: <20181212223257.GA6732@workstation>
References: <20181212133743.n2znyydhwch6e2io@toy.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D634267C06
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 23:33:06 +0100 (CET)
Received: by mail-pf1-f194.google.com with SMTP id c123so35339pfb.0
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 14:33:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181212133743.n2znyydhwch6e2io@toy.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: 916052@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Dec 12, 2018 at 02:37:43PM +0100, Elimar Riesebieter wrote:
> Control: forwarded -1 alsa-devel@alsa-project.org
> 
> 
> Hi,
> 
> could you please investigate? It seems as alsa-oss doesn't built
> with glibc 2.28.
> 
> Thanks in advance
> Elimar
> -- 
>   Learned men are the cisterns of knowledge,
>   not the fountainheads ;-)

> Date: Sun, 09 Dec 2018 19:10:03 +0200
> From: Adrian Bunk <bunk@debian.org>
> To: Debian Bug Tracking System <submit@bugs.debian.org>
> Subject: Bug#916052: alsa-oss FTBFS with glibc 2.28
> X-Mailer: reportbug 7.5.0
> 
> Source: alsa-oss
> Version: 1.1.6-1
> Severity: serious
> Tags: ftbfs
> 
> https://tests.reproducible-builds.org/debian/rb-pkg/unstable/amd64/alsa-oss.html
> 
> ...
> In file included from alsa-oss.c:736:
> stdioemu.c:40:10: fatal error: libio.h: No such file or directory
>  #include <libio.h>
>           ^~~~~~~~~
> compilation terminated.
> make[2]: *** [Makefile:517: alsa-oss.lo] Error 1
> 

In glibc upstream, libio/libio.h had been deprecated for applications and
became internal header in its v2.28 release. We can see below message in
its release note[1].

```
* The nonstandard header files <libio.h> and <_G_config.h> are no longer
  installed.  Software that was using either header should be updated to
  use standard <stdio.h> interfaces instead.
```

I posted PR to fix the FTBFS into github.com repository[1]. (In last month
we introduced github service to our workload for reviewing/merging tasks
just for userspace stuffs.)

In next release (v1.1.7), the fix will be merged and released.

[1] https://www.sourceware.org/ml/libc-alpha/2018-08/msg00003.html
[2] https://github.com/alsa-project/alsa-oss/pull/1


Thanks

Takashi Sakamoto

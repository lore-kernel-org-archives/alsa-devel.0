From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: Bug#916052: alsa-oss FTBFS with glibc 2.28
Date: Thu, 13 Dec 2018 11:43:29 +0100
Message-ID: <20181213104329.rvxqwcbvcke2eok5@toy.home.lxtec.de>
References: <20181212133743.n2znyydhwch6e2io@toy.home.lxtec.de>
 <20181212223257.GA6732@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [176.9.242.54]) by alsa0.perex.cz (Postfix) with ESMTP id 1044F267BA5
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 11:43:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181212223257.GA6732@workstation>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: 916052@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

* Takashi Sakamoto <o-takashi@sakamocchi.jp> [2018-12-13 07:32 +0900]:

[...]

> > In file included from alsa-oss.c:736:
> > stdioemu.c:40:10: fatal error: libio.h: No such file or directory
> >  #include <libio.h>
> >           ^~~~~~~~~
> > compilation terminated.
> > make[2]: *** [Makefile:517: alsa-oss.lo] Error 1
> > 
> 
> In glibc upstream, libio/libio.h had been deprecated for applications and
> became internal header in its v2.28 release. We can see below message in
> its release note[1].
> 
> ```
> * The nonstandard header files <libio.h> and <_G_config.h> are no longer
>   installed.  Software that was using either header should be updated to
>   use standard <stdio.h> interfaces instead.
> ```
> 
> I posted PR to fix the FTBFS into github.com repository[1]. (In last month
> we introduced github service to our workload for reviewing/merging tasks
> just for userspace stuffs.)
> 
> In next release (v1.1.7), the fix will be merged and released.
> 
> [1] https://www.sourceware.org/ml/libc-alpha/2018-08/msg00003.html
> [2] https://github.com/alsa-project/alsa-oss/pull/1

Many thanks for cooperation!

Elimar
-- 
  "Talking much about oneself can also
   be a means to conceal oneself."
         -Friedrich Nietzsche

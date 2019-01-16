From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsamixer: define _GNU_SOURCE to get exp10
Date: Wed, 16 Jan 2019 13:22:53 +0100
Message-ID: <c884ec4f-6878-16bb-dfd7-cecb3efc2f8a@perex.cz>
References: <a4d4f393cbf2c09fee38e9144429690c@firemail.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 56B4E266A7C
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 13:22:56 +0100 (CET)
In-Reply-To: <a4d4f393cbf2c09fee38e9144429690c@firemail.cc>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: makepost@firemail.cc
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 16.1.2019 v 02:35 makepost@firemail.cc napsal(a):
> Fixes Master, Headphones and Speaker stuck at -8 percentage after
> building with Clang 7.0.1 and getting warned about implicit declaration
> of exp10, which is behind _GNU_SOURCE as a non-standard feature. Thanks
> Takashi Iwai for the CFLAGS suggestion on the mailing list. GCC build is
> not affected, so not adding a compiler check to the configure script.
> 
> uClibc-ng has got exp10 since 1.0.12, so the fallback macro is no longer
> needed. However, alsa-utils relies on gettext so might need further
> patches to actually work on uClibc systems.
> 
> Signed-off-by: makepost <makepost@firemail.cc>
> 
> diff --git a/alsamixer/volume_mapping.c b/alsamixer/volume_mapping.c
> index 94bd0fe..48cfbe2 100644
> --- a/alsamixer/volume_mapping.c
> +++ b/alsamixer/volume_mapping.c
> @@ -36,11 +36,6 @@
>   #include <stdbool.h>
>   #include "volume_mapping.h"
> 
> -#ifdef __UCLIBC__
> -/* 10^x = 10^(log e^x) = (e^x)^log10 = e^(x * log 10) */
> -#define exp10(x) (exp((x) * log(10)))
> -#endif /* __UCLIBC__ */
> -
>   #define MAX_LINEAR_DB_SCALE    24
> 
>   static inline bool use_linear_dB_scale(long dBmin, long dBmax)
> diff --git a/configure.ac b/configure.ac
> index 7938996..0d54942 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -350,6 +350,8 @@ if test x$alsamixer = xtrue; then
> 
> 
>     AC_MSG_RESULT([$CURSESLIB])
> +
> +  CFLAGS="$CFLAGS -D_GNU_SOURCE"

It would be propably better to put this to the local makefile for alsamixer:

diff --git a/alsamixer/Makefile.am b/alsamixer/Makefile.am
index 259b29e..249e8f8 100644
--- a/alsamixer/Makefile.am
+++ b/alsamixer/Makefile.am
@@ -1,4 +1,4 @@
-AM_CFLAGS = @CURSES_CFLAGS@ -DCURSESINC="@CURSESINC@"
+AM_CFLAGS = -D_GNU_SOURCE @CURSES_CFLAGS@ -DCURSESINC="@CURSESINC@"
 LDADD = @CURSESLIB@

 bin_PROGRAMS = alsamixer

The reason, why the problem is not visible with the standard
gcc/glibc/ncurses is that this definition is activated by ncurses:

$ find alsamixer -type f -exec grep -H GNU_SOURCE {} \;
alsamixer/Makefile:CURSES_CFLAGS = -D_GNU_SOURCE -D_DEFAULT_SOURCE
alsamixer/Makefile:NCURSESW_CFLAGS = -D_GNU_SOURCE -D_DEFAULT_SOURCE
alsamixer/Makefile:AM_CFLAGS = -D_GNU_SOURCE -D_DEFAULT_SOURCE
-DCURSESINC="<ncurses.h>"

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

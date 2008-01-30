From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: 1.0.16rc2
Date: Wed, 30 Jan 2008 12:41:46 +0000
Message-ID: <200801301241.46610.gineera@aspect135.co.uk>
References: <Pine.LNX.4.61.0801291553220.11819@tm8103.perex-int.cz>
	<200801301009.15630.gineera@aspect135.co.uk>
	<s5hd4rj4kzm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 32CEB24709
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 13:22:12 +0100 (CET)
In-Reply-To: <s5hd4rj4kzm.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 30 January 2008 11:21, Takashi wrote:
> At Wed, 30 Jan 2008 10:09:15 +0000,
>
> Alan Horstmann wrote:
> >
> > I get the following compile error:
> >
> > /usr/share/alsa1.0.16rc2/alsa-driver-1.0.16rc2/include/adriver.h:1461:
> > error: redefinition of `__ffs'
> > /lib/modules/2.4.21-99-athlon/build/include/asm/bitops.h:410: error:
> > `__ffs' previously defined here make[1]: *** [hwdep.o] Error 1
> > make[1]: Leaving directory
> > `/usr/share/alsa1.0.16rc2/alsa-driver-1.0.16rc2/acore' make: ***
> > [compile] Error 1

> Could you apply the patch below and use ./hgcompile to configure?
>
> thanks,
>
> Takashi

Patch applied OK.  Unfortunately, hgcompile complains that the Autoconf 
version is too old on this system -needs >2.59 (looks like I have 1.4o).  
What is the difference using that rather than straight configure?  Is there a 
way to work round it?

Alan



> diff -r e600ecb8fbd7 configure.in
> --- a/configure.in	Wed Jan 30 08:36:00 2008 +0100
> +++ b/configure.in	Wed Jan 30 12:22:56 2008 +0100
> @@ -2597,6 +2597,37 @@ if test "$CONFIG_HAVE_INIT_UTSNAME" = "1
>    AC_DEFINE(CONFIG_HAVE_INIT_UTSNAME)
>  fi
>
> +dnl __ffs support?
> +if test "$kversion.$kpatchlevel" = "2.6"; then
> +  CONFIG_HAVE_FFS=1
> +else
> +  AC_MSG_CHECKING(for __ffs)
> +  init_utsname="0"
> +  ac_save_CFLAGS="$CFLAGS"
> +  ac_save_CC="$CC"
> +  CFLAGS="$KERNEL_CHECK_CFLAGS"
> +  CC=$KCC
> +  AC_TRY_COMPILE([
> +#define __KERNEL__
> +#include <linux/config.h>
> +#include <linux/bitops.h>
> +],[
> +  unsigned long (*x)(unsigned long);
> +  x = __ffs;
> +],
> +    AC_MSG_RESULT(yes);have_ffs="1",
> +    AC_MSG_RESULT(no);have_ffs="0",
> +    AC_MSG_RESULT(unknown);have_ffs="0"
> +)
> +  CFLAGS=$ac_save_CFLAGS
> +  CC=$ac_save_CC
> +  CONFIG_HAVE_FFS=$have_ffs
> +fi
> +dnl AC_SUBST(CONFIG_HAVE_FFS)
> +if test "$CONFIG_HAVE_FFS" = "1"; then
> +  AC_DEFINE(CONFIG_HAVE_FFS)
> +fi
> +
>  dnl PnP supports suspend/resume?
>  if test "$CONFIG_PNP_KERNEL" = "y"; then
>    AC_MSG_CHECKING(for PnP suspend/resume)
> diff -r e600ecb8fbd7 include/adriver.h
> --- a/include/adriver.h	Wed Jan 30 08:36:00 2008 +0100
> +++ b/include/adriver.h	Wed Jan 30 12:22:56 2008 +0100
> @@ -1455,7 +1455,7 @@ static inline unsigned char snd_pci_revi
>  #endif
>  #endif
>
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 3)
> +#ifndef CONFIG_HAVE_FFS
>  #if defined(__i386__)
>  static inline unsigned long __ffs(unsigned long word)
>  {
> diff -r e600ecb8fbd7 include/config.h.in
> --- a/include/config.h.in	Wed Jan 30 08:36:00 2008 +0100
> +++ b/include/config.h.in	Wed Jan 30 12:22:56 2008 +0100
> @@ -44,6 +44,7 @@
>  #undef CONFIG_HAVE_TTY_COUNT_ATOMIC
>  #undef CONFIG_HAVE_VIDEO_GET_DRVDATA
>  #undef CONFIG_HAVE_DUMP_STACK
> +#undef CONFIG_HAVE_FFS
>
>  /* 2.2 kernels */
>  #undef CONFIG_OLD_KILL_FASYNC

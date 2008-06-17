From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ALSA 1.0.17rc2 release
Date: Tue, 17 Jun 2008 14:51:20 +0100
Message-ID: <200806171451.20967.gineera@aspect135.co.uk>
References: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
	<200806171116.27558.gineera@aspect135.co.uk>
	<Pine.LNX.4.61.0806171341290.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-1.talktalk.net [62.24.128.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 356E32446B
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 15:40:23 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0806171341290.1798@tm8103-a.perex-int.cz>
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 June 2008 12:42, you wrote:
> Could you try attached patch (also pasted bellow)?
>
> 				Thanks,
> 					Jaroslav
>
>
> diff --git a/configure.in b/configure.in
> index 1f24c7c..cf824be 100644
> --- a/configure.in
> +++ b/configure.in
> @@ -2612,6 +2612,33 @@ if test "$CONFIG_HAVE_GFP_T" = "1"; then
>    AC_DEFINE(CONFIG_HAVE_GFP_T)
>  fi
>
> +dnl Check for GFP_DMA32...
> +AC_MSG_CHECKING(for GFP_DMA32)
> +gfp_dma32="0"
> +ac_save_CFLAGS="$CFLAGS"
> +ac_save_CC="$CC"
> +CFLAGS="$KERNEL_CHECK_CFLAGS"
> +CC=$KCC
> +AC_TRY_COMPILE([
> +#define __KERNEL__
> +#include <linux/config.h>
> +#include <linux/types.h>
> +#include <linux/gfp.h>
> +],[
> +   int flags = GFP_DMA32;
> +],
> +    AC_MSG_RESULT(yes);gfp_dma32="1",
> +    AC_MSG_RESULT(no);gfp_dma32="0",
> +    AC_MSG_RESULT(unknown);gfp_dma32="0"
> +)
> +CFLAGS=$ac_save_CFLAGS
> +CC=$ac_save_CC
> +CONFIG_HAVE_GFP_DMA32=$gfp_dma32
> +dnl AC_SUBST(CONFIG_HAVE_GFP_DMA32)
> +if test "$CONFIG_HAVE_GFP_DMA32" = "1"; then
> +  AC_DEFINE(CONFIG_HAVE_GFP_DMA32)
> +fi
> +
>  dnl Check for init_utsname...
>  if test "$kversion.$kpatchlevel" = "2.6" -a $ksublevel -ge 19; then
>    CONFIG_HAVE_INIT_UTSNAME=1
> diff --git a/include/adriver.h b/include/adriver.h
> index 0c32d0d..3f5f8d6 100644
> --- a/include/adriver.h
> +++ b/include/adriver.h
> @@ -274,6 +274,10 @@ static inline struct proc_dir_entry *PDE(const struct
> inode *inode) typedef unsigned __nocast gfp_t;
>  #endif
>
> +#ifndef CONFIG_HAVE_GFP_DMA32
> +#define GFP_DMA32 GFP_DMA
> +#endif
> +
>  #include <linux/wait.h>
>  #ifndef wait_event_timeout
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
> diff --git a/include/config.h.in b/include/config.h.in
> index e5c4e02..23bee54 100644
> --- a/include/config.h.in
> +++ b/include/config.h.in
> @@ -82,3 +82,4 @@
>  #undef CONFIG_SND_HAS_DEVICE_CREATE_DRVDATA
>  #undef CONFIG_HAVE_IS_POWER_OF_2
>  #undef CONFIG_HAVE_DEPRECATED_CONFIG_H
> +#undef CONFIG_HAVE_GFP_DMA32
>
> -----

Yes, that is successful, but see my note on reply to Takashi, copied to you.

Alan

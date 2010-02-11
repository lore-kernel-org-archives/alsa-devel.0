From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Wierdness in alsa-driver configure script
Date: Thu, 11 Feb 2010 08:43:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002110841510.19278@eeebox2.perex-int.cz>
References: <4B732C5C.9020003@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A6B4710384F
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 08:43:40 +0100 (CET)
In-Reply-To: <4B732C5C.9020003@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Feb 2010, Eliot Blennerhassett wrote:

> checking for kernel version... 2.6.28-17-generic
> checking for GCC version... ./configure: eval: line 5540: syntax error
> near unexpected token `)'
> ./configure: eval: line 5540: `my_compiler_version=4.3.3-5ubuntu4)'
> Kernel compiler:  Used compiler: gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3
>
>
> gcc --version gives (yes, it is ugly!):
> gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3
> Copyright (C) 2008 Free Software Foundation, Inc.
>
> The following change works for this particular case, but perhaps there
> is a better answer?
>
> --- a/configure.in
> +++ b/configure.in
> @@ -363,7 +363,7 @@ AC_DEFUN([CHECK_COMPILER], [
>       ;;
>     [[0-9]].[[0-9]]*)
>       if test -z "$ac_compiler_version"; then
> -        ac_compiler_version="$i"
> +        ac_compiler_version=`echo $i | sed -e
> 's|[[^0-9]]*\([[0-9.]]\+\).*$|\1|'`
>       fi
>       ;;
>     esac

I applied this change to the alsa-driver git tree. The compiler check is 
not so critical these days.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: PATCH: acore/wrappers.c hosed snprintf
Date: Mon, 01 Sep 2003 17:40:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3u17wcyae.fsf@merlin.emma.line.org>
References: <20030713122813.GA13287@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030713122813.GA13287@merlin.emma.line.org> (Matthias
 Andree's message of "Sun, 13 Jul 2003 14:28:13 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

six weeks ago, I sent this patch to fix bugs in wrappers.c that are
triggered when the kernel throws warnings in ./configure (-Werror is
used there, it should not -- I've seen warnings by some kernel versions
depending on GCC version).

I haven't yet seen any response, therefore full quote.

feed this mail into this pipe: grep '^> ' | sed 's/^> //' | patch

Please report if this patch is scheduled for inclusion into alsa-driver,
is rejected permanently or other feelings you may have.

Thanks in advance.

> for some reason, alsa-driver-0.9.5 chose to use its snd_compat_*snprintf
> stuff on Linux 2.4.22-pre3-ac1. This triggered bugs in wrappers.c that
> break the compile, trivial patch below. Please apply.
>
> --- ./acore/wrappers.c.orig	2003-07-13 13:53:29.000000000 +0200
> +++ ./acore/wrappers.c	2003-07-13 13:53:43.000000000 +0200
> @@ -58,7 +58,6 @@
>  int snd_compat_vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
>  {
>  	char *ptr = (void *) __get_free_pages(GFP_KERNEL, 0);
> -	va_list args;
>  	if (ptr == NULL) {	/* should not happen - GFP_KERNEL has wait flag */
>  		if (size > 0)
>  			buf[0] = 0;
> @@ -73,9 +72,10 @@
>  int snd_compat_snprintf(char *buf, size_t size, const char * fmt, ...)
>  {
>  	int res;
> +	va_list args;
>  
>  	va_start(args, fmt);
> -	res = snd_compat_vsnprintf(buf, size, args);
> +	res = snd_compat_vsnprintf(buf, size, fmt, args);
>  	va_end(args);
>  	return res;
>  }

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: access to GPLONLY symbol SNAFU?
Date: Sat, 8 Mar 2003 15:25:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303081521560.3679-100000@pnote.perex-int.cz>
References: <3E697BAA.7E7E2A59@sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E697BAA.7E7E2A59@sun.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Bomers <Florian.Bomers@sun.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Mar 2003, Florian Bomers wrote:

> Hi,
> 
> just tried to ALSA 0.9.0rc8b on a stock-Redhat 8.0 with redhat kernel 2.4.18-14. I got a
> series of similar warnings:
> 
> 
> ...
> In file included from /root/alsa-driver-0.9.0rc8b/include/sound/driver.h:43,
>                  from ../../alsa-kernel/core/ioctl32/ioctl32.c:21,
>                  from ioctl32.c:2:
> /root/alsa-driver-0.9.0rc8b/include/adriver.h:325:1: warning: "vmalloc_to_page" redefined
> In file included from /usr/src/linux-2.4.18-14/include/linux/modversions.h:1217,
>                  from /root/alsa-driver-0.9.0rc8b/include/adriver.h:40,
>                  from /root/alsa-driver-0.9.0rc8b/include/sound/driver.h:43,
>                  from ../../alsa-kernel/core/ioctl32/ioctl32.c:21,
>                  from ioctl32.c:2:
> /usr/src/linux-2.4.18-14/include/linux/modules/ksyms.ver:2892:1: warning: this
> ...
> 
> 
> I saw that the patch suggested by Takashi (see below) was integrated in 0.9.0rc8b - but I
> guess it doesn't apply to my 2.4.18 kernel, because when I changed it, compilation went
> through fine:
> 
> alsa-driver/include/adriver.h:322
> 
>         /* vmalloc_to_page wrapper */
> -       #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 19)
> +       #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 18)
>         struct page *snd_compat_vmalloc_to_page(void *addr);
>         #define vmalloc_to_page(addr) snd_compat_vmalloc_to_page(addr)
>         #endif

This problem will be fixed in the 0.9.0rc8d driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com

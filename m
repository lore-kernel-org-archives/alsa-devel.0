From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: access to GPLONLY symbol SNAFU?
Date: Fri, 07 Mar 2003 21:12:10 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E697BAA.7E7E2A59@sun.com>
References: <E18qIp2-00048W-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

just tried to ALSA 0.9.0rc8b on a stock-Redhat 8.0 with redhat kernel 2.4.18-14. I got a
series of similar warnings:


...
In file included from /root/alsa-driver-0.9.0rc8b/include/sound/driver.h:43,
                 from ../../alsa-kernel/core/ioctl32/ioctl32.c:21,
                 from ioctl32.c:2:
/root/alsa-driver-0.9.0rc8b/include/adriver.h:325:1: warning: "vmalloc_to_page" redefined
In file included from /usr/src/linux-2.4.18-14/include/linux/modversions.h:1217,
                 from /root/alsa-driver-0.9.0rc8b/include/adriver.h:40,
                 from /root/alsa-driver-0.9.0rc8b/include/sound/driver.h:43,
                 from ../../alsa-kernel/core/ioctl32/ioctl32.c:21,
                 from ioctl32.c:2:
/usr/src/linux-2.4.18-14/include/linux/modules/ksyms.ver:2892:1: warning: this
...


I saw that the patch suggested by Takashi (see below) was integrated in 0.9.0rc8b - but I
guess it doesn't apply to my 2.4.18 kernel, because when I changed it, compilation went
through fine:

alsa-driver/include/adriver.h:322

        /* vmalloc_to_page wrapper */
-       #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 19)
+       #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 18)
        struct page *snd_compat_vmalloc_to_page(void *addr);
        #define vmalloc_to_page(addr) snd_compat_vmalloc_to_page(addr)
        #endif

and analogous changes in
alsa-driver/acore/memory_wrapper.c
alsa-driver/acore/memalloc.c.

Maybe you should verify in which kernel version this modification was actually made to the
vmalloc thing...

Florian


> 
> Message: 7
> Date: Tue, 04 Mar 2003 17:30:30 +0100
> From: Takashi Iwai <tiwai@suse.de>
> To: Paul Davis <paul@linuxaudiosystems.com>
> Cc: Jaroslav Kysela <perex@suse.cz>,
>         "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
> Subject: Re: [Alsa-devel] access to GPLONLY symbol SNAFU?
> 
> At Tue, 04 Mar 2003 11:09:14 -0500,
> Paul Davis wrote:
> >
> > >> module-init-tools 0.9.10
> > >  ^^^^^^^^^^^^^^^^^
> > >
> > >Probably bug in this package. I don't know the exact status of modules in
> > >2.5 (it's dramaticaly changing), but all ALSA modules are GPLed, thus this
> > >problem shouldn't occur.
> >
> > good first guess, but no luck. i uninstalled it, reinstalled modutils
> > 2.4.9, and the same problem occurs.
> 
> modutils-2.4.9 is fairly old..  isn't it 2.4.19?
> 
> > i don't understand how this
> > happens: the kernel image contains only vmalloc_to_page, but
> > /proc/ksyms has only the GPL version. i was hoping that someone with
> > even more experience of this than i might have an idea what has gone
> > wrong. it all works under 2.5 BTW, but i can't use 2.5 right now
> > because the main serial driver is broken.
> 
> not the real solution but a workaround would be to change the
> condition in alsa-driver/include/adriver.h line 322 like below
> 
>         /* vmalloc_to_page wrapper */
> ==>     #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 19)
>         struct page *snd_compat_vmalloc_to_page(void *addr);
>         #define vmalloc_to_page(addr) snd_compat_vmalloc_to_page(addr)
>         #endif
> 
> and the corresponding part definition in
> alsa-driver/acore/memory_wrapper.c and
> EXPORT_SYMBOL() in alsa-driver/acore/sound.c.
> 
> or, try 2.4.20 or later.  it's changed as without GPL suffix.
> 
> ciao,
> 
> Takashi
> 
> --__--__--
> 
> Message: 8
> Date: Tue, 4 Mar 2003 17:40:59 +0100
> From: Martin Langer <martin-langer@gmx.de>
> To: Paul Davis <paul@linuxaudiosystems.com>, perex@suse.cz
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] access to GPLONLY symbol SNAFU?
> 
> On Tue, Mar 04, 2003 at 11:09:14AM -0500, Paul Davis wrote:
> > >> module-init-tools 0.9.10
> > >  ^^^^^^^^^^^^^^^^^
> > >
> > >Probably bug in this package. I don't know the exact status of modules in
> > >2.5 (it's dramaticaly changing), but all ALSA modules are GPLed, thus this
> > >problem shouldn't occur.
> >
> > good first guess, but no luck. i uninstalled it, reinstalled modutils
> > 2.4.9, and the same problem occurs. i don't understand how this
> > happens: the kernel image contains only vmalloc_to_page, but
> > /proc/ksyms has only the GPL version. i was hoping that someone with
> > even more experience of this than i might have an idea what has gone
> > wrong. it all works under 2.5 BTW, but i can't use 2.5 right now
> > because the main serial driver is broken.
> >
> 
> Hmmmm don't know, but I found a small bug in hdsp.c.
> 
> martin
> 
> --- hdsp.c.ORIGINAL     Tue Mar  4 17:33:50 2003
> +++ hdsp.c      Tue Mar  4 17:34:32 2003
> @@ -72,7 +72,7 @@
>  MODULE_DESCRIPTION("RME Hammerfall DSP");
>  MODULE_LICENSE("GPL");
>  MODULE_CLASSES("{sound}");
> -MODULE_DEVICES("{{RME,Hammerfall-DSP},");
> +MODULE_DEVICES("{{RME,Hammerfall-DSP}}");
> 
>  typedef enum {
>         Digiface,
> 
> --__--__--
> 
> Message: 9
> To: Takashi Iwai <tiwai@suse.de>
> cc: Jaroslav Kysela <perex@suse.cz>,
>     "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
> Subject: Re: [Alsa-devel] access to GPLONLY symbol SNAFU?
> Date: Tue, 04 Mar 2003 11:44:03 -0500
> From: Paul Davis <paul@linuxaudiosystems.com>
> 
> >> good first guess, but no luck. i uninstalled it, reinstalled modutils
> >> 2.4.9, and the same problem occurs.
> >
> >modutils-2.4.9 is fairly old..  isn't it 2.4.19?
> 
> GACK!! this is what happens when the output of ftp's "ls" command
> scrolls off the screen, and you conclude that 2.4.9 is the latest.
> 
> reinstalling 2.4.19 fixes the problem. thanks takashi!
> 
> --p
> 
> --__--__--
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> End of Alsa-devel Digest

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com

From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: questions for alsa-devel
Date: Wed, 02 Oct 2002 15:17:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2ptutdlpl.fsf@vador.mandrakesoft.com>
References: <200210021157.g92Bvvk12578@op.net> <s5hu1k5j939.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu1k5j939.wl@alsa2.suse.de> (Takashi Iwai's message of "Wed,
 02 Oct 2002 14:53:14 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <pbd@op.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > 2) i recently compiled rc3 on a mandrake 8.2 system. everything
> > went smoothly. when i went to modprobe, i got messages suggesting
> > to me that there a mismatch between the kernels and the ALSA
> > modules with respect to symbol versioning. (several missing
> > symbols, all with versions). i've looked through the archives and
> > tried google, but i can't see how to fix this or if something else
> > is going on.

1) "make mrproper" should be the first step when recompiling a kernel
   from the kernel-source package since it has previously be used to
   compile our various kernel (up, smp, enterprise [smp+highmem],
   secure, linus (no patches), BOOT [for drakx installer]).

   most people don't do it and have problems.

2) alter the extraversion in main Makefile so that you don't screw up
   the mandrake kernel if you make something wrong (there's a rescue
   on the first cd but just avoid troubles)
   eg: in mdk9.0, we now alter it by default ("EXTRAVERSION = -16mdk"
   became "EXTRAVERSION = -16mdkcustom")

these 2 items should prevent versionning problems regarding modules

3) you can then steal the mdk kernel config from /boot/config (link on
   /boot/config-2.4.....)

4) note that if you boot with a kernel with alsa-0.9.0, all your alsa
   apps won't work unless you use them in oss emulation mode.

   it may be a lot simpler to update to mdk9.0, either by urpmi or by
   running drakx from cds or the net (just cat images/network.img on a
   floppy)

> most likely the driver was built with the incompatible kernel tree.
> please check whether you installed the correct kernel-source package
> and configure points the right directory (you can pass the directory
> via --with-kernel option).

alsa default to /usr/src/linux which should be a link to
linux-2.4.8...

it might just be simpler to steal juan patch that put alsa in sound
directory (look at linux-2.4.19-qX tarball and the mdk9.0 srpm spec
file)

but then, it's even simpler to recompile the srpm or just install the
binary rpm from mdk9.0 ...

> or, it could be a problem of rc3.  i've never compiled with module
> version.  could you show which symbols are missing?

hum, mdk9.0 is compiled with module versionning and we've no problems
(i mean there're bugs but not such problems)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

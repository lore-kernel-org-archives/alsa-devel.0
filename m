From: Ian Grant <Ian.Grant@cl.cam.ac.uk>
Subject: Re: alsa-driver-0.9.0rc3 patch
Date: Thu, 12 Sep 2002 17:10:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17pWYG-0002cg-00@wisbech.cl.cam.ac.uk>
References: <tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Message from Takashi Iwai <tiwai@suse.de>
   of "Thu, 12 Sep 2002 17:39:55 +0200." <s5h4rcvp67o.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ian Grant <Ian.Grant@cl.cam.ac.uk>, alsa-devel@lists.sourceforge.netIan.Grant@cl.cam.ac.uk
List-Id: alsa-devel@alsa-project.org

> At Thu, 12 Sep 2002 16:23:56 +0100,
> Ian Grant wrote:
> > 
> > Here is a patch for the toplevel Makefile to remove the $DESTDIR from the path 
> > of the System.map file where we check for its existence. This makes the 
> > existence check test the same file location as is used in the subsequent -F 
> > option to depmod. It works for me!
> 
> $DESTDIR is necessary in path, too, because depmod is invoked with
> "-b $DESTDIR" option.  the system-map path becomes relative to the
> $DESTDIR, then. 

I don't think this is correct. The system map is loaded only at the time 
depmod is run and comes from the kernel build directory 
$(CONFIG_SND_KERNELDIR); its path is not modified by the -b option. The kernel 
build directory is an absolute path to some scratch space somewhere - a home 
directory perhaps. $DESTDIR is the place where the modules will be installed 
so there is no System.map under $(DESTDIR)$(CONFIG_SND_KERNELDIR), but in the 
Makefile that is what is tested before it is decided to supply the

       -F $(CONFIG_SND_KERNELDIR)/Sytem.map

option to depmod.

My patch brings the test in line with the option. I cannot see why these two 
things should be different.

> i think it would be much easier to stop invoking depmod if DESTDIR is
> specified.  DESTDIR is used normally for building packages, and
> obviously in such a case, depmod is not necessary.

It updates the $(DESTDIR)/lib/modules/x.x.x/modules.info which is useful. My 
package includes a kernel, the modules and the module dependencies.

> (btw, the error code of depmod is ignored, so the error messages from
> depmod don't matter.)

But they are not nice - there is an error message for every module.


-- 
Ian Grant, Computer Lab., William Gates Building, JJ Thomson Ave., Cambridge
Phone: +44 1223 334420




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 1.0.4rc1 release
Date: Wed, 31 Mar 2004 09:31:16 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403310905140.20838-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0403301603190.1835@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0403301603190.1835@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 30 Mar 2004, Clemens Ladisch wrote:
> > On a 2.2.19 kernel:
> >
> > depmod: *** Unresolved symbols in /lib/modules/2.2.19/misc/snd-*
> > ...
>
> Missing inclusion of some header files?

Sorry, my error.  Wrong kernel configuration.  (The result of "Hey,
this old file looks like a kernel -- let's see what happens if I boot
it ..."  ;-)

But now:

# modprobe snd
modprobe: Too deep recursion in module dependencies!
modprobe: Circular dependency? snd-page-alloc snd

snd_pci_compat_get_pci_driver() is called from
pci_compat_pm_callback() in misc.c.  I think the 2.2.x CONFIG_APM
stuff in misc.c could be moved into pci_compat_22.c, but OTOH it might
make more sense to move the PCI functions that don't do page
allocation from the snd-page-alloc module into snd.  What's your
opinion on this?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

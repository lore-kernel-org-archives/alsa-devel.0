From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 1.0.4rc1 release
Date: Wed, 31 Mar 2004 10:50:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403311048270.1950@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403310905140.20838-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403310905140.20838-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 31 Mar 2004, Clemens Ladisch wrote:

> But now:
> 
> # modprobe snd
> modprobe: Too deep recursion in module dependencies!
> modprobe: Circular dependency? snd-page-alloc snd
> 
> snd_pci_compat_get_pci_driver() is called from
> pci_compat_pm_callback() in misc.c.  I think the 2.2.x CONFIG_APM

I don't see the circular dependency for this function. 
snd_pci_compat_get_pci_driver() is defined in snd-page-alloc
and pci_compat_pm_callback() does not define it. I'm missing
something?

> stuff in misc.c could be moved into pci_compat_22.c, but OTOH it might
> make more sense to move the PCI functions that don't do page
> allocation from the snd-page-alloc module into snd.  What's your
> opinion on this?

I don't mind so much. But having related compatibility stuff at one place 
also makes sense.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

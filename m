From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 1.0.4rc1 release
Date: Wed, 31 Mar 2004 18:20:23 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403311808570.3246-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0403311048270.1950@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0403311048270.1950@pnote.perex-int.cz>
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

> On Wed, 31 Mar 2004, Clemens Ladisch wrote:
>
> > But now:
> >
> > # modprobe snd
> > modprobe: Too deep recursion in module dependencies!
> > modprobe: Circular dependency? snd-page-alloc snd
> >
> > snd_pci_compat_get_pci_driver() is called from
> > pci_compat_pm_callback() in misc.c.
>
> I don't see the circular dependency for this function.

Sorry, I didn't remember that snd-page-alloc should not depend on snd.

The circular dependency is caused by snd_pci_compat_request_region()
which calls request_region() which is #defined to be
snd_wrapper_request_region() in wrappers.c.

snd_pci_compat_request_region() clearly didn't intend to use the
wrapper function, so I added another wrapper function to call the
original function.


Now the modules load.  However, loading snd-usb-audio doesn't do
anything, and unloading and reloading it results in a crash or a hang.
Still debugging ...


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

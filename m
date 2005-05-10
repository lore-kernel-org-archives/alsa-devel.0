From: Greg KH <greg@kroah.com>
Subject: Re: [Alsa-devel] snd-usb-audio driver
Date: Tue, 10 May 2005 14:43:00 -0700
Message-ID: <20050510214300.GA4292@kroah.com>
References: <Pine.HPX.4.33n.0505090919440.20877-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hotplug-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0505090919440.20877-100000@studcom.urz.uni-halle.de>
Sender: linux-hotplug-devel-admin@lists.sourceforge.net
Errors-To: linux-hotplug-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-hotplug-devel@lists.sourceforge.net>
List-Help: <mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-hotplug-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, May 09, 2005 at 09:41:19AM +0200, Clemens Ladisch wrote:
> Greg KH wrote:
> > On Fri, Apr 29, 2005 at 05:01:42PM -0400, David Zeuthen wrote:
> > > On Fri, 2005-04-29 at 13:09 -0700, Greg KH wrote:
> > > > You can do this, as you get two different hotplug events.  This is
> > > > because usb drivers bind to the USB inteface, not the main device
> > > > itself.
> > >
> > > As an unrelated note this is actually not true for snd-usb-audio driver
> > >
> > >         [davidz@daxter hal]$ ls -l /sys/class/sound/pcmC2D0c/
> > >         total 0
> > >         -r--r--r--  1 root root 4096 Apr 29 16:57 dev
> > >         lrwxrwxrwx  1 root root    0 Apr 29 16:57 device ->
> > > ../../../devices/pci0000:00/0000:00:1d.1/usb3/3-2
> >
> > This should point to the interface, not the device, you are correct.
> >
> > >         [davidz@daxter hal]$ tree /sys/bus/usb/drivers/snd-usb-audio/
> > >         /sys/bus/usb/drivers/snd-usb-audio/
> > >         |-- 3-2:1.0 -> ../../../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0
> > >         |-- 3-2:1.1 -> ../../../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.1
> > >         |-- 3-2:1.2 -> ../../../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.2
> > >         `-- module -> ../../../../module/snd_usb_audio
> > >
> > > That"s a bug, right? Is this the right place to report it?
> >
> > Bug in the alsa driver, I suggest reporting it to them.  Should be a one
> > line fix.
> 
> The ALSA framework currently has exactly one 'struct device' for all
> devices of a sound card.  If we want to bind to the respectively
> correct interface for each device we have to change more than one
> line.
> 
> I'll make a temporary fix to bind to the first interface that is
> probed.

That will not work a usb speaker device that has the first interface as
the usb keyboard :)

Why not just point the struct device for ALSA at the struct
usb_interface that is passed to you?  That's the proper one to use.

thanks,

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click

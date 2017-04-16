From: Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
Subject: Re: [PATCH 2/3] docs-rst/usb: usb/devices is now at
 /sys/kernel/debug/
Date: Sun, 16 Apr 2017 13:43:03 -0300
Message-ID: <20170416134303.1a65ec54@vento.lan>
References: <45a6d81c0abd5a7391ebcce561ad37010d6071d4.1492352510.git.mchehab@s-opensource.com>
        <Pine.LNX.4.44L0.1704161035280.10702-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1704161035280.10702-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux Doc Mailing List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Em Sun, 16 Apr 2017 10:39:58 -0400 (EDT)
Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> escreveu:

> On Sun, 16 Apr 2017, Mauro Carvalho Chehab wrote:
> 
> > The /proc/bus/usb/devices got moved to sysfs. It is now
> > sitting	at:
> >         /sys/kernel/debug/usb/devices
> > 
> > Fix the old references at the USB documentation  
> 
> Many of the things you changed are still out of date.
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
> > ---
> >  Documentation/driver-api/usb/usb.rst | 14 +++++++-------
> >  Documentation/usb/acm.txt            |  2 +-
> >  Documentation/usb/gadget_serial.txt  |  4 ++--
> >  Documentation/usb/proc_usb_info.txt  | 20 ++++++++++----------
> >  4 files changed, 20 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/driver-api/usb/usb.rst b/Documentation/driver-api/usb/usb.rst
> > index 6824089ef4c8..036e77038d42 100644
> > --- a/Documentation/driver-api/usb/usb.rst
> > +++ b/Documentation/driver-api/usb/usb.rst
> > @@ -233,7 +233,7 @@ What files are in "usbfs"?
> >  
> >  Conventionally mounted at ``/proc/bus/usb``, usbfs features include:  
> 
> This whole section is highly misleading.  usbfs no longer exists as a 
> filesystem.  Instead, the files which used to be part of usbfs have 
> either moved to debugfs (/sys/kernel/debug/usb/devices) or are 
> character device nodes managed by systemctl/udev and typically created 
> under /dev/bus/usb.
> 
> > @@ -299,23 +299,23 @@ invocations of *mount*, are:
> >      0)
> >  
> >  *listgid*\ =NNNNN
> > -    Controls the GID used for the /proc/bus/usb/devices and drivers
> > +    Controls the GID used for the /sys/kernel/debug/usb/devices and drivers
> >      files. (Default: 0)
> >  
> >  *listmode*\ =MMM
> > -    Controls the file mode used for the /proc/bus/usb/devices and
> > +    Controls the file mode used for the /sys/kernel/debug/usb/devices and
> >      drivers files. (Default: 0444)
> >  
> >  *listuid*\ =NNNNN
> > -    Controls the UID used for the /proc/bus/usb/devices and drivers
> > +    Controls the UID used for the /sys/kernel/debug/usb/devices and drivers
> >      files. (Default: 0)
> >  
> >  Note that many Linux distributions hard-wire the mount options for usbfs
> >  in their init scripts, such as ``/etc/rc.d/rc.sysinit``, rather than
> >  making it easy to set this per-system policy in ``/etc/fstab``.  
> 
> This is all totally out of date.  usbfs is no longer a filesystem that
> can be mounted.

True. Sent already a new patchset covering it, and other places where
/proc/bus/bus are mentioned.

Besides the stuff already fixed, there are still a few other bits
to address:

Documentation/usb/proc_usb_info.txt:/proc/bus/usb filesystem output
Documentation/usb/proc_usb_info.txt:/proc/bus/usb.  It provides the /sys/kernel/debug/usb/devices file, as well as
Documentation/usb/proc_usb_info.txt:the /proc/bus/usb/BBB/DDD files.
Documentation/usb/proc_usb_info.txt:**NOTE**: If /proc/bus/usb appears empty, and a host controller
Documentation/usb/proc_usb_info.txt:      mount -t usbfs none /proc/bus/usb
Documentation/usb/proc_usb_info.txt:      none  /proc/bus/usb  usbfs  defaults  0  0
Documentation/usb/proc_usb_info.txt:THE /proc/bus/usb/BBB/DDD FILES:
Documentation/usb/proc_usb_info.txt:devices.  You would open the /proc/bus/usb/BBB/DDD file read/write,

This should likely be merged at usb.rst file or fully reworked.

include/uapi/linux/capability.h:/* Allow sending USB messages to any device via /proc/bus/usb */
include/uapi/linux/usb/ch9.h: * not other descriptors) are read from usbfs (i.e. /proc/bus/usb/BBB/DDD);

I'll address this on a version 4.

sound/usb/usx2y/us122l.c:       sprintf(hw->name, "/proc/bus/usb/%03d/%03d/hwdeppcm",
sound/usb/usx2y/usX2Yhwdep.c:   sprintf(hw->name, "/proc/bus/usb/%03d/%03d", device->bus->busnum, device->devnum);
sound/usb/usx2y/usx2yhwdeppcm.c:        sprintf(hw->name, "/proc/bus/usb/%03d/%03d/hwdeppcm", dev->bus->busnum, dev->devnum);

Not sure about the above.

Regards,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

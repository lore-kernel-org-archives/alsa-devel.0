From: cliffw@easystreet.com
Subject: Re: usb-audio - kernel oops 2.5.72
Date: Sun, 29 Jun 2003 09:14:46 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306291614.h5TGEks6012086@oldred.easystreet.com>
References: <s5hptl52bje.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 23 Jun 2003 15:01:09 +0200."
             <s5hptl52bje.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> At Sun, 22 Jun 2003 20:45:09 -0700,
> cliffw@easystreet.com wrote:
> > 
> > 
> > Am attempting to get linux-2.5.72 + snd-usb-audio happening.
> > Results have been poor. Machine is VIA C3, ALSA + jack working 
> > fine with the built-in via audio. Tried various kernels, 
> > real ugly failures with 2.5.70, also have tried 2.5.72-mm2. 
> 
> i fixed a bug in usb-audio driver on the cvs now.
> there are some calls of functions which may call schedule() in the
> spinlock.
> 
> please try the cvs version.
> 
> 

CVS version does not throw the oops, but the device still fails. 
2.5.73 stock still has the oops. 
2.5.73 + cvs does not throw the oops, but the devices
i've tried are still not connecting properly.
Appears to be an issue at usb_submit_urb(), but i'm not deep 
enough to figure it out.
Will gladly furnish more data upon request, or test patches.
Please advise.

Current errors (dmesg):
sb 2-1: usb_new_device - registering interface 2-1:1
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: usb_new_device - registering interface 2-1:2
drivers/usb/core/usb.c: usb_hotplug
ALSA sound/usb/usbaudio.c:1080: setting usb interface 1:1
ALSA sound/usb/usbaudio.c:685: cannot submit datapipe for urb 0, err = -22
usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 3 rqt 128 rq 6 len 256 ret -32
cliffw


> ciao,
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01

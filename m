From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Mon, 16 Feb 2004 19:36:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076956588.2859.6.camel@chief.local>
References: <Pine.HPX.4.33n.0402161110040.4733-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402161110040.4733-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Clemens Ladisch wrote:
> Hartmut Geissbauer wrote:
> > Clemens Ladisch wrote:
> > > The problem is that the kernel automatically selects the first
> > > configuration.  Please try the patch below.
> >
> > drivers/usb/core/usb.c: usb_hotplug
> > usb 1-2.4: configuration #1 chosen from 2 choices
> > usb 1-2.4: registering 1-2.4:1.0 (config #1, interface 0)
> > drivers/usb/core/usb.c: usb_hotplug
> > snd-usb-audio 1-2.4:1.0: usb_probe_interface
> > snd-usb-audio 1-2.4:1.0: usb_probe_interface - got id
> >
> > The device is not appearing in /proc/asound.
> 
> Does the new configuration (the audio interfaces) show up in
> /proc/bus/usb/devices?  What happens when you re-load snd-usb-audio
> after that?
> 

Additional to my previous posting some remarks:

I tried it vice versa. (first unloading snd-usb-audio then plugging the
device)
Now it appears in /proc/bus/usb/devices

But the output /var/log/messages seems a little bit bad in the end.
 
Feb 16 19:22:36 chief kernel: drivers/usb/core/usb.c: deregistering
driver snd-usb-audio
Feb 16 19:23:18 chief kernel: hub 1-2:1.0: port 4, status 101, change 1,
12 Mb/s
Feb 16 19:23:18 chief kernel: hub 1-2:1.0: debounce: port 4: delay 100ms
stable 4 status 0x101
Feb 16 19:23:18 chief kernel: hub 1-2:1.0: port 4 not reset yet, waiting
10ms
Feb 16 19:23:18 chief kernel: usb 1-2.4: new full speed USB device using
address 3
Feb 16 19:23:18 chief kernel: usb 1-2.4: new device strings: Mfr=1,
Product=2, SerialNumber=0
Feb 16 19:23:18 chief kernel: drivers/usb/core/message.c: USB device
number 3 default language ID 0x409
Feb 16 19:23:18 chief kernel: usb 1-2.4: Product: CreamWare Noah
Synthesizer
Feb 16 19:23:18 chief kernel: usb 1-2.4: Manufacturer: CreamWare GmbH
Feb 16 19:23:18 chief kernel: drivers/usb/core/usb.c: usb_hotplug
Feb 16 19:23:18 chief kernel: usb 1-2.4: configuration #1 chosen from 2
choices
Feb 16 19:23:18 chief kernel: usb 1-2.4: registering 1-2.4:1.0 (config
#1, interface 0)
Feb 16 19:23:18 chief kernel: drivers/usb/core/usb.c: usb_hotplug
Feb 16 19:23:18 chief usb.agent[2413]: Keeping default configuration
with /sys//devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2.4
Feb 16 19:23:19 chief kernel: snd-usb-audio 1-2.4:1.0:
usb_probe_interface
Feb 16 19:23:19 chief kernel: snd-usb-audio 1-2.4:1.0:
usb_probe_interface - got id
Feb 16 19:23:19 chief kernel: usb 1-2.4: usb_disable_device nuking
non-ep0 URBs
Feb 16 19:23:19 chief kernel: usb 1-2.4: unregistering interface
1-2.4:1.0

> 
> Regards,
> Clemens
> 

Thank you for your answers, Hartmut
-- 
Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

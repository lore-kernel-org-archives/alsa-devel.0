From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Sat, 14 Feb 2004 21:14:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076789647.2475.5.camel@chief.local>
References: <Pine.HPX.4.33n.0402111431430.12076-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402111431430.12076-100000@studcom.urz.uni-halle.de>
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

Hi Clemens

Clemens Ladisch wrote: 
> Hartmut Geissbauer wrote:
> > I own a piece of hardware called Noah EX. It's a "tactive
> > instrument modeller".
> > My goal is to get this device working with the alsa usb driver,
> > because the output of lsusb -v leads me to the hope, that it has a
> > standard usb audio interface.
> > ...
> > Interface Descriptor:
> >   bInterfaceClass         1 Audio
> >   bInterfaceSubClass      1 Control Device
> >   ...
> >   bInterfaceSubClass      2 Streaming       (= PCM)
> >   ...
> >   bInterfaceSubClass      3 Non Streaming   (= MIDI)
> 
> Well, this device indeed has standard descriptors.
> 
> > What I discoverd yet, is that the device is offering two
> > configurations. And the second is the audio and midi related one.
> > The first seems to be the configuration "channel".
> 
> > Feb  5 00:28:33 chief kernel: usb 1-2.4: configuration #1 chosen from 2 choices
> 
> The problem is that the kernel automatically selects the first
> configuration.  Please try the patch below.
> 
> 
> HTH
> Clemens

sorry for responding that late. I've been out for skiing for a few days.

I tried the patch applying it at last to kernel 2.6.3-rc-2 to get away
from the unresolved symbol "usb_get_device_descriptor".

So now the dmesg command shows me:

hub 1-2:1.0: port 4, status 101, change 1, 12 Mb/s
hub 1-2:1.0: debounce: port 4: delay 100ms stable 4 status 0x101
hub 1-2:1.0: port 4 not reset yet, waiting 10ms
usb 1-2.4: new full speed USB device using address 3
usb 1-2.4: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 3 default language ID
0x409
usb 1-2.4: Product: CreamWare Noah Synthesizer
usb 1-2.4: Manufacturer: CreamWare GmbH
drivers/usb/core/usb.c: usb_hotplug
usb 1-2.4: configuration #1 chosen from 2 choices
usb 1-2.4: registering 1-2.4:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
snd-usb-audio 1-2.4:1.0: usb_probe_interface
snd-usb-audio 1-2.4:1.0: usb_probe_interface - got id

The device is not appearing in /proc/asound.

After that action, the usb-stack is stuck. Not recognizing any new
connects or disconnects. I tried to compile the kernel with ohci (that's
my controller type) as a module and built in.

The same behaviour appears after removing a M-Audio Midisport4x4 from
the usb port. It works only one time. (Plugging it in, it is working,
plug it out, the usb stack is dead)
So it seems, that there is something wrong with the usb stack in 2.6.x

Hartmut

-- 

Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

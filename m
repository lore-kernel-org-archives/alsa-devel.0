From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Mon, 16 Feb 2004 19:18:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076955490.2515.11.camel@chief.local>
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
> /proc/bus/usb/devices?  

No.

> What happens when you re-load snd-usb-audio
> after that?
> 

'rmmod snd-usb-audio' does not return to the command prompt. A 'modprobe
snd-usb-audio'  on another xterm after the rmmod as well.

dmesg shows me:
drivers/usb/core/usb.c: deregistering driver snd-usb-audio

I tried to connect the device via a hub and direct. No difference.

> 
> Regards,
> Clemens
> 

Thank you for your answer, Hartmut

-- 
Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

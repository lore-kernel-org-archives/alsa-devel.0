From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Tue, 17 Feb 2004 13:43:40 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402171255310.21550-100000@studcom.urz.uni-halle.de>
References: <1076956588.2859.6.camel@chief.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1076956588.2859.6.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hartmut Geissbauer <nwgbh@swissonline.ch>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hartmut Geissbauer wrote:
> I tried it vice versa. (first unloading snd-usb-audio then plugging the
> device)
> Now it appears in /proc/bus/usb/devices

I guess "it" is the device and not the audio interfaces.

> But the output /var/log/messages seems a little bit bad in the end.
>
> kernel: usb 1-2.4: configuration #1 chosen from 2 choices
> kernel: usb 1-2.4: registering 1-2.4:1.0 (config #1, interface 0)
> kernel: drivers/usb/core/usb.c: usb_hotplug
> usb.agent[2413]: Keeping default configuration with /sys//devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2.4
> kernel: snd-usb-audio 1-2.4:1.0: usb_probe_interface
> kernel: snd-usb-audio 1-2.4:1.0: usb_probe_interface - got id
> kernel: usb 1-2.4: usb_disable_device nuking non-ep0 URBs
> kernel: usb 1-2.4: unregistering interface 1-2.4:1.0

The last two lines _may_ be correct when the configuration changes.

Could you try to re-load snd-usb-audio (now, hopefully, with the new
configuration)?


If that doesn't work, it would be possible to write a separate program
that switches the configuration, so that the audio driver can be
loaded later.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

From: Luke Yelavich <luke@audioslack.com>
Subject: Re: MAYA44 USB audio device doesn't work with
  1.0.4.
Date: Fri, 28 May 2004 08:32:37 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <6.0.0.22.2.20040528082652.01f45930@mail.audioslack.com>
References: <6.0.0.22.2.20040527223152.01f32510@mail.audioslack.com>
 <Pine.HPX.4.33n.0405271511470.6236-100000@studcom.urz.uni-halle.de> <Pine.HPX.4.33n.0405271511470.6236-100000@studcom.urz.uni-h
 alle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405271511470.6236-100000@studcom.urz.uni-h
 alle.de>
References: <6.0.0.22.2.20040527223152.01f32510@mail.audioslack.com>
 <Pine.HPX.4.33n.0405271511470.6236-100000@studcom.urz.uni-halle.de>
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

At 11:14 PM 27/05/2004, Clemens Ladisch wrote:
>Luke Yelavich wrote:
> > below is the information I get when attempting to use this soundcard under
> > a 2.6.6 kernel with alsa drivers 1.0.5rc1 and hotplug.
> >
> > dmes:
> > usbaudio: device 3 audiocontrol interface 0 has 1 input and 1 output 
> AudioStreaming interfaces
>
>This is the OSS driver (audio).  Put the line
>
>audio
>
>into the file /etc/hotplug/blacklist to prevent it from loading (or
>deactivate it in the kernel config).

Clemens
This made no difference. I completely disabled hotplug and loaded the 
modules manually. First the usb controller module, and then the 
snd-usb-audio module. The output of dmesg is below

usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000d800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000d400
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000d000
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using address 2
usb 1-2: device not accepting address 2, error -71
usb 1-2: new full speed USB device using address 3
usb 1-2: device not accepting address 3, error -71
usbcore: registered new driver snd-usb-audio
--
Luke Yelavich
http://www.audioslack.com
luke@audioslack.com




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

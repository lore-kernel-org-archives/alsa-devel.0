From: Luke Yelavich <luke@audioslack.com>
Subject: Re: MAYA44 USB audio device doesn't work with  
  1.0.4.
Date: Sat, 29 May 2004 09:20:20 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <6.0.0.22.2.20040529091943.01f35658@mail.audioslack.com>
References: <6.0.0.22.2.20040528082652.01f45930@mail.audioslack.com>
 <Pine.HPX.4.33n.0405281740090.24462-100000@studcom.urz.uni-halle.de> <Pine.HPX.4.33n.0405281740090.24462-100000@studcom.urz.uni-
 halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405281740090.24462-100000@studcom.urz.uni-
 halle.de>
References: <6.0.0.22.2.20040528082652.01f45930@mail.audioslack.com>
 <Pine.HPX.4.33n.0405281740090.24462-100000@studcom.urz.uni-halle.de>
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

At 01:43 AM 29/05/2004, Clemens Ladisch wrote:
>No other message?  There should be at least an error message when the
>driver fails to initialize.  Please try to compile the kernel with
>ALSA's "Debug detection" enabled, or --with-debug=detect when
>configuring the package.

Ok, here dmesg, with debug=detect.

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
ALSA /mnt/software/linux/alsa/alsa-driver-1.0.5rc1/usb/usbaudio.c:2569: 
2:1:1: add audio endpoint 0x1
ALSA /mnt/software/linux/alsa/alsa-driver-1.0.5rc1/usb/usbaudio.c:2569: 
2:2:1: add audio endpoint 0x82
ALSA 
/mnt/software/linux/alsa/alsa-driver-1.0.5rc1/alsa-kernel/usb/usbmixer.c:866: 
[4] FU [Speaker Playback Switch] ch = 1, val = 0/1/1
ALSA 
/mnt/software/linux/alsa/alsa-driver-1.0.5rc1/alsa-kernel/usb/usbmixer.c:866: 
[4] FU [Speaker Playback Volume] ch = 2, val = 0/255/1
ALSA 
/mnt/software/linux/alsa/alsa-driver-1.0.5rc1/alsa-kernel/usb/usbmixer.c:866: 
[2] FU [Speaker Playback Switch] ch = 1, val = 0/1/1
ALSA 
/mnt/software/linux/alsa/alsa-driver-1.0.5rc1/alsa-kernel/usb/usbmixer.c:866: 
[2] FU [Speaker Playback Volume] ch = 2, val = 0/255/1
ALSA 
/mnt/software/linux/alsa/alsa-driver-1.0.5rc1/alsa-kernel/usb/usbmixer.c:866: 
[7] FU [Speaker Playback Switch] ch = 1, val = 0/1/1
ALSA 
/mnt/software/linux/alsa/alsa-driver-1.0.5rc1/alsa-kernel/usb/usbmixer.c:866: 
[7] FU [Speaker Playback Volume] ch = 2, val = 0/255/1
snd-usb-audio: probe of 1-2:1.0 failed with error -5
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

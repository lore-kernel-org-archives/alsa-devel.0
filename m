From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB midi support for KAOSS pad
Date: Mon, 24 May 2010 22:53:19 +0200
Message-ID: <20100524205319.GP30801@buzzloop.caiaq.de>
References: <AANLkTimUYbWSqsahW9m8AbIjZuT-yVvnkGpnfCrLyi8u@mail.gmail.com>
	<20100524153324.GL30801@buzzloop.caiaq.de>
	<AANLkTil4vczJ2ymOEAUCRQBfZroxxtRpWpC6Wl3TgcUq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8371310383A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 22:53:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTil4vczJ2ymOEAUCRQBfZroxxtRpWpC6Wl3TgcUq@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pedro Ferreira <ilzogoiby@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 24, 2010 at 09:08:52PM +0200, Pedro Ferreira wrote:
> [  518.740319] ehci_hcd 0000:00:1d.0: port 1 remote wakeup
> [  518.740356] usb usb2: usb resume
> [  518.740362] ehci_hcd 0000:00:1d.0: resume root hub
> [  518.770443] hub 2-0:1.0: hub_resume
> [  518.770566] ehci_hcd 0000:00:1d.0: GetStatus port 1 status 001005
> POWER sig=se0 PE CONNECT
> [  518.770573] hub 2-0:1.0: port 1: status 0503 change 0004
> [  518.770654] hub 2-0:1.0: state 7 ports 3 chg 0002 evt 0000
> [  518.770668] ehci_hcd 0000:00:1d.0: GetStatus port 1 status 001005 POWER sig=se0 PE CONNECT
> [  518.783066] usb 2-1: usb wakeup-resume
> [  518.783079] usb 2-1: finish resume
> [  518.783360] hub 2-1:1.0: hub_resume
> [  518.783875] hub 2-1:1.0: port 4: status 0101 change 0001
> [  518.886614] ehci_hcd 0000:00:1d.0: reused qh f2b276c0 schedule
> [  518.886620] usb 2-1: link qh256-0001/f2b276c0 start 2 [1/0 us]
> [  518.886631] hub 2-0:1.0: resume on port 1, status 0
> [  518.886636] hub 2-0:1.0: port 1, status 0503, change 0004, 480 Mb/s
> [  518.886642] hub 2-1:1.0: state 7 ports 8 chg 0010 evt 0000
> [  518.886870] hub 2-1:1.0: port 4, status 0101, change 0000, 12 Mb/s
> [  518.958563] usb 2-1.4: new full speed USB device using ehci_hcd and address 9
> [  519.049620] usb 2-1.4: ep0 maxpacket = 8
> [  519.051086] usb 2-1.4: skipped 5 descriptors after interface
> [  519.051092] usb 2-1.4: skipped 1 descriptor after endpoint
> [  519.051096] usb 2-1.4: skipped 1 descriptor after endpoint
> [  519.051342] usb 2-1.4: default language 0x0409
> [  519.051831] usb 2-1.4: udev 9, busnum 2, minor = 136
> [  519.051836] usb 2-1.4: New USB device found, idVendor=0944, idProduct=0020
> [  519.051841] usb 2-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [  519.051845] usb 2-1.4: Product: KP3
> [  519.051848] usb 2-1.4: Manufacturer: KORG INC.
> [  519.051986] usb 2-1.4: usb_probe_device
> [  519.051991] usb 2-1.4: configuration #1 chosen from 1 choice
> [  519.052155] usb 2-1.4: adding 2-1.4:1.0 (config #1, interface 0)
> [  519.052233] snd-usb-audio 2-1.4:1.0: usb_probe_interface
> [  519.052243] snd-usb-audio 2-1.4:1.0: usb_probe_interface - got id

The audio features of this device are enabled at this point, at it seems
the driver doesn't seem to complain.

> [  519.053360] usb 2-1.4: adding 2-1.4:1.1 (config #1, interface 1)
> [  519.053434] usb-storage 2-1.4:1.1: usb_probe_interface
> [  519.053447] usb-storage 2-1.4:1.1: usb_probe_interface - got id
> [  519.053644] scsi13 : SCSI emulation for USB Mass Storage devices
> [  519.053788] usb-storage: device found at 9
> [  519.053793] usb-storage: waiting for device to settle before scanning
> [  524.039157] usb-storage: device scan complete
> [  524.040207] scsi 13:0:0:0: Direct-Access     GENERIC  KORG KP3 R/W
>    0010 PQ: 0 ANSI: 2
> [  524.042624] sd 13:0:0:0: Attached scsi generic sg2 type 0
> [  524.048735] sd 13:0:0:0: [sdb] Attached SCSI removable disk
> [  526.268550] snd-usb-audio 2-1.4:1.0: forced unbind

And here, the device is disconnected from USB, but I doubt that is
related to the driver stack. The only thing I can currently think of is
that the device draws too much power at this point, and a voltage
brown-out causes the device to reset. Can you try a powered hub, or is
this device powered by an external supply anyway? Did you successfully
use it on the _same_ hardware under Windows?

Daniel

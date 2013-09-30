From: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: Re: snd-usb-usx2y (Tascam US-122) sequence errors
Date: Mon, 30 Sep 2013 12:09:39 +0100
Message-ID: <2157722.DYiUDh07P6@arial>
References: <1879797.EMyhs7R6HO@arial>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plockton.cent.gla.ac.uk (plockton.cent.gla.ac.uk
 [130.209.16.75])
 by alsa0.perex.cz (Postfix) with ESMTP id DA5912619F4
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 13:14:13 +0200 (CEST)
Received: from cas05.campus.gla.ac.uk ([130.209.14.38])
 by plockton.cent.gla.ac.uk with esmtp (Exim 4.72)
 (envelope-from <Nicholas.Bailey@glasgow.ac.uk>) id 1VQbQb-0007UY-JV
 for alsa-devel@alsa-project.org; Mon, 30 Sep 2013 12:14:13 +0100
In-Reply-To: <1879797.EMyhs7R6HO@arial>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I found this in Linux Audio Users:

	http://linuxaudio.org/mailarchive/lau/2013/5/20/200177

which would indicate that the issue has been current since May, and possibly 
impacts upon many different sound cards.

Does this still persist with kernel 3.10? My symptoms certainly agree exactly 
with this. Using alas-tools 1.0.27 with kernel 3.10-3.

Nick/.




On Saturday 28 September 2013 15:30:04 Dr Nicholas J Bailey wrote:
> I'm on debian jessie,
> 
> Linux arial 3.10-3-686-pae #1 SMP Debian 3.10.11-1 (2013-09-10) i686
> GNU/Linux
> 
> with a Tascam us-122 that has recently stopped working.
> 
> When I try to capture with anything, there is a few hundred ms of audio then
> the capture process stalls and the following dmesg appears:
> 
> [  462.596296] Sequence Error!(hcd_frame=0 ep=8in;wait=1024,frame=0).
> [  462.596296] Most probably some urb of usb-frame 1024 is still missing.
> [  462.596296] Cause could be too long delays in usb-hcd interrupt handling.
> [  477.959230] Sequence Error!(hcd_frame=0 ep=8in;wait=1024,frame=0). [ 
> 477.959230] Most probably some urb of usb-frame 1024 is still missing. [ 
> 477.959230] Cause could be too long delays in usb-hcd interrupt handling.
> 
> Before this kernel, the box worked OK. The only think that leads me to
> believe it might be my fault is that for a very long time, I've had to plug
> the box in:
> 
> [  445.529271] usb 2-1.6: new full-speed USB device number 5 using ehci-pci
> [  445.622076] usb 2-1.6: New USB device found, idVendor=1604,
> idProduct=8006 [  445.622086] usb 2-1.6: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> 
> then unplug it and plug it in again:
> 
> [  445.972743] usb 2-1.6: USB disconnect, device number 5
> [  447.621519] usb 2-1.6: new full-speed USB device number 6 using ehci-pci
> [  447.714462] usb 2-1.6: New USB device found, idVendor=1604,
> idProduct=8007 [  447.714471] usb 2-1.6: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> [  447.834852] usbcore: registered new interface driver snd-usb-usx2y
> [  455.194314] usb 2-1.6: USB disconnect, device number 6
> [  457.487433] usb 2-1.6: new full-speed USB device number 7 using ehci-pci
> [  457.579960] usb 2-1.6: New USB device found, idVendor=1604,
> idProduct=8006 [  457.579969] usb 2-1.6: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> 
> to get the firmware to load
> 
> [  457.888884] usb 2-1.6: USB disconnect, device number 7
> [  459.379782] usb 2-1.6: new full-speed USB device number 8 using ehci-pci
> [  459.472516] usb 2-1.6: New USB device found, idVendor=1604,
> idProduct=8007 [  459.472526] usb 2-1.6: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> 
> (green USB light comes on here).
> 

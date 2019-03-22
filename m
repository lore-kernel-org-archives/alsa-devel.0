From: Guido Trentalancia <guido@trentalancia.com>
Subject: Re: Hercules P32 DJ: severe sound distortion during
 MIDI transfers
Date: Fri, 22 Mar 2019 17:28:15 +0100 (CET)
Message-ID: <2092511757.63691.1553272095277@pim.register.it>
References: <1553114844.12865.6.camel@trentalancia.com>
 <1335514032.30698.1553207267014@pim.register.it>
 <s5hr2azp9t3.wl-tiwai@suse.de>
 <D5E663E4-9118-4CA3-8ADE-5F97202D9404@trentalancia.com>
 <s5himwbb5h4.wl-tiwai@suse.de>
 <53EC51B6-618E-47B4-95E8-B24BECEEBC98@trentalancia.com>
 <s5hef6zb4k6.wl-tiwai@suse.de> <1553262288.26146.4.camel@trentalancia.com>
 <30e9cb6f-2bd5-292e-beb4-e49aad2db747@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmailsmtp.register.it (webmailsmtp14.register.it
 [81.88.56.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 718AFF8076F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 17:28:15 +0100 (CET)
In-Reply-To: <30e9cb6f-2bd5-292e-beb4-e49aad2db747@ladisch.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

# cat /sys/bus/usb/devices/usb[12]/version 
 2.00
 2.00

# cat /sys/bus/usb/devices/usb[12]/product 
EHCI Host Controller
EHCI Host Controller

# cat /sys/bus/usb/devices/usb[12]/manufacturer 
Linux 5.0.2 ehci_hcd
Linux 5.0.2 ehci_hcd

# cat /sys/bus/usb/devices/usb[12]/speed 
480
480

What other information do you need ?

Do you suggest some particular USB module configuration to try ?

Regards,

Guido

> Il 22 marzo 2019 alle 15.06 Clemens Ladisch <clemens@ladisch.de> ha scritto:
> 
> 
> Guido Trentalancia wrote:
> > Also, the hardware is the same: Hercules P32 DJ (with exactly the same
> > firmware version 1.46 which is the latest).
> 
> Are the USB controllers the same (2.0/3.x, OHCI/UHCI/EHCI/xHCI)?
> 
> You wrote that "amidi -p hw:2,0,0 -d" causes the problem.  As long as no
> MIDI messages are actually received, the kernel or driver cannot affect
> what happens on the USB bus; the polling is done entirely by the host
> controller.
> 
> 
> Regards,
> Clemens

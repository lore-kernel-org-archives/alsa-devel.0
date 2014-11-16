From: humbert.olivier.1@free.fr
Subject: Re: AKAI EIE PRO
Date: Sun, 16 Nov 2014 17:09:02 +0100 (CET)
Message-ID: <1521662222.376637110.1416154142216.JavaMail.root@zimbra61-e11.priv.proxad.net>
References: <540C43E0.5020704@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E5382608D3
 for <Alsa-devel@alsa-project.org>; Sun, 16 Nov 2014 17:09:03 +0100 (CET)
In-Reply-To: <540C43E0.5020704@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: michal.rydlo@gmail.com, Alsa-devel@alsa-project.org, Martin Svensson <martin.svensson@ztealmax.se>
List-Id: alsa-devel@alsa-project.org

On 09/07/2014 01:30 PM, humbert.olivier.1@free.fr wrote:
>> if that can help, we had an user on http://www.linuxmao.org with an EIE PRO.
>> Here you have his lsusb -v :
>> 
>> Bus 001 Device 006: ID 09e8:0010 AKAI  Professional M.I. Corp. 
>> Couldn't open device, some information will be missing
>> Device Descriptor:
>>   bLength                18
>>   bDescriptorType         1
>>   bcdUSB               2.00
>>   bDeviceClass          255 Vendor Specific Class
>>   bDeviceSubClass       255 Vendor Specific Subclass
>>   bDeviceProtocol       255 Vendor Specific Protocol
>
> According to the tech specs, this should be a USB hub, but it isn't. Or
> is this just one of the sub-devices? What does 'lsusb -t' say, and does
> Linux see something like a mouse or mass storage device when connected
> to one of the hub ports?

[...zip...]

Hi Daniel and all,

An linuxmao.org user gave answers to these questions today. Here you go:

maxime@Ubuntu-MAO:~$ lsusb -t
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 480M
    |__ Port 2: Dev 4, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 4: Dev 5, If 0, Class=Vendor Specific Class, Driver=, 480M
        |__ Port 4: Dev 5, If 1, Class=Vendor Specific Class, Driver=, 480M
    |__ Port 3: Dev 3, If 0, Class=Wireless, Driver=btusb, 12M
    |__ Port 3: Dev 3, If 1, Class=Wireless, Driver=btusb, 12M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/6p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/6p, 480M
        |__ Port 2: Dev 6, If 0, Class=Human Interface Device, Driver=usbhid, 12M
        |__ Port 2: Dev 6, If 1, Class=Human Interface Device, Driver=usbhid, 12M
        |__ Port 3: Dev 5, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 5, If 1, Class=Video, Driver=uvcvideo, 480M


maxime@Ubuntu-MAO:~$ dmesg | tail
[12078.955863] usb 3-2: New USB device found, idVendor=0409, idProduct=005a
[12078.955870] usb 3-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[12078.956401] hub 3-2:1.0: USB hub found
[12078.956452] hub 3-2:1.0: 4 ports detected
[12079.243626] usb 3-2.4: new high-speed USB device number 7 using xhci_hcd
[12079.348372] usb 3-2.4: New USB device found, idVendor=09e8, idProduct=0010
[12079.348379] usb 3-2.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[12079.348383] usb 3-2.4: Product: EIE pro
[12079.348386] usb 3-2.4: Manufacturer: Akai Professional, LP
[12079.348389] usb 3-2.4: SerialNumber: no serial number

I'll be asking him to try connecting a mouse to one of the hub port and to get a dmesg from there.

Hope that can help in any way. If you would need some more information, please let me know.

Olivier

source : http://www.linuxmao.org/tiki-view_forum_thread.php?forumId=2&comments_parentId=56440#threadId58184

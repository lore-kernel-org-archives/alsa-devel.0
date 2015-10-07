From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Boss GT-001
Date: Wed, 07 Oct 2015 10:41:52 +0100
Message-ID: <3067439.4bLxTPZOO7@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop> <4761108.z7lHdDqPTH@kamdesktop>
 <alpine.DEB.2.02.1510071000020.17839@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 71262265A3E
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 11:41:54 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so204585565wic.0
 for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2015 02:41:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1510071000020.17839@lnxricardw1.se.axis.com>
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
Cc: 'Clemens Ladisch' <clemens@ladisch.de>, Ricard Wanderlof <ricard.wanderlof@axis.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 07 Oct 2015 10:09:14 Ricard Wanderlof wrote:
> On Tue, 6 Oct 2015, Keith A. Milner wrote:
> > OK, so it seems that this hardware is substantially the same as the GT-100
> > which has previously (and recently) been raised as a problem on ALSA.

> > I'm going to attempt to capture some USB data using this device in
> > Windows. If I do this, is there an accepted method for uploading the
> > capture so it can be posted here?
> > 
> > At this point, I'm not 100% sure what the capture format is going to be...

<Various snips>

> I learned though that although Wireshark is happy reading the .pcap files
> produced by USBPCap, the resulting dumps can look quite different from
> what Wireshark sniffs in Linux, which initially took me aback. At least
> when it comes to USBPcap I think the reason is that the program actually
> sniffs the data halfway up (if not at the top of) the Windows protocol
> stack, meaning that there's data in the dump that does not actually occur
> on the wire. I'm not sure at what level usbmon sniffs, but it looks closer
> to what I'd expect on the physical cable.
> 

Thanks Richard.

The data I'm getting from Wireshark via USBMon seems OK from my initial 
viewing. Incidentally, Wireshark can sniff directly from usbmon interfaces and 
exposes them as capture interfaces (at least with the version I have).

Here's an example of what I'm getting (exported as CSV):
"No.","Time","Source","Destination","Protocol","Length","Info","Leftover 
Capture Data","Comment"
"1","0.000000000","host","7.0","USB","64","GET DESCRIPTOR Request 
DEVICE","","This was from within Linux before I connected the USB device to 
the Windows VM guest"
"2","0.000203000","7.0","host","USB","82","GET DESCRIPTOR Response 
DEVICE","","This was from within Linux before I connected the USB device to 
the Windows VM guest"
"3","6.343942000","host","7.0","USB","64","SET INTERFACE Request","",""
"4","6.344069000","7.0","host","USB","64","SET INTERFACE Response","",""
"5","6.545252000","host","0.0","USB","64","SET ADDRESS Request","",""
"6","6.564886000","host","7.0","USB","64","GET DESCRIPTOR Request 
DEVICE","",""
"7","6.565099000","7.0","host","USB","82","GET DESCRIPTOR Response 
DEVICE","",""
"8","6.565134000","host","7.0","USB","64","GET DESCRIPTOR Request 
CONFIGURATION","",""
"9","6.565566000","7.0","host","USB","240","GET DESCRIPTOR Response 
CONFIGURATION","",""

The isochronous data appears as follows:

"54","24.767751000","host","7.14","USB","192","URB_ISOCHRONOUS 
in","eeffffff000000007000000000000000eeffffff70000000...",""

Wireshark also appears to decode them quite nicely.  I've pasted one of the 
GET DESCRIPTOR responses below.

Now I need to try and work out what it all means...

Cheers,

Keith

GET DESCRIPTOR response decode:

No.     Time           Source                Destination           Length Info 
Leftover Capture Data Comment
      9 6.565566000    7.0                   host                  240    GET 
DESCRIPTOR Response CONFIGURATION                                                 

Frame 9: 240 bytes on wire (1920 bits), 240 bytes captured (1920 bits) on 
interface 0
    Interface id: 0 (usbmon3)
    Encapsulation type: USB packets with Linux header and padding (115)
    Arrival Time: Oct  6, 2015 22:11:10.987080000 BST
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1444165870.987080000 seconds
    [Time delta from previous captured frame: 0.000432000 seconds]
    [Time delta from previous displayed frame: 0.000432000 seconds]
    [Time since reference or first frame: 6.565566000 seconds]
    Frame Number: 9
    Frame Length: 240 bytes (1920 bits)
    Capture Length: 240 bytes (1920 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: usb]
USB URB
    URB id: 0xffff880289c33740
    URB type: URB_COMPLETE ('C')
    URB transfer type: URB_CONTROL (0x02)
    Endpoint: 0x80, Direction: IN
        1... .... = Direction: IN (1)
        .000 0000 = Endpoint value: 0
    Device: 7
    URB bus id: 3
    Device setup request: not relevant ('-')
    Data: present (0)
    URB sec: 1444165870
    URB usec: 987080
    URB status: Success (0)
    URB length [bytes]: 176
    Data length [bytes]: 176
    [Request in: 8]
    [Time from request: 0.000432000 seconds]
    Unused Setup Header
    Interval: 0
    Start frame: 0
    Copy of Transfer Flags: 0x00000200
    Number of ISO descriptors: 0
CONFIGURATION DESCRIPTOR
    bLength: 9
    bDescriptorType: 0x02 (CONFIGURATION)
    wTotalLength: 176
    bNumInterfaces: 4
    bConfigurationValue: 1
    iConfiguration: 0
    Configuration bmAttributes: 0xc0  SELF-POWERED  NO REMOTE-WAKEUP
        1... .... = Must be 1: Must be 1 for USB 1.1 and higher
        .1.. .... = Self-Powered: This device is SELF-POWERED
        ..0. .... = Remote Wakeup: This device does NOT support remote wakeup
    bMaxPower: 0  (0mA)
INTERFACE DESCRIPTOR (0.0): class Vendor Specific
    bLength: 9
    bDescriptorType: 0x04 (INTERFACE)
    bInterfaceNumber: 0
    bAlternateSetting: 0
    bNumEndpoints: 0
    bInterfaceClass: Vendor Specific (0xff)
    bInterfaceSubClass: 0xff
    bInterfaceProtocol: 0x00
    iInterface: 0
INTERFACE DESCRIPTOR (1.0): class Vendor Specific
    bLength: 9
    bDescriptorType: 0x04 (INTERFACE)
    bInterfaceNumber: 1
    bAlternateSetting: 0
    bNumEndpoints: 0
    bInterfaceClass: Vendor Specific (0xff)
    bInterfaceSubClass: 0x02
    bInterfaceProtocol: 0x02
    iInterface: 0
UNKNOWN DESCRIPTOR
    bLength: 6
    bDescriptorType: 0x24 (unknown)
INTERFACE DESCRIPTOR (1.1): class Vendor Specific
    bLength: 9
    bDescriptorType: 0x04 (INTERFACE)
    bInterfaceNumber: 1
    bAlternateSetting: 1
    bNumEndpoints: 1
    bInterfaceClass: Vendor Specific (0xff)
    bInterfaceSubClass: 0x02
    bInterfaceProtocol: 0x02
    iInterface: 0
UNKNOWN DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x24 (unknown)
UNKNOWN DESCRIPTOR
    bLength: 11
    bDescriptorType: 0x24 (unknown)
ENDPOINT DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x05 (ENDPOINT)
    bEndpointAddress: 0x0d  OUT  Endpoint:13
        0... .... = Direction: OUT Endpoint
        .... 1101 = Endpoint Number: 0x0d
    bmAttributes: 0x05
        .... ..01 = Transfertype: Isochronous-Transfer (0x01)
        .... 01.. = Synchronisationtype: Asynchronous (0x01)
        ..00 .... = Behaviourtype: Data-Endpoint (0x00)
    wMaxPacketSize: 112
        ...0 0... .... .... = Transactions per microframe: 1 (0)
        .... ..00 0111 0000 = Maximum Packet Size: 112
    bInterval: 1
UNKNOWN DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x25 (unknown)
INTERFACE DESCRIPTOR (2.0): class Vendor Specific
    bLength: 9
    bDescriptorType: 0x04 (INTERFACE)
    bInterfaceNumber: 2
    bAlternateSetting: 0
    bNumEndpoints: 0
    bInterfaceClass: Vendor Specific (0xff)
    bInterfaceSubClass: 0x02
    bInterfaceProtocol: 0x01
    iInterface: 0
INTERFACE DESCRIPTOR (2.1): class Vendor Specific
    bLength: 9
    bDescriptorType: 0x04 (INTERFACE)
    bInterfaceNumber: 2
    bAlternateSetting: 1
    bNumEndpoints: 1
    bInterfaceClass: Vendor Specific (0xff)
    bInterfaceSubClass: 0x02
    bInterfaceProtocol: 0x01
    iInterface: 0
UNKNOWN DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x24 (unknown)
UNKNOWN DESCRIPTOR
    bLength: 11
    bDescriptorType: 0x24 (unknown)
ENDPOINT DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x05 (ENDPOINT)
    bEndpointAddress: 0x8e  IN  Endpoint:14
        1... .... = Direction: IN Endpoint
        .... 1110 = Endpoint Number: 0x0e
    bmAttributes: 0x25
        .... ..01 = Transfertype: Isochronous-Transfer (0x01)
        .... 01.. = Synchronisationtype: Asynchronous (0x01)
        ..10 .... = Behaviourtype: Implicit Feedback-Data-Endpoint (0x02)
    wMaxPacketSize: 112
        ...0 0... .... .... = Transactions per microframe: 1 (0)
        .... ..00 0111 0000 = Maximum Packet Size: 112
    bInterval: 1
UNKNOWN DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x25 (unknown)
INTERFACE DESCRIPTOR (3.0): class Vendor Specific
    bLength: 9
    bDescriptorType: 0x04 (INTERFACE)
    bInterfaceNumber: 3
    bAlternateSetting: 0
    bNumEndpoints: 2
    bInterfaceClass: Vendor Specific (0xff)
    bInterfaceSubClass: 0x03
    bInterfaceProtocol: 0x00
    iInterface: 0
UNKNOWN DESCRIPTOR
    bLength: 6
    bDescriptorType: 0x24 (unknown)
ENDPOINT DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x05 (ENDPOINT)
    bEndpointAddress: 0x03  OUT  Endpoint:3
        0... .... = Direction: OUT Endpoint
        .... 0011 = Endpoint Number: 0x03
    bmAttributes: 0x02
        .... ..10 = Transfertype: Bulk-Transfer (0x02)
        .... 00.. = Synchronisationtype: No Sync (0x00)
        ..00 .... = Behaviourtype: Data-Endpoint (0x00)
    wMaxPacketSize: 512
        .... ..10 0000 0000 = Maximum Packet Size: 512
    bInterval: 1
ENDPOINT DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x05 (ENDPOINT)
    bEndpointAddress: 0x84  IN  Endpoint:4
        1... .... = Direction: IN Endpoint
        .... 0100 = Endpoint Number: 0x04
    bmAttributes: 0x02
        .... ..10 = Transfertype: Bulk-Transfer (0x02)
        .... 00.. = Synchronisationtype: No Sync (0x00)
        ..00 .... = Behaviourtype: Data-Endpoint (0x00)
    wMaxPacketSize: 512
        .... ..10 0000 0000 = Maximum Packet Size: 512
    bInterval: 0
INTERFACE DESCRIPTOR (3.1): class Vendor Specific
    bLength: 9
    bDescriptorType: 0x04 (INTERFACE)
    bInterfaceNumber: 3
    bAlternateSetting: 1
    bNumEndpoints: 2
    bInterfaceClass: Vendor Specific (0xff)
    bInterfaceSubClass: 0x03
    bInterfaceProtocol: 0x00
    iInterface: 0
ENDPOINT DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x05 (ENDPOINT)
    bEndpointAddress: 0x03  OUT  Endpoint:3
        0... .... = Direction: OUT Endpoint
        .... 0011 = Endpoint Number: 0x03
    bmAttributes: 0x03
        .... ..11 = Transfertype: Interrupt-Transfer (0x03)
        .... 00.. = Synchronisationtype: No Sync (0x00)
        ..00 .... = Behaviourtype: Data-Endpoint (0x00)
    wMaxPacketSize: 512
        ...0 0... .... .... = Transactions per microframe: 1 (0)
        .... ..10 0000 0000 = Maximum Packet Size: 512
    bInterval: 1
ENDPOINT DESCRIPTOR
    bLength: 7
    bDescriptorType: 0x05 (ENDPOINT)
    bEndpointAddress: 0x85  IN  Endpoint:5
        1... .... = Direction: IN Endpoint
        .... 0101 = Endpoint Number: 0x05
    bmAttributes: 0x03
        .... ..11 = Transfertype: Interrupt-Transfer (0x03)
        .... 00.. = Synchronisationtype: No Sync (0x00)
        ..00 .... = Behaviourtype: Data-Endpoint (0x00)
    wMaxPacketSize: 512
        ...0 0... .... .... = Transactions per microframe: 1 (0)
        .... ..10 0000 0000 = Maximum Packet Size: 512
    bInterval: 1

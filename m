From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Attempting to understand odd snd-usb-audio code
	and behavior
Date: Mon, 22 Jan 2018 18:14:32 +0000
Message-ID: <1542685.UGgiXn2nf5@kamdesktop>
References: <2006820.TBXnYHJvYE@kamdesktop> <4997219.KIItTR1t2S@kamdesktop>
 <2180450.qzCeTlsBey@kamdesktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1767068.oYUBFuBr9P"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com
 [209.85.128.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C586266E07
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 19:14:36 +0100 (CET)
Received: by mail-wr0-f169.google.com with SMTP id f11so9696751wre.4
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 10:14:36 -0800 (PST)
Received: from kamdesktop.localnet
 (2.b.7.c.1.4.7.d.9.e.d.f.7.0.9.e.f.a.9.2.a.0.e.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:be0a:29af:e907:fde9:d741:c7b2])
 by smtp.gmail.com with ESMTPSA id b136sm11676976wme.34.2018.01.22.10.14.33
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jan 2018 10:14:33 -0800 (PST)
In-Reply-To: <2180450.qzCeTlsBey@kamdesktop>
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

This is a multi-part message in MIME format.

--nextPart1767068.oYUBFuBr9P
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 22 Jan 2018 15:40:03 Keith A. Milner wrote:
> On Monday 22 Jan 2018 14:06:08 Keith A. Milner wrote:
> > On Wednesday 23 Aug 2017 14:52:43 Clemens Ladisch wrote:
> > > Keith A. Milner wrote:

> My next course of action is to try to work out why the sync endpoint doesn't
> seem to be opened.
>

Right, so I see it IS being opened, and this results in URB_ISOCHRONOUS in 
URBs being sent, and the device responds (packet dissection in attached files 
for alsa and windows). However, the sync packets received are empty and are, 
thus, ignored by snd_usb_handle_sync_urb (in endpoint.c).

There are a couple of minor differences between the URBs in the Windows case 
and the Linux case:

1. The Windows URBs are larger: 448 bytes with a data length of 384 bytes 
compared to 448 bytes with a data length of 128 bytes for Alsa

I don't know if this is significant or is the impact of Alsa chosing a 
different format/framerate.

2. The bInterfaceClass in the Windows case is set to Vendor Specific (0xff) 
but is Unknown (0xffff) in the Alsa case. I can't see where this is being set. 
The host interfaces seem to have the correct bInterfaceClass

Other than that, the two appear to be the same. The ISO descriptors in the 
Windows case also appear to be empty:

0000   ee ff ff ff 00 00 00 00 38 00 00 00 00 00 00 00  ........8.......
0010   ee ff ff ff 38 00 00 00 38 00 00 00 00 00 00 00  ....8...8.......
0020   ee ff ff ff 70 00 00 00 38 00 00 00 00 00 00 00  ....p...8.......
0030   ee ff ff ff a8 00 00 00 38 00 00 00 00 00 00 00  ........8.......
0040   ee ff ff ff e0 00 00 00 38 00 00 00 00 00 00 00  ........8.......
0050   ee ff ff ff 18 01 00 00 38 00 00 00 00 00 00 00  ........8.......
0060   ee ff ff ff 50 01 00 00 38 00 00 00 00 00 00 00  ....P...8.......
0070   ee ff ff ff 88 01 00 00 38 00 00 00 00 00 00 00  ........8.......
0080   ee ff ff ff c0 01 00 00 38 00 00 00 00 00 00 00  ........8.......
0090   ee ff ff ff f8 01 00 00 38 00 00 00 00 00 00 00  ........8.......
00a0   ee ff ff ff 30 02 00 00 38 00 00 00 00 00 00 00  ....0...8.......
00b0   ee ff ff ff 68 02 00 00 38 00 00 00 00 00 00 00  ....h...8.......
00c0   ee ff ff ff a0 02 00 00 38 00 00 00 00 00 00 00  ........8.......
00d0   ee ff ff ff d8 02 00 00 38 00 00 00 00 00 00 00  ........8.......
00e0   ee ff ff ff 10 03 00 00 38 00 00 00 00 00 00 00  ........8.......
00f0   ee ff ff ff 48 03 00 00 38 00 00 00 00 00 00 00  ....H...8.......
0100   ee ff ff ff 80 03 00 00 38 00 00 00 00 00 00 00  ........8.......
0110   ee ff ff ff b8 03 00 00 38 00 00 00 00 00 00 00  ........8.......
0120   ee ff ff ff f0 03 00 00 38 00 00 00 00 00 00 00  ........8.......
0130   ee ff ff ff 28 04 00 00 38 00 00 00 00 00 00 00  ....(...8.......
0140   ee ff ff ff 60 04 00 00 38 00 00 00 00 00 00 00  ....`...8.......
0150   ee ff ff ff 98 04 00 00 38 00 00 00 00 00 00 00  ........8.......
0160   ee ff ff ff d0 04 00 00 38 00 00 00 00 00 00 00  ........8.......
0170   ee ff ff ff 08 05 00 00 38 00 00 00 00 00 00 00                                                  
........8.......


Cheers,

Keith



--nextPart1767068.oYUBFuBr9P
Content-Disposition: attachment; filename="URB_ISOCHRONOUS_alsa.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="URB_ISOCHRONOUS_alsa.txt"

No.     Time                          Source                Destination           Protocol Length Info                                                            Comment
  68817 2018-01-22 17:03:24.530158000 host                  13.14                 USB      192    URB_ISOCHRONOUS in                                              

Frame 68817: 192 bytes on wire (1536 bits), 192 bytes captured (1536 bits) on interface 0
    Interface id: 0 (usbmon1)
    Encapsulation type: USB packets with Linux header and padding (115)
    Arrival Time: Jan 22, 2018 17:03:24.530158000 GMT
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1516640604.530158000 seconds
    [Time delta from previous captured frame: 0.000335000 seconds]
    [Time delta from previous displayed frame: 0.003405000 seconds]
    [Time since reference or first frame: 10.408990000 seconds]
    Frame Number: 68817
    Frame Length: 192 bytes (1536 bits)
    Capture Length: 192 bytes (1536 bits)
    [Frame is marked: True]
    [Frame is ignored: False]
    [Protocols in frame: usb]
USB URB
    URB id: 0xffff8801640a6200
    URB type: URB_SUBMIT ('S')
    URB transfer type: URB_ISOCHRONOUS (0x00)
    Endpoint: 0x8e, Direction: IN
        1... .... = Direction: IN (1)
        .000 1110 = Endpoint value: 14
    Device: 13
    URB bus id: 1
    Device setup request: not relevant ('-')
    Data: not present ('<')
    URB sec: 1516640604
    URB usec: 530158
    URB status: Operation now in progress (-EINPROGRESS) (-115)
    URB length [bytes]: 448
    Data length [bytes]: 128
    [Response in: 68832]
    [bInterfaceClass: Unknown (0xffff)]
    ISO error count: 0
    Number of ISO descriptors: 8
    Interval: 1
    Start frame: 0
    Copy of Transfer Flags: 0x00000202
    Number of ISO descriptors: 8
Leftover Capture Data: eeffffff000000003800000000000000eeffffff38000000...

No.     Time                          Source                Destination           Protocol Length Info                                                            Comment
  68832 2018-01-22 17:03:24.532117000 13.14                 host                  USB      192    URB_ISOCHRONOUS in                                              

Frame 68832: 192 bytes on wire (1536 bits), 192 bytes captured (1536 bits) on interface 0
    Interface id: 0 (usbmon1)
    Encapsulation type: USB packets with Linux header and padding (115)
    Arrival Time: Jan 22, 2018 17:03:24.532117000 GMT
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1516640604.532117000 seconds
    [Time delta from previous captured frame: 0.000004000 seconds]
    [Time delta from previous displayed frame: 0.001959000 seconds]
    [Time since reference or first frame: 10.410949000 seconds]
    Frame Number: 68832
    Frame Length: 192 bytes (1536 bits)
    Capture Length: 192 bytes (1536 bits)
    [Frame is marked: True]
    [Frame is ignored: False]
    [Protocols in frame: usb]
USB URB
    URB id: 0xffff8801640a6200
    URB type: URB_COMPLETE ('C')
    URB transfer type: URB_ISOCHRONOUS (0x00)
    Endpoint: 0x8e, Direction: IN
        1... .... = Direction: IN (1)
        .000 1110 = Endpoint value: 14
    Device: 13
    URB bus id: 1
    Device setup request: not relevant ('-')
    Data: present (0)
    URB sec: 1516640604
    URB usec: 532117
    URB status: Success (0)
    URB length [bytes]: 0
    Data length [bytes]: 128
    [Request in: 68817]
    [Time from request: 0.001959000 seconds]
    [bInterfaceClass: Unknown (0xffff)]
    ISO error count: 0
    Number of ISO descriptors: 8
    Interval: 1
    Start frame: 3483
    Copy of Transfer Flags: 0x00000202
    Number of ISO descriptors: 8
Leftover Capture Data: 000000000000000000000000000000000000000038000000...

--nextPart1767068.oYUBFuBr9P
Content-Disposition: attachment; filename="URB_ISOCHRONOUS_w10.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="URB_ISOCHRONOUS_w10.txt"

No.     Time                          Source                Destination           Protocol Length Info                                                            Comment
     54 2018-01-20 15:49:26.823852000 host                  7.14                  USB      448    URB_ISOCHRONOUS in                                              

Frame 54: 448 bytes on wire (3584 bits), 448 bytes captured (3584 bits) on interface 0
    Interface id: 0 (usbmon1)
    Encapsulation type: USB packets with Linux header and padding (115)
    Arrival Time: Jan 20, 2018 15:49:26.823852000 GMT
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1516463366.823852000 seconds
    [Time delta from previous captured frame: 0.000358000 seconds]
    [Time delta from previous displayed frame: 0.000358000 seconds]
    [Time since reference or first frame: 29.405244000 seconds]
    Frame Number: 54
    Frame Length: 448 bytes (3584 bits)
    Capture Length: 448 bytes (3584 bits)
    [Frame is marked: True]
    [Frame is ignored: False]
    [Protocols in frame: usb]
USB URB
    URB id: 0xffff880352250400
    URB type: URB_SUBMIT ('S')
    URB transfer type: URB_ISOCHRONOUS (0x00)
    Endpoint: 0x8e, Direction: IN
        1... .... = Direction: IN (1)
        .000 1110 = Endpoint value: 14
    Device: 7
    URB bus id: 1
    Device setup request: not relevant ('-')
    Data: not present ('<')
    URB sec: 1516463366
    URB usec: 823852
    URB status: Operation now in progress (-EINPROGRESS) (-115)
    URB length [bytes]: 1344
    Data length [bytes]: 384
    [Response in: 58]
    [bInterfaceClass: Vendor Specific (0xff)]
    ISO error count: 0
    Number of ISO descriptors: 24
    Interval: 1
    Start frame: 0
    Copy of Transfer Flags: 0x00000202
    Number of ISO descriptors: 24
Leftover Capture Data: eeffffff000000003800000000000000eeffffff38000000...

No.     Time                          Source                Destination           Protocol Length Info                                                            Comment
     58 2018-01-20 15:49:26.827976000 7.14                  host                  USB      448    URB_ISOCHRONOUS in                                              

Frame 58: 448 bytes on wire (3584 bits), 448 bytes captured (3584 bits) on interface 0
    Interface id: 0 (usbmon1)
    Encapsulation type: USB packets with Linux header and padding (115)
    Arrival Time: Jan 20, 2018 15:49:26.827976000 GMT
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1516463366.827976000 seconds
    [Time delta from previous captured frame: 0.003959000 seconds]
    [Time delta from previous displayed frame: 0.003959000 seconds]
    [Time since reference or first frame: 29.409368000 seconds]
    Frame Number: 58
    Frame Length: 448 bytes (3584 bits)
    Capture Length: 448 bytes (3584 bits)
    [Frame is marked: True]
    [Frame is ignored: False]
    [Protocols in frame: usb]
USB URB
    URB id: 0xffff880352250400
    URB type: URB_COMPLETE ('C')
    URB transfer type: URB_ISOCHRONOUS (0x00)
    Endpoint: 0x8e, Direction: IN
        1... .... = Direction: IN (1)
        .000 1110 = Endpoint value: 14
    Device: 7
    URB bus id: 1
    Device setup request: not relevant ('-')
    Data: present (0)
    URB sec: 1516463366
    URB usec: 827976
    URB status: Success (0)
    URB length [bytes]: 0
    Data length [bytes]: 384
    [Request in: 54]
    [Time from request: 0.004124000 seconds]
    [bInterfaceClass: Vendor Specific (0xff)]
    ISO error count: 0
    Number of ISO descriptors: 24
    Interval: 1
    Start frame: 6773
    Copy of Transfer Flags: 0x00000202
    Number of ISO descriptors: 24
Leftover Capture Data: 000000000000000000000000000000000000000038000000...

--nextPart1767068.oYUBFuBr9P
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart1767068.oYUBFuBr9P--

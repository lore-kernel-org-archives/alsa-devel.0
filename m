From: Shareef Jalloq <shareef@jalloq.co.uk>
Subject: XMOS USB Audio Class 2.0 Reference Design
Date: Mon, 14 Dec 2009 18:51:41 +0000
Message-ID: <18c89c30912141051t3aafc060sf65ba65bb36a94e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 426931037E3
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 19:51:42 +0100 (CET)
Received: by ewy4 with SMTP id 4so1505383ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 10:51:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,

I'm starting a product development using the XMOS USB Audio Class 2.0
Ref Design (http://www.xmos.com/technology/prototype-boards/usbaudio2)
and I'd like to get some help in understanding what support there is,
or will be, for Audio Class 2.0 devices within Linux.

First of all some disclaimers.=A0 I'm new to the Linux kernel and
programming in general having come from a hardware background.=A0 I will
do my best not to spam the mailing list but please don't assume
something is too simple to explain to me.=A0 I'm going to use this
experience as a learning exercise.

I'm running Ubuntu 9.10 x64 : 2.6.31-16-generic.=A0 It is a fresh
install so most things are default.

I currently have the reference design hardware but am still waiting on
XMOS to provide the device firmware.=A0 Once I have the source I should
be able to answer any questions regarding desriptors in more detail.
Until then I have the previously mentioned Ubuntu system and an OS X
machine running 10.4.11.=A0 As far as I understand, 10.6.x is the only
OS that currently supports the Audio Class 2.0 and I'm hoping to have
access to a machine soon, but not yet.

When I connect the device I get zero output.=A0 If I run lsub -v it is
not recognised.=A0 If I check my syslog I get the following:

Dec 10 00:16:00 sjalloq-desktop kernel: [53352.087740] usb 2-1.2.3:
new high speed USB device using ehci_hcd and address 56
Dec 10 00:16:00 sjalloq-desktop kernel: [53352.107747] hub 2-1.2:1.0:
unable to enumerate USB device on port 3
Dec 10 00:16:04 sjalloq-desktop kernel: [53356.286145] hub 2-1.2:1.0:
Cannot enable port 3.=A0 Maybe the USB cable is bad?
Dec 10 00:16:07 sjalloq-desktop kernel: [53359.285099] hub 2-1.2:1.0:
Cannot enable port 3.=A0 Maybe the USB cable is bad?
Dec 10 00:16:10 sjalloq-desktop kernel: [53362.284088] hub 2-1.2:1.0:
Cannot enable port 3.=A0 Maybe the USB cable is bad?
Dec 10 00:16:13 sjalloq-desktop kernel: [53365.282591] hub 2-1.2:1.0:
Cannot enable port 3.=A0 Maybe the USB cable is bad?
Dec 10 00:16:13 sjalloq-desktop kernel: [53365.282884] hub 2-1.2:1.0:
unable to enumerate USB device on port 3

However, on my OS X machine, if I run USB Prober, I get the output
that follows the end of the email.

Is there anything else I can do that would be useful in debugging?

Thanks, Shareef.

__END__

OUTPUT FROM MAC OS X 10.4.11 USB PROBER:

High Speed device @ 3 (0xFD100000): ..............................
...............=A0=A0 Miscellaneous/Common Class device: "XMOS USB Audio 2.=
0"
=A0=A0=A0 Device Descriptor
=A0=A0=A0=A0=A0=A0=A0 Descriptor Version Number:=A0=A0 0x0200
=A0=A0=A0=A0=A0=A0=A0 Device Class:=A0=A0 239=A0=A0 (Miscellaneous)
=A0=A0=A0=A0=A0=A0=A0 Device Subclass:=A0=A0 2=A0=A0 (Common Class)
=A0=A0=A0=A0=A0=A0=A0 Device Protocol:=A0=A0 1=A0=A0 (Interface Association)
=A0=A0=A0=A0=A0=A0=A0 Device MaxPacketSize:=A0=A0 64
=A0=A0=A0=A0=A0=A0=A0 Device VendorID/ProductID:=A0=A0 0x20B1/0x0002=A0=A0 =
(unknown vendor)
=A0=A0=A0=A0=A0=A0=A0 Device Version Number:=A0=A0 0x0110
=A0=A0=A0=A0=A0=A0=A0 Number of Configurations:=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 Manufacturer String:=A0=A0 12 "XMOS "
=A0=A0=A0=A0=A0=A0=A0 Product String:=A0=A0 7 "XMOS USB Audio 2.0"
=A0=A0=A0=A0=A0=A0=A0 Serial Number String:=A0=A0 0 (none)
=A0=A0=A0 Configuration Descriptor
=A0=A0=A0=A0=A0=A0=A0 Length (and contents):=A0=A0 273
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0000: 09 02=
 11 01 03 01 00 80=A0 FA
08 0B 00 03 01 00 20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0010: 00 09=
 04 00 00 01 01 01=A0 20
07 09 24 01 00 02 08
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0020: 7B 00=
 00 08 24 0A 28 03=A0 07
00 01 11 24 02 02 01
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0030: 01 00=
 28 02 03 00 00 00=A0 00
00 00 02 11 24 02 01
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0040: 03 06=
 00 28 04 0F 00 00=A0 00
00 00 00 03 0C 24 03
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0050: 16 01=
 01 00 0B 28 00 00=A0 04
0C 24 03 14 01 03 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0060: 0A 28=
 00 00 05 0C 24 03=A0 16
01 03 00 0A 28 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0070: 06 12=
 24 06 0A 02 0F 00=A0 00
00 0F 00 00 00 0F 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0080: 00 00=
 00 12 24 06 0B 01=A0 0F
00 00 00 0F 00 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0090: 0F 00=
 00 00 00 07 05 83=A0 03
06 00 08 09 04 01 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 00a0: 00 01=
 02 20 08 09 04 01=A0 01
02 01 02 20 09 10 24
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 00b0: 01 02=
 00 01 01 00 00 00=A0 02
03 00 00 00 00 06 24
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 00c0: 02 01=
 04 18 07 05 01 05=A0 00
04 01 08 25 01 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 00d0: 02 08=
 00 07 05 81 11 04=A0 00
08 09 04 02 00 00 01
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 00e0: 02 20=
 0A 09 04 02 01 01=A0 01
02 20 0B 10 24 01 16
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 00f0: 00 01=
 01 00 00 00 02 03=A0 00
00 00 00 06 24 02 01
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0100: 04 18=
 07 05 82 05 00 04=A0 01
08 25 01 00 00 02 08
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0110: 00
=A0=A0=A0=A0=A0=A0=A0 Number of Interfaces:=A0=A0 3
=A0=A0=A0=A0=A0=A0=A0 Configuration Value:=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 0x80 (bus-powered)
=A0=A0=A0=A0=A0=A0=A0 MaxPower:=A0=A0 500 ma
=A0=A0=A0=A0=A0=A0=A0 Interface Association=A0=A0 Audio/Unknown
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 First Interface=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Count=A0=A0 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Function Class=A0=A0 1=A0=A0 (Audio)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Function Subclass=A0=A0 0=A0=A0 (Unknown)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Protocol=A0=A0 32
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Function String=A0=A0 0 (none)
=A0=A0=A0=A0=A0=A0=A0 Interface #0 - Audio/Control
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Alternate Setting=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Endpoints=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Class:=A0=A0 1=A0=A0 (Audio)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Subclass;=A0=A0 1=A0=A0 (Contro=
l)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Protocol:=A0=A0 32
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Control Class Specific Header
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Descriptor Version Number:=A0=
=A0 02.00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Category:=A0=A0 8
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Class Specific Size:=A0=A0 123
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bmControls:=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 09=
 24 01 00 02 08 7B 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Clock Source
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Clock ID:=A0=A0 40
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 Internal Pr=
ogrammable Clock
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Controls:=A0=A0 7
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Associated Terminal:=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal Name String Index:=
=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 08=
 24 0A 28 03 07 00 01
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Input Terminal
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal ID:=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Input Terminal Type:=A0=A0 0x=
101 (USB streaming)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 OutTerminal ID:=A0=A0 0 [NONE]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Channels:=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Spatial config of channels:=
=A0=A0 0000000000000011
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 String index for first logica=
l channel:=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal Name String Index:=
=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 11=
 24 02 02 01 01 00 28 02 03
00 00 00 00 00 00 02
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Input Terminal
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal ID:=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Input Terminal Type:=A0=A0 0x=
603 (Line connector)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 OutTerminal ID:=A0=A0 0 [NONE]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Channels:=A0=A0 4
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Spatial config of channels:=
=A0=A0 0000000000001111
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (null)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 String index for first logica=
l channel:=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal Name String Index:=
=A0=A0 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 11=
 24 02 01 03 06 00 28 04 0F
00 00 00 00 00 00 03
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Ouput Terminal
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal ID:=A0=A0 22
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Output Terminal Type:=A0=A0 0=
x101 (USB Isochronous Stream)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 InTerminal ID:=A0=A0 0 [NONE]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Source ID:=A0=A0 11
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal Name String Index:=
=A0=A0 4
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 0C=
 24 03 16 01 01 00 0B 28 00 00 04
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Ouput Terminal
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal ID:=A0=A0 20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Output Terminal Type:=A0=A0 0=
x301 (Speaker)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 InTerminal ID:=A0=A0 0 [NONE]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Source ID:=A0=A0 10
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal Name String Index:=
=A0=A0 5
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 0C=
 24 03 14 01 03 00 0A 28 00 00 05
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Ouput Terminal
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal ID:=A0=A0 22
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Output Terminal Type:=A0=A0 0=
x301 (Speaker)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 InTerminal ID:=A0=A0 0 [NONE]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Source ID:=A0=A0 10
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Terminal Name String Index:=
=A0=A0 6
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 0C=
 24 03 16 01 03 00 0A 28 00 00 06
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Feature
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Unit ID:=A0=A0 10
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Source ID:=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Channels (ch):=A0=
=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Master Channel:..=
....................... ( Mute:RW
Volume:RW=A0 )
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Channel 1:.......=
...................... ( Mute:RW
Volume:RW=A0 )
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Channel 2:.......=
...................... ( Mute:RW
Volume:RW=A0 )
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Feature Unit Name String Inde=
x:=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 12=
 24 06 0A 02 0F 00 00 00 0F
00 00 00 0F 00 00 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Feature
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Unit ID:=A0=A0 11
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Source ID:=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Channels (ch):=A0=
=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Master Channel:..=
....................... ( Mute:RW
Volume:RW=A0 )
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Channel 1:.......=
...................... ( Mute:RW
Volume:RW=A0 )
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Channel 2:.......=
...................... ( Mute:RW
Volume:RW=A0 )
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Feature Unit Name String Inde=
x:=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (hex):=A0=A0 12=
 24 06 0B 01 0F 00 00 00 0F
00 00 00 0F 00 00 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Endpoint 0x83 - Interrupt Input
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address:=A0=A0 0x83=A0 (IN)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 0x03=A0 (In=
terrupt no synchronization data endpoint)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Max Packet Size:=A0=A0 6=A0 (=
6 x 1=A0 transactions
opportunities per microframe)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Polling Interval:=A0=A0 8 (12=
8 microframes (16 msecs) )
=A0=A0=A0=A0=A0=A0=A0 Interface #1 - Audio/Streaming
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Alternate Setting=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Endpoints=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Class:=A0=A0 1=A0=A0 (Audio)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Subclass;=A0=A0 2=A0=A0 (Stream=
ing)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Protocol:=A0=A0 32
=A0=A0=A0=A0=A0=A0=A0 Interface #1 - Audio/Streaming (#1)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Alternate Setting=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Endpoints=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Class:=A0=A0 1=A0=A0 (Audio)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Subclass;=A0=A0 2=A0=A0 (Stream=
ing)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Protocol:=A0=A0 32
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Control Class Specific Header
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Stream General
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Endpoint Terminal=
 ID:=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Format Type:=A0=
=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Formats=A0=A0 PCM
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Channel=
s=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Channel Configura=
tion=A0=A0 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (he=
x):=A0=A0 10 24 01 02 00 01 01 00 00
00 02 03 00 00 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Audio Data Format
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Stream Format Type Desc.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Format Type:=A0=
=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Slot Size:=A0=A0 4
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bit Resolution:=
=A0=A0 24
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (he=
x):=A0=A0 06 24 02 01 04 18
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Endpoint 0x01 - Isochronous Output
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address:=A0=A0 0x01=A0 (OUT)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 0x05=A0 (Is=
ochronous asynchronous data endpoint)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Max Packet Size:=A0=A0 1024=
=A0 (1024 x 1=A0 transactions
opportunities per microframe)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Polling Interval:=A0=A0 1 (1 =
microframe (125 microsecs) )
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Class-Specific AS Audio EndPoint - Contro=
l output
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 0x00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bLockDelayUnits:=A0=A0 0x00=
=A0 (UNDEFINED)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wLockDelay:=A0=A0 2050
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Endpoint 0x81 - Isochronous Input
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address:=A0=A0 0x81=A0 (IN)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 0x11=A0 (Is=
ochronous no synchronization
feedback endpoint)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Max Packet Size:=A0=A0 4=A0 (=
4 x 1=A0 transactions
opportunities per microframe)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Polling Interval:=A0=A0 8 (12=
8 microframes (16 msecs) )
=A0=A0=A0=A0=A0=A0=A0 Interface #2 - Audio/Streaming
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Alternate Setting=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Endpoints=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Class:=A0=A0 1=A0=A0 (Audio)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Subclass;=A0=A0 2=A0=A0 (Stream=
ing)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Protocol:=A0=A0 32
=A0=A0=A0=A0=A0=A0=A0 Interface #2 - Audio/Streaming (#1)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Alternate Setting=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Endpoints=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Class:=A0=A0 1=A0=A0 (Audio)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Subclass;=A0=A0 2=A0=A0 (Stream=
ing)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Protocol:=A0=A0 32
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Control Class Specific Header
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Stream General
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Endpoint Terminal=
 ID:=A0=A0 22
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Format Type:=A0=
=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Formats=A0=A0 PCM
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Channel=
s=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Channel Configura=
tion=A0=A0 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (he=
x):=A0=A0 10 24 01 16 00 01 01 00 00
00 02 03 00 00 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Class Specific Audio Data Format
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Audio Stream Format Type Desc.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Format Type:=A0=
=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Slot Size:=A0=A0 4
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bit Resolution:=
=A0=A0 24
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Dump Contents (he=
x):=A0=A0 06 24 02 01 04 18
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Endpoint 0x82 - Isochronous Input
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Address:=A0=A0 0x82=A0 (IN)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 0x05=A0 (Is=
ochronous asynchronous data endpoint)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Max Packet Size:=A0=A0 1024=
=A0 (1024 x 1=A0 transactions
opportunities per microframe)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Polling Interval:=A0=A0 1 (1 =
microframe (125 microsecs) )
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Class-Specific AS Audio EndPoint - Contro=
l output
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 0x00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bLockDelayUnits:=A0=A0 0x00=
=A0 (UNDEFINED)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wLockDelay:=A0=A0 2050
=A0=A0=A0 Device Qualifier Descriptor
=A0=A0=A0=A0=A0=A0=A0 Descriptor Version Number:=A0=A0 0x0200
=A0=A0=A0=A0=A0=A0=A0 Device Class=A0=A0 239=A0=A0 (Miscellaneous)
=A0=A0=A0=A0=A0=A0=A0 Device Subclass=A0=A0 2=A0=A0 (Common Class)
=A0=A0=A0=A0=A0=A0=A0 Device Protocol=A0=A0 1=A0=A0 (Interface Association)
=A0=A0=A0=A0=A0=A0=A0 Device MaxPacketSize:=A0=A0 64
=A0=A0=A0=A0=A0=A0=A0 Number of Configurations:=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bReserved:=A0=A0 0
=A0=A0=A0 Other Speed Configuration Descriptor
=A0=A0=A0=A0=A0=A0=A0 Length (and contents):=A0=A0 18
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0000: 09 07=
 12 00 01 00 00 C0=A0 32
09 04 00 00 00 00 00
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Raw Descriptor (hex)=A0=A0=A0 0010: 00 00
=A0=A0=A0=A0=A0=A0=A0 Number of Interfaces:=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 Configuration Value:=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0 Attributes:=A0=A0 0xC0 (self-powered)
=A0=A0=A0=A0=A0=A0=A0 MaxPower:=A0=A0 100 ma
=A0=A0=A0=A0=A0=A0=A0 Interface #0 - Unknown
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Alternate Setting=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Number of Endpoints=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Class:=A0=A0 0=A0=A0 (Unknown)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Subclass;=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Interface Protocol:=A0=A0 0

From: yes work <yeswork@yahoo.com>
Subject: Fw: ALSA Volume control with Creative X
Date: Sat, 25 Jul 2009 07:36:21 -0700 (PDT)
Message-ID: <316782.98593.qm@web56308.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web56308.mail.re3.yahoo.com (web56308.mail.re3.yahoo.com
	[216.252.110.232])
	by alsa0.perex.cz (Postfix) with SMTP id 4FE7C2479B
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Jul 2009 16:36:27 +0200 (CEST)
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





----- Forwarded Message ----
From: yes work <yeswork@yahoo.com>
To: clemens@ladisch.de
Sent: Wednesday, July 1, 2009 13:03:22
Subject: ALSA Volume control with Creative X

Hi,

I read in one of your posts about an interest info to improve ALSA.=A0 I wo=
uld like to provide some information that might help improve/augment ALSA f=
or me and others using a creative external usb sound "card."

I am running Fedora 11, command line (no=A0windowing environment) and I hav=
e a Creative Xmod external USB sound card http://us.creative.com/products/p=
roduct.asp?category=3D209&subcategory=3D668&product=3D15913=A0

This Creative device=A0outputs sound OK through ALSA,=A0but the Volume cont=
rol/Mute knob DO NOT CHANGE the audio.=A0Creative does not provide Linux dr=
ivers (the knob works to control volume and mute=A0without installing any d=
rivers on a MS Windows setup). In Fedora, turning the volume knob causes "e=
scape characters" to be displayed on the command line.

I have included a copy of an=A0cropped lsusb -v log, below.=A0 I hope this =
might be a step towards getting the volume/mute knob to work with ALSA/Fedo=
ra.=A0 Let me know if I can be of more help.

Thanks,

Keith


[vortexbox.localdomain ~]# lsusb -v

Bus 002 Device 002: ID 041e:30d0 Creative Technology, Ltd =

Device Descriptor:
=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 18
=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0 bcdUSB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.10
=A0 bDeviceClass=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 (Defined at Interface l=
evel)
=A0 bDeviceSubClass=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0 bDeviceProtocol=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0 bMaxPacketSize0=A0=A0=A0=A0=A0=A0=A0 64
=A0 idVendor=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x041e Creative Technology, Ltd
=A0 idProduct=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x30d0 =

=A0 bcdDevice=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.00
=A0 iManufacturer=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 Creative Technology Ltd
=A0 iProduct=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 Creative Xmod
=A0 iSerial=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0 bNumConfigurations=A0=A0=A0=A0=A0 1
=A0 Configuration Descriptor:
=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9
=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0 wTotalLength=A0=A0=A0=A0=A0=A0=A0=A0=A0 315
=A0=A0=A0 bNumInterfaces=A0=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0 bConfigurationValue=A0=A0=A0=A0 1
=A0=A0=A0 iConfiguration=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0 bmAttributes=A0=A0=A0=A0=A0=A0=A0=A0 0x80
=A0=A0=A0=A0=A0 (Bus Powered)
=A0=A0=A0 MaxPower=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 98mA
=A0=A0=A0 Interface Descriptor:
=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9
=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0=A0=A0 bInterfaceNumber=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0 bAlternateSetting=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0 bNumEndpoints=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0 bInterfaceClass=A0=A0=A0=A0=A0=A0=A0=A0 1 Audio
=A0=A0=A0=A0=A0 bInterfaceSubClass=A0=A0=A0=A0=A0 1 Control Device
=A0=A0=A0=A0=A0 bInterfaceProtocol=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 iInterface=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
10
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 1 (HEADER)
=A0=A0=A0=A0=A0=A0=A0 bcdADC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.00
=A0=A0=A0=A0=A0=A0=A0 wTotalLength=A0=A0=A0=A0=A0=A0=A0=A0=A0 159
=A0=A0=A0=A0=A0=A0=A0 bInCollection=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 baInterfaceNr( 0)=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 baInterfaceNr( 1)=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
12
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 2 (INPUT_TERMINAL)
=A0=A0=A0=A0=A0=A0=A0 bTerminalID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 wTerminalType=A0=A0=A0=A0=A0 0x0101 USB Streaming
=A0=A0=A0=A0=A0=A0=A0 bAssocTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0 bNrChannels=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6
=A0=A0=A0=A0=A0=A0=A0 wChannelConfig=A0=A0=A0=A0 0x003f
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Left Front (L)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Right Front (R)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Center Front (C)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Low Freqency Enhancement (LFE)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Left Surround (LS)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Right Surround (RS)
=A0=A0=A0=A0=A0=A0=A0 iChannelNames=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 iTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
12
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 2 (INPUT_TERMINAL)
=A0=A0=A0=A0=A0=A0=A0 bTerminalID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 12
=A0=A0=A0=A0=A0=A0=A0 wTerminalType=A0=A0=A0=A0=A0 0x0603 Line Connector
=A0=A0=A0=A0=A0=A0=A0 bAssocTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0 bNrChannels=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 wChannelConfig=A0=A0=A0=A0 0x0003
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Left Front (L)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Right Front (R)
=A0=A0=A0=A0=A0=A0=A0 iChannelNames=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 iTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
12
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 2 (INPUT_TERMINAL)
=A0=A0=A0=A0=A0=A0=A0 bTerminalID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0=A0=A0=A0=A0 wTerminalType=A0=A0=A0=A0=A0 0x0603 Line Connector
=A0=A0=A0=A0=A0=A0=A0 bAssocTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0 bNrChannels=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 wChannelConfig=A0=A0=A0=A0 0x0003
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Left Front (L)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Right Front (R)
=A0=A0=A0=A0=A0=A0=A0 iChannelNames=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 iTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
12
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 2 (INPUT_TERMINAL)
=A0=A0=A0=A0=A0=A0=A0 bTerminalID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 7
=A0=A0=A0=A0=A0=A0=A0 wTerminalType=A0=A0=A0=A0=A0 0x0201 Microphone
=A0=A0=A0=A0=A0=A0=A0 bAssocTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0 bNrChannels=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 wChannelConfig=A0=A0=A0=A0 0x0003
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Left Front (L)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Right Front (R)
=A0=A0=A0=A0=A0=A0=A0 iChannelNames=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 iTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
17
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 4 (MIXER_UNIT)
=A0=A0=A0=A0=A0=A0=A0 bUnitID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
11
=A0=A0=A0=A0=A0=A0=A0 bNrInPins=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 baSourceID( 0)=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 baSourceID( 1)=A0=A0=A0=A0=A0=A0=A0=A0 13
=A0=A0=A0=A0=A0=A0=A0 bNrChannels=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6
=A0=A0=A0=A0=A0=A0=A0 wChannelConfig=A0=A0=A0=A0 0x003f
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Left Front (L)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Right Front (R)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Center Front (C)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Low Freqency Enhancement (LFE)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Left Surround (LS)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Right Surround (RS)
=A0=A0=A0=A0=A0=A0=A0 iChannelNames=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 bmControls=A0=A0=A0=A0=A0=A0=A0=A0 0x00
=A0=A0=A0=A0=A0=A0=A0 bmControls=A0=A0=A0=A0=A0=A0=A0=A0 0x00
=A0=A0=A0=A0=A0=A0=A0 iMixer=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 junk at descriptor end: 00 00 00
=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
18
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 7 (PROCESSING_UNIT)
=A0=A0=A0=A0=A0=A0=A0 bUnitID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
10
=A0=A0=A0=A0=A0=A0=A0 wProcessType=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bNrPins=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 1
=A0=A0=A0=A0=A0=A0=A0 baSourceID( 0)=A0=A0=A0=A0=A0=A0=A0=A0 11
=A0=A0=A0=A0=A0=A0=A0 bNrChannels=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 wChannelConfig=A0=A0=A0=A0 0x0003
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Left Front (L)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Right Front (R)
=A0=A0=A0=A0=A0=A0=A0 iChannelNames=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 bControlSize=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bmControls( 0)=A0=A0=A0=A0=A0=A0 0x01
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Enable Processing
=A0=A0=A0=A0=A0=A0=A0 iProcessing=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 Process-Specific=A0=A0=A0=A0 01 03 00
=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
10
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 6 (FEATURE_UNIT)
=A0=A0=A0=A0=A0=A0=A0 bUnitID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 5
=A0=A0=A0=A0=A0=A0=A0 bSourceID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10
=A0=A0=A0=A0=A0=A0=A0 bControlSize=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 0)=A0=A0=A0=A0=A0 0x01
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Mute
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 1)=A0=A0=A0=A0=A0 0x02
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Volume
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 2)=A0=A0=A0=A0=A0 0x02
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Volume
=A0=A0=A0=A0=A0=A0=A0 iFeature=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
10
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 6 (FEATURE_UNIT)
=A0=A0=A0=A0=A0=A0=A0 bUnitID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 6
=A0=A0=A0=A0=A0=A0=A0 bSourceID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0=A0=A0=A0=A0 bControlSize=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 0)=A0=A0=A0=A0=A0 0x00
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 1)=A0=A0=A0=A0=A0 0x02
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Volume
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 2)=A0=A0=A0=A0=A0 0x02
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Volume
=A0=A0=A0=A0=A0=A0=A0 iFeature=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
10
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 6 (FEATURE_UNIT)
=A0=A0=A0=A0=A0=A0=A0 bUnitID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 9
=A0=A0=A0=A0=A0=A0=A0 bSourceID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 7
=A0=A0=A0=A0=A0=A0=A0 bControlSize=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 0)=A0=A0=A0=A0=A0 0x40
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Automatic Gain
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 1)=A0=A0=A0=A0=A0 0x02
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Volume
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 2)=A0=A0=A0=A0=A0 0x02
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Volume
=A0=A0=A0=A0=A0=A0=A0 iFeature=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
10
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 6 (FEATURE_UNIT)
=A0=A0=A0=A0=A0=A0=A0 bUnitID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
13
=A0=A0=A0=A0=A0=A0=A0 bSourceID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 12
=A0=A0=A0=A0=A0=A0=A0 bControlSize=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 0)=A0=A0=A0=A0=A0 0x01
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Mute
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 1)=A0=A0=A0=A0=A0 0x02
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Volume
=A0=A0=A0=A0=A0=A0=A0 bmaControls( 2)=A0=A0=A0=A0=A0 0x02
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Volume
=A0=A0=A0=A0=A0=A0=A0 iFeature=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 8
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 5 (SELECTOR_UNIT)
=A0=A0=A0=A0=A0=A0=A0 bUnitID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 8
=A0=A0=A0=A0=A0=A0=A0 bNrInPins=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 baSource( 0)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6
=A0=A0=A0=A0=A0=A0=A0 baSource( 1)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9
=A0=A0=A0=A0=A0=A0=A0 iSelector=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 9
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 3 (OUTPUT_TERMINAL)
=A0=A0=A0=A0=A0=A0=A0 bTerminalID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 wTerminalType=A0=A0=A0=A0=A0 0x0301 Speaker
=A0=A0=A0=A0=A0=A0=A0 bAssocTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0 bSourceID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5
=A0=A0=A0=A0=A0=A0=A0 iTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioControl Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 9
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 3 (OUTPUT_TERMINAL)
=A0=A0=A0=A0=A0=A0=A0 bTerminalID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
=A0=A0=A0=A0=A0=A0=A0 wTerminalType=A0=A0=A0=A0=A0 0x0101 USB Streaming
=A0=A0=A0=A0=A0=A0=A0 bAssocTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0 bSourceID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8
=A0=A0=A0=A0=A0=A0=A0 iTerminal=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0 Interface Descriptor:
=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9
=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0=A0=A0 bInterfaceNumber=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0 bAlternateSetting=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0 bNumEndpoints=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0 bInterfaceClass=A0=A0=A0=A0=A0=A0=A0=A0 1 Audio
=A0=A0=A0=A0=A0 bInterfaceSubClass=A0=A0=A0=A0=A0 2 Streaming
=A0=A0=A0=A0=A0 bInterfaceProtocol=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 iInterface=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0 Interface Descriptor:
=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9
=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0=A0=A0 bInterfaceNumber=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0 bAlternateSetting=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0 bNumEndpoints=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0 bInterfaceClass=A0=A0=A0=A0=A0=A0=A0=A0 1 Audio
=A0=A0=A0=A0=A0 bInterfaceSubClass=A0=A0=A0=A0=A0 2 Streaming
=A0=A0=A0=A0=A0 bInterfaceProtocol=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 iInterface=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioStreaming Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 7
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 1 (AS_GENERAL)
=A0=A0=A0=A0=A0=A0=A0 bTerminalLink=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bDelay=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0 frames
=A0=A0=A0=A0=A0=A0=A0 wFormatTag=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 P=
CM
=A0=A0=A0=A0=A0 AudioStreaming Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
11
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 2 (FORMAT_TYPE)
=A0=A0=A0=A0=A0=A0=A0 bFormatType=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 (FO=
RMAT_TYPE_I)
=A0=A0=A0=A0=A0=A0=A0 bNrChannels=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6
=A0=A0=A0=A0=A0=A0=A0 bSubframeSize=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 bBitResolution=A0=A0=A0=A0=A0=A0=A0=A0 16
=A0=A0=A0=A0=A0=A0=A0 bSamFreqType=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 Discr=
ete
=A0=A0=A0=A0=A0=A0=A0 tSamFreq[ 0]=A0=A0=A0=A0=A0=A0=A0 44100
=A0=A0=A0=A0=A0 Endpoint Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 9
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 5
=A0=A0=A0=A0=A0=A0=A0 bEndpointAddress=A0=A0=A0=A0 0x01=A0 EP 1 OUT
=A0=A0=A0=A0=A0=A0=A0 bmAttributes=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Transfer Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
Isochronous
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Synch Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Asynchronous
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Usage Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Data
=A0=A0=A0=A0=A0=A0=A0 wMaxPacketSize=A0=A0=A0=A0 0x021c=A0 1x 540 bytes
=A0=A0=A0=A0=A0=A0=A0 bInterval=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bRefresh=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0
=A0=A0=A0=A0=A0=A0=A0 bSynchAddress=A0=A0=A0=A0=A0=A0=A0=A0 129
=A0=A0=A0=A0=A0=A0=A0 AudioControl Endpoint Descriptor:
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 7
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 37
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 1 (EP_GENERAL)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bmAttributes=A0=A0=A0=A0=A0=A0=A0=A0 0x00
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bLockDelayUnits=A0=A0=A0=A0=A0=A0=A0=A0 0 Undef=
ined
=A0=A0=A0=A0=A0=A0=A0=A0=A0 wLockDelay=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0 Undefined
=A0=A0=A0=A0=A0 Endpoint Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 9
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 5
=A0=A0=A0=A0=A0=A0=A0 bEndpointAddress=A0=A0=A0=A0 0x81=A0 EP 1 IN
=A0=A0=A0=A0=A0=A0=A0 bmAttributes=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Transfer Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
Isochronous
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Synch Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 None
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Usage Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Data
=A0=A0=A0=A0=A0=A0=A0 wMaxPacketSize=A0=A0=A0=A0 0x0003=A0 1x 3 bytes
=A0=A0=A0=A0=A0=A0=A0 bInterval=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bRefresh=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 5
=A0=A0=A0=A0=A0=A0=A0 bSynchAddress=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0 Interface Descriptor:
=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9
=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0=A0=A0 bInterfaceNumber=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0 bAlternateSetting=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0 bNumEndpoints=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0 bInterfaceClass=A0=A0=A0=A0=A0=A0=A0=A0 1 Audio
=A0=A0=A0=A0=A0 bInterfaceSubClass=A0=A0=A0=A0=A0 2 Streaming
=A0=A0=A0=A0=A0 bInterfaceProtocol=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 iInterface=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0 Interface Descriptor:
=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9
=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0=A0=A0 bInterfaceNumber=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0 bAlternateSetting=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0 bNumEndpoints=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0 bInterfaceClass=A0=A0=A0=A0=A0=A0=A0=A0 1 Audio
=A0=A0=A0=A0=A0 bInterfaceSubClass=A0=A0=A0=A0=A0 2 Streaming
=A0=A0=A0=A0=A0 bInterfaceProtocol=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 iInterface=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0 AudioStreaming Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 7
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 1 (AS_GENERAL)
=A0=A0=A0=A0=A0=A0=A0 bTerminalLink=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
=A0=A0=A0=A0=A0=A0=A0 bDelay=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0 frames
=A0=A0=A0=A0=A0=A0=A0 wFormatTag=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 P=
CM
=A0=A0=A0=A0=A0 AudioStreaming Interface Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
11
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 36
=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 2 (FORMAT_TYPE)
=A0=A0=A0=A0=A0=A0=A0 bFormatType=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 (FO=
RMAT_TYPE_I)
=A0=A0=A0=A0=A0=A0=A0 bNrChannels=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 bSubframeSize=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
=A0=A0=A0=A0=A0=A0=A0 bBitResolution=A0=A0=A0=A0=A0=A0=A0=A0 16
=A0=A0=A0=A0=A0=A0=A0 bSamFreqType=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 Discr=
ete
=A0=A0=A0=A0=A0=A0=A0 tSamFreq[ 0]=A0=A0=A0=A0=A0=A0=A0 44100
=A0=A0=A0=A0=A0 Endpoint Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 9
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 5
=A0=A0=A0=A0=A0=A0=A0 bEndpointAddress=A0=A0=A0=A0 0x82=A0 EP 2 IN
=A0=A0=A0=A0=A0=A0=A0 bmAttributes=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Transfer Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
Isochronous
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Synch Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 None
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Usage Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Data
=A0=A0=A0=A0=A0=A0=A0 wMaxPacketSize=A0=A0=A0=A0 0x00b4=A0 1x 180 bytes
=A0=A0=A0=A0=A0=A0=A0 bInterval=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0 bRefresh=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0
=A0=A0=A0=A0=A0=A0=A0 bSynchAddress=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0 AudioControl Endpoint Descriptor:
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 7
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 37
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bDescriptorSubtype=A0=A0=A0=A0=A0 1 (EP_GENERAL)
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bmAttributes=A0=A0=A0=A0=A0=A0=A0=A0 0x00
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bLockDelayUnits=A0=A0=A0=A0=A0=A0=A0=A0 0 Undef=
ined
=A0=A0=A0=A0=A0=A0=A0=A0=A0 wLockDelay=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0 Undefined
=A0=A0=A0 Interface Descriptor:
=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 9
=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 4
=A0=A0=A0=A0=A0 bInterfaceNumber=A0=A0=A0=A0=A0=A0=A0 3
=A0=A0=A0=A0=A0 bAlternateSetting=A0=A0=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0 bNumEndpoints=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0 bInterfaceClass=A0=A0=A0=A0=A0=A0=A0=A0 3 Human Interface D=
evice
=A0=A0=A0=A0=A0 bInterfaceSubClass=A0=A0=A0=A0=A0 0 No Subclass
=A0=A0=A0=A0=A0 bInterfaceProtocol=A0=A0=A0=A0=A0 0 None
=A0=A0=A0=A0=A0 iInterface=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 =

=A0=A0=A0=A0=A0=A0=A0 HID Device Descriptor:
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 9
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 33
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bcdHID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 1.11
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bCountryCode=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
 Not supported
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bNumDescriptors=A0=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0 34 Report
=A0=A0=A0=A0=A0=A0=A0=A0=A0 wDescriptorLength=A0=A0=A0=A0=A0 45
=A0=A0=A0=A0=A0=A0=A0=A0 Report Descriptors: =

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ** UNAVAILABLE **
=A0=A0=A0=A0=A0 Endpoint Descriptor:
=A0=A0=A0=A0=A0=A0=A0 bLength=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 7
=A0=A0=A0=A0=A0=A0=A0 bDescriptorType=A0=A0=A0=A0=A0=A0=A0=A0 5
=A0=A0=A0=A0=A0=A0=A0 bEndpointAddress=A0=A0=A0=A0 0x83=A0 EP 3 IN
=A0=A0=A0=A0=A0=A0=A0 bmAttributes=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Transfer Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
Interrupt
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Synch Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 None
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Usage Type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Data
=A0=A0=A0=A0=A0=A0=A0 wMaxPacketSize=A0=A0=A0=A0 0x0001=A0 1x 1 bytes
=A0=A0=A0=A0=A0=A0=A0 bInterval=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10
Device Status:=A0=A0=A0=A0 0x0000
=A0 (Bus Powered)
[vortexbox.localdomain ~]# =



=A0 =A0 =A0 New Email names for you! =

Get the Email name you've always wanted on the new @ymail and @rocketmail. =

Hurry before someone else does!
http://mail.promotions.yahoo.com/newdomains/aa/



      Get your preferred Email name!
Now you can @ymail.com and @rocketmail.com. =

http://mail.promotions.yahoo.com/newdomains/aa/

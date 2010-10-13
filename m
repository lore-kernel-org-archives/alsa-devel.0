From: Julian Scheel <julian@jusst.de>
Subject: USB asynchronous mode feedback format
Date: Wed, 13 Oct 2010 17:50:18 +0200
Message-ID: <201010131750.18897.julian@jusst.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6UdtMFCuF9a5n3l"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id B8B452414B
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 17:50:21 +0200 (CEST)
Received: from [127.0.0.1] (helo=juli-workstation.localnet)
	by smtp2.work.de with esmtpa (Exim 4.69)
	(envelope-from <julian@jusst.de>) id 1P63au-0005sc-Pd
	for alsa-devel@alsa-project.org; Wed, 13 Oct 2010 17:50:20 +0200
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

--Boundary-00=_6UdtMFCuF9a5n3l
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I am currently working on an USB-Audio device based on a AT91SAM7 processor. 
Actually I am currently trying to get the asynchronous mode working, to be 
able to use the AT91SAM7 as I2S transmitter in slave mode, utilizing and 
external clock.
So I added the endpoint descriptors for the Feedback pipe. I attached the 
lsusb output.
Alsa detects the card properly and reports it to be async in the /proc/asound 
interface. Now for a first tested I am trying to report back a constant rate 
through the feedback pipe. The stream is 48kHz with 16Bit.
Reading the USB Audio 1.0 spec I assume in theory for a 48kHz stream I would 
report a rate of 48 samples per frame to the host, compensated by the measured 
drift. As the data should be 10.14 encoded I currently send { 0x0c, 0x00, 0x00 
} on the feedback pipe whenever it is queried, which happens whenever I try to 
play some stream on this device.
But unfortunately the host won't send any data to the device. I am wondering 
what might be wrong and where to check that alsa received the feedback data 
properly?

I would be really thankful for any help!

Regards,
Julian

--Boundary-00=_6UdtMFCuF9a5n3l
Content-Type: text/plain;
  charset="UTF-8";
  name="usbdesc.async"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbdesc.async"


Bus 001 Device 100: ID 03eb:6128 Atmel Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x03eb Atmel Corp.
  idProduct          0x6128 
  bcdDevice            1.00
  iManufacturer           1 Atmel
  iProduct                2 Desktop speaker
  iSerial                 3 0123
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          119
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           40
        bInCollection           1
        baInterfaceNr( 0)       1
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             0
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          1
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               0
        bControlSize            1
        bmaControls( 0)      0x01
          Mute Control
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
        iFeature                0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           0
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress         132
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval               1
        bRefresh                6
        bSynchAddress           0
Device Status:     0x0000
  (Bus Powered)

--Boundary-00=_6UdtMFCuF9a5n3l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_6UdtMFCuF9a5n3l--

From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 19:16:25 +0200
Message-ID: <201010151916.26003.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010151624.46800.julian@jusst.de>
	<1287153698.3730.7.camel@laptop-alex>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pxIuMQOzOr7dRK7"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 418B3103C78
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 19:16:28 +0200 (CEST)
In-Reply-To: <1287153698.3730.7.camel@laptop-alex>
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
Cc: Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_pxIuMQOzOr7dRK7
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Am Freitag, 15. Oktober 2010, 16:41:38 schrieb Alex Lee:
> On Fri, 2010-10-15 at 16:24 +0200, Julian Scheel wrote:
> > Don't see any syncpipe related errors. Only thing I see is:
> > usb 1-1.3: new full speed USB device using ehci_hcd and address 11
> > 11:1:1: endpoint lacks sample rate attribute bit, cannot set.
> > 11:1:1: endpoint lacks sample rate attribute bit, cannot set.
> > 
> > Does not seem to be feedback related... Although it would be nice to
> > know, what's wrong there?
> 
> You probably need to fix that sample rate attribute bit for rate
> feedback to work.
> 
> It is in the bmAttribute of the
> 	//Audio endpoint specific descriptor
> #define AUDIO_EP_ATRIBUTES	UAC_EP_CS_ATTR_SAMPLE_RATE	 // sampling freq,
> no pitch, no pading
> 
> #define AUDIO_EP_DELAY_UNIT	0x00	 	// Unused
> #define AUDIO_EP_LOCK_DELAY	0x0000		// Unused

You mean in the class specific endpoint descriptor for the audio streaming 
endpoint?
Actually I added it there (bmAttributes = 0x01), but this stops alsa from 
detecting the device at all. Attaches is the new lsusb out.

Regards,
Julian

--Boundary-00=_pxIuMQOzOr7dRK7
Content-Type: text/plain;
  charset="UTF-8";
  name="usbdesc.async"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbdesc.async"


Bus 001 Device 012: ID 03eb:6128 Atmel Corp. 
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
        bSynchAddress         133
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           17
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               1
        bRefresh                6
        bSynchAddress           0
Device Status:     0x0000
  (Bus Powered)

--Boundary-00=_pxIuMQOzOr7dRK7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_pxIuMQOzOr7dRK7--

From: Thorsten Mika <info@thorstenmika.com>
Subject: C-Media MD 85217
Date: Thu, 18 May 2006 09:49:59 +0200
Message-ID: <20060518094959.53a5b85f@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello all,

I just purchased a set of flat speakers in a german discount shop, manufactured by Medion an bearing the description MD 85217.

It consists of the speaker, which can be connected by a headphone-syle jack to the phone output, and a small USB-interface providing a headphone jack which produces a louder and better-sounding output.

alsamixer recognizes the interface and shows up one volume control labelled "PCM", but unfortunately it does not have much effect, except that it turns off the speaker when switched to zero. So it only allows maximum output and mute.

"lsusb" says:


>Bus 001 Device 004: ID 0d8c:0001 C-Media Electronics, Inc. 
>Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               1.10
>  bDeviceClass            0 (Defined at Interface level)
>  bDeviceSubClass         0 
>  bDeviceProtocol         0 
>  bMaxPacketSize0         8
>  idVendor           0x0d8c C-Media Electronics, Inc.
>  idProduct          0x0001 
>  bcdDevice            0.10
>  iManufacturer           1 C-Media INC.
>  iProduct                2 USB Audio
>  iSerial                 0 
>  bNumConfigurations      1
>  Configuration Descriptor:
>    bLength                 9
>    bDescriptorType         2
>    wTotalLength          110
>    bNumInterfaces          2
>    bConfigurationValue     1
>    iConfiguration          0 
>    bmAttributes         0x80
>    MaxPower              500mA
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>     bInterfaceNumber        0
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      1 Control Device
 >     bInterfaceProtocol      0 
>      iInterface              0 
>      AudioControl Interface Descriptor:
>        bLength                 9
>        bDescriptorType        36
>        bDescriptorSubtype      1 (HEADER)
>        bcdADC               1.00
>        wTotalLength           40
>        bInCollection           1
>        baInterfaceNr( 0)       1
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      2 (INPUT_TERMINAL)
>        bTerminalID             1
>        wTerminalType      0x0101 USB Streaming
>        bAssocTerminal          0
>        bNrChannels             2
>        wChannelConfig     0x0003
>         Left Front (L)
>         Right Front (R)
>       iChannelNames           0 
>       iTerminal               0 
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                13
>        bSourceID               1
>        bControlSize            1
>        bmaControls( 0)      0x03
>          Mute
>          Volume
>        bmaControls( 1)      0x00
>        bmaControls( 2)      0x00
>        iFeature                0 
>      AudioControl Interface Descriptor:
>        bLength                 9
>        bDescriptorType        36
>        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>        bTerminalID             3
>        wTerminalType      0x0301 Speaker
>        bAssocTerminal          0
>        bSourceID              13
>        iTerminal               0 
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
<      bInterfaceProtocol      0 
>      iInterface              0 
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0 
>      iInterface              0 
>      AudioStreaming Interface Descriptor:
>        bLength                 7
>        bDescriptorType        36
>        bDescriptorSubtype      1 (AS_GENERAL)
>        bTerminalLink           1
>        bDelay                  1 frames
>        wFormatTag              1 PCM
>      AudioStreaming Interface Descriptor:
>        bLength                11
>        bDescriptorType        36
>        bDescriptorSubtype      2 (FORMAT_TYPE)
>        bFormatType             1 (FORMAT_TYPE_I)
>        bNrChannels             2
>        bSubframeSize           2
>        bBitResolution         16
>        bSamFreqType            1 Discrete
>        tSamFreq[ 0]        48000
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x06  EP 6 OUT
>        bmAttributes            9
>          Transfer Type            Isochronous
>          Synch Type               Adaptive
>          Usage Type               Data
>        wMaxPacketSize     0x00c0  1x 192 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>        AudioControl Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType        37
>          bDescriptorSubtype      1 (EP_GENERAL)
>          bmAttributes         0x00
>          bLockDelayUnits         0 Undefined
>          wLockDelay              0 Undefined
>
>Bus 001 Device 001: ID 0000:0000  
>Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               1.10
> bDeviceClass            9 Hub
> bDeviceSubClass         0 Unused
> bDeviceProtocol         0 
> bMaxPacketSize0        64
> idVendor           0x0000 
> idProduct          0x0000 
> bcdDevice            2.06
>  iManufacturer           3 Linux 2.6.16.9 ohci_hcd
> iProduct                2 OHCI Host Controller
>  iSerial                 1 0000:00:14.0
> bNumConfigurations      1
> Configuration Descriptor:
>   bLength                 9
>    bDescriptorType         2
>    wTotalLength           25
>    bNumInterfaces          1
>    bConfigurationValue     1
>    iConfiguration          0 
>    bmAttributes         0xc0
>      Self Powered
>    MaxPower                0mA
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        0
>      bAlternateSetting       0
>      bNumEndpoints           1
>      bInterfaceClass         9 Hub
>      bInterfaceSubClass      0 Unused
>      bInterfaceProtocol      0 
>      iInterface              0 
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x81  EP 1 IN
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0002  1x 2 bytes
>        bInterval             255
>Hub Descriptor:
 > bLength               9
 > bDescriptorType      41
 > nNbrPorts             2
 > wHubCharacteristic 0x0002
 >   No power switching (usb 1.0)
 >   Ganged overcurrent protection
 > bPwrOn2PwrGood        1 * 2 milli seconds
 > bHubContrCurrent      0 milli Ampere
 > DeviceRemovable    0x08
 > PortPwrCtrlMask    0xc8 
 >Hub Port Status:
 >  Port 1: 0000.0100 power
 >  Port 2: 0000.0103 power enable connect


and amixer info says
>numid=1,iface=MIXER,name='PCM Playback Switch'
>  ; type=BOOLEAN,access=rw---,values=1
>  : values=on
>numid=2,iface=MIXER,name='PCM Playback Volume'
>  ; type=INTEGER,access=rw---,values=1,min=0,max=37,step=0
>  : values=30


Is there any chance to get this thing going? Let me know when I can provide more details.

Thanks in advance,

  thorsten



-- 
Thorsten Mika                         mailto: info@thorstenmika.com
Muenster / Germany                        +49 - (0) 251 - 200 76 83

Public Key ID: 28BAEE63 -- http://www.pgp.net


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

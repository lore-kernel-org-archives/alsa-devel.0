From: Daniel Frey <d.frey@gmx.de>
Subject: Re: Problem with USB headset
Date: Fri, 03 Feb 2006 19:57:42 +0100
Message-ID: <43E3A7A6.8090004@gmx.de>
References: <43E3939A.7060002@gmx.de> <1138988883.15691.261.camel@mindpipe>	 <43E39C8C.8000409@gmx.de> <1138990466.15691.279.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1138990466.15691.279.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Fri, 2006-02-03 at 19:10 +0100, Daniel Frey wrote:
> 
>>Lee Revell wrote:
>>
>>>On Fri, 2006-02-03 at 18:32 +0100, Daniel Frey wrote:
>>>
>>>If you are getting "cannot submit datapipe for urb 0, err = -28" then it
>>>means you MUST have enabled USB bandwidth checking.  Please make sure
>>>it's really disabled.
>>>
>>>Try:
>>>
>>>$ grep CONFIG_USB_BANDWIDTH /boot/config-`uname -r`
>>
>>daniel@nemesis:~$ grep CONFIG_USB_BANDWIDTH /boot/config-`uname -r`
>># CONFIG_USB_BANDWIDTH is not set
>>daniel@nemesis:~$
>>
>>OK?
> 
> OK, that's completely bizarre, and I've never seen another case like it.
> Also, plughw should handle all sample rate conversion, it's very strange
> that alsa-lib resampling fails...

I guess it can only handle sample rate conversion when it knows that it
has to do sample rate conversion. So, maybe the hardware reports the
wrong sample rates?

Here's some output from lsusb -v, which (to me) seems to say: "Hey, I
can do 8000". What it doesn't say is "I can do 16000", but that may be
handled correctly by converting some other sample rate to 16000.

Bus 001 Device 005: ID 046d:0a02 Logitech, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0x0a02
  bcdDevice           10.12
  iManufacturer           1
  iProduct                2
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          343
    bNumInterfaces          4
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
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          117
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID              13
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 1)      0x00
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            12
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 9
        bNrInPins               2
        baSourceID( 0)         12
        baSourceID( 1)          6
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        bmControls         0x00
        iMixer                  0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 1
        bSourceID               9
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 1)      0x02
          Volume
        bmaControls( 2)      0x02
          Volume
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            14
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            11
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID              11
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 1)      0x00
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 7
        bNrInPins               1
        baSourceID( 0)          2
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0
        bmControls         0x00
        iMixer                  0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               7
        iTerminal               0
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
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      57
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               8

Anything else I could do?

Regards, Daniel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

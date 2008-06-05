From: Erik Slagter <erik@slagter.name>
Subject: Re: Specs available for Sweex External 5.1 with
 digital in/out USB 2.0 / C-Media CM6207
Date: Thu, 05 Jun 2008 15:19:56 +0200
Message-ID: <4847E7FC.4040005@slagter.name>
References: <4845A420.10804@slagter.name> <4847BFA2.70202@fastmail.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2767518458358400287=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eriks.xs4all.nl (eriks.xs4all.nl [83.160.41.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C84324621
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 15:19:58 +0200 (CEST)
In-Reply-To: <4847BFA2.70202@fastmail.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============2767518458358400287==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms000304030601050600060603"

This is a cryptographically signed message in MIME format.

--------------ms000304030601050600060603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Clemens Ladisch wrote:
> Erik Slagter wrote:
>> These are the actual issues (so far, I didn't yet test it exhaustively):
>>
>>   - using 2 channel output the sound is garbled; it looks like the
>> "wrong" 2 channel alt setting is used (output of
>> /proc/asound/card?/stream0 on request), 4/6 channel output is OK though.
>>   - some high squeeking noise although C-Media claims the IC to be
>> high-end (or maybe their definition of high-end differs from mine ;-))
>>   - all outputs are labelled "speaker 1"
>>   - only two outputs have a mute knob, the others cannot be silenced in
>> any way, only turned down
>>   - one of the two outputs with the mute knob doesn't appear to do
>> anything (or maybe it's the sp/dif output?)
>>   - the other (with mute) controls the front output
>>   - the others (without mute) don't seem to do anything at all
> 
> Please show the output of "lsusb -v" for this device.

Well, you asked for it >:-) I have added the output of 
/proc/asound/card?/stream0, which might be a less more readable.

Bus 005 Device 005: ID 0d8c:0102 C-Media Electronics, Inc. CM106 Like 
Sound Device
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0d8c C-Media Electronics, Inc.
   idProduct          0x0102 CM106 Like Sound Device
   bcdDevice            0.10
   iManufacturer           0
   iProduct                2 USB Sound Device
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          534
     bNumInterfaces          4
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
       (Bus Powered)
     MaxPower              500mA

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
         wTotalLength          200
         bInCollection           2
         baInterfaceNr( 0)       1
         baInterfaceNr( 1)       2
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             1
         wTerminalType      0x0101 USB Streaming
         bAssocTerminal          0
         bNrChannels             8
         wChannelConfig     0x063f
           Left Front (L)
           Right Front (R)
           Center Front (C)
           Low Freqency Enhancement (LFE)
           Left Surround (LS)          Right Surround (RS)
           Side Left (SL)
           Side Right (SR)
         iChannelNames           0
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             4
         wTerminalType      0x0201 Microphone
         bAssocTerminal          0
         bNrChannels             2
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 8
         bSourceID               4
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
         bmaControls( 1)      0x02
           Volume
         bmaControls( 2)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 9
         bSourceID               4
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
         bmaControls( 1)      0x02
           Volume
         bmaControls( 2)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                25
         bDescriptorType        36
         bDescriptorSubtype      4 (MIXER_UNIT)
         bUnitID                12
         bNrInPins               3
         baSourceID( 0)          1
         baSourceID( 1)          9
         baSourceID( 2)         11
         bNrChannels             8
         wChannelConfig     0x063f
           Left Front (L)
           Right Front (R)
           Center Front (C)
           Low Freqency Enhancement (LFE)
           Left Surround (LS)
           Right Surround (RS)
           Side Left (SL)
           Side Right (SR)
         iChannelNames           0
         bmControls         0x00
         bmControls         0x00
         bmControls         0x00
         iMixer                  0
         junk at descriptor end: 00 00 00 00 00 00 00 00 00
       AudioControl Interface Descriptor:
         bLength                16
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                13
         bSourceID              12
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
         bmaControls( 1)      0x02
           Volume
         bmaControls( 2)      0x02
           Volume
         bmaControls( 3)      0x02
           Volume
         bmaControls( 4)      0x02
           Volume
         bmaControls( 5)      0x02
           Volume
         bmaControls( 6)      0x02
           Volume
         bmaControls( 7)      0x02
           Volume
         bmaControls( 8)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         bTerminalID             3
         wTerminalType      0x0301 Speaker
         bAssocTerminal          0
         bSourceID              13
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                13
         bDescriptorType        36
         bDescriptorSubtype      4 (MIXER_UNIT)
         bUnitID                17
         bNrInPins               2
         baSourceID( 0)          9
         baSourceID( 1)         11
         bNrChannels             2
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
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
       AudioControl Interface Descriptor:
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      5 (SELECTOR_UNIT)
         bUnitID                 7
         bNrInPins               4
         baSource( 0)            8
         baSource( 1)           15
         baSource( 2)           16
         baSource( 3)            2
         iSelector               0
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             6
         wTerminalType      0x0603 Line Connector
         bAssocTerminal          0
         bNrChannels             2
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                15
         bSourceID               6
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
         bmaControls( 1)      0x02
           Volume
         bmaControls( 2)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                11
         bSourceID               6
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
         bmaControls( 1)      0x02
           Volume
         bmaControls( 2)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             5
         wTerminalType      0x0605 SPDIF interface
         bAssocTerminal          0
         bNrChannels             2
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 2
         bSourceID              17
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
         bmaControls( 1)      0x02
           Volume
         bmaControls( 2)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                16
         bSourceID               5
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
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
       bNumEndpoints           1
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              0
       AudioStreaming Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (AS_GENERAL)
         bTerminalLink           1
         bDelay                  1 frames
         wFormatTag              1 PCM
       AudioStreaming Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             8
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            2 Discrete
         tSamFreq[ 0]        44100
         tSamFreq[ 1]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x06  EP 6 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
           Usage Type               Data
         wMaxPacketSize     0x0310  1x 784 bytes
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
         bTerminalLink           1
         bDelay                  1 frames
         wFormatTag              1 PCM
       AudioStreaming Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             2
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            2 Discrete
         tSamFreq[ 0]        44100
         tSamFreq[ 1]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x06  EP 6 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
           Usage Type               Data
         wMaxPacketSize     0x00c4  1x 196 bytes
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
       bAlternateSetting       3
       bNumEndpoints           1
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              0
       AudioStreaming Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (AS_GENERAL)
         bTerminalLink           1
         bDelay                  1 frames
         wFormatTag              1 PCM
       AudioStreaming Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             4
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            2 Discrete
         tSamFreq[ 0]        44100
         tSamFreq[ 1]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x06  EP 6 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
           Usage Type               Data
         wMaxPacketSize     0x0188  1x 392 bytes
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
       bAlternateSetting       4
       bNumEndpoints           1
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              0
       AudioStreaming Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (AS_GENERAL)
         bTerminalLink           1
         bDelay                  1 frames
         wFormatTag              1 PCM
       AudioStreaming Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             6
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            2 Discrete
         tSamFreq[ 0]        44100
         tSamFreq[ 1]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x06  EP 6 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
           Usage Type               Data
         wMaxPacketSize     0x0248  1x 584 bytes
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
       bAlternateSetting       5
       bNumEndpoints           1
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              0
       AudioStreaming Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (AS_GENERAL)
         bTerminalLink           1
         bDelay                  1 frames
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
         bEndpointAddress     0x06  EP 6 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
           Usage Type               Data
         wMaxPacketSize     0x0188  1x 392 bytes
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
         bDelay                  1 frames
         wFormatTag              1 PCM
       AudioStreaming Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             2
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            2 Discrete
         tSamFreq[ 0]        44100
         tSamFreq[ 1]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x85  EP 5 IN
         bmAttributes            5
           Transfer Type            Isochronous
           Synch Type               Asynchronous
           Usage Type               Data
         wMaxPacketSize     0x00c8  1x 200 bytes
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
       bInterfaceNumber        3
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
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
           wDescriptorLength      50
          Report Descriptors:
            ** UNAVAILABLE **
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0003  1x 3 bytes
         bInterval               1
Device Status:     0x0000
   (Bus Powered)

USB Sound Device         at usb-0000:00:1d.0-2, full speed : USB Audio

Playback:
   Status: Stop
   Interface 1
     Altset 1
     Format: 0x2
     Channels: 8
     Endpoint: 6 OUT (ADAPTIVE)
     Rates: 44100, 48000
   Interface 1
     Altset 2
     Format: 0x2
     Channels: 2
     Endpoint: 6 OUT (ADAPTIVE)
     Rates: 44100, 48000
   Interface 1
     Altset 3
     Format: 0x2
     Channels: 4
     Endpoint: 6 OUT (ADAPTIVE)
     Rates: 44100, 48000
   Interface 1
     Altset 4
     Format: 0x2
     Channels: 6
     Endpoint: 6 OUT (ADAPTIVE)
     Rates: 44100, 48000
   Interface 1
     Altset 5
     Format: 0x2
     Channels: 2
     Endpoint: 6 OUT (ADAPTIVE)
     Rates: 48000

Capture:
   Status: Stop
   Interface 2
     Altset 1
     Format: 0x2
     Channels: 2
     Endpoint: 5 IN (ASYNC)
     Rates: 44100, 48000



--------------ms000304030601050600060603
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJUTCC
AwMwggJsoAMCAQICEDGJsD9UPajwBl+GeyaBWA0wDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDkxNzEwMzAwM1oX
DTA4MDkxNjEwMzAwM1owajEQMA4GA1UEBBMHU2xhZ3RlcjEVMBMGA1UEKhMMRXJpayBNYXJ0
aWpuMR0wGwYDVQQDExRFcmlrIE1hcnRpam4gU2xhZ3RlcjEgMB4GCSqGSIb3DQEJARYRZXJp
a0BzbGFndGVyLm5hbWUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC4bkf+nXAx
akUjjwscSMjaKSUFQiJPxTgOUEh+uKVsBVGvY7CB8XcCmU7+oO1s9NaTL7BVy7Lwpj5SJV/B
v8gZWrHwsR3D7U2rcKUW81v7dkTu9GTAUt5Qc8b7+GehjZuZKZPjMdH6vJK9G7YnZu1gG9b0
CoEC4jOdIR4+4di2ZUN9M5JLlVKofOP4fo8MKFny88ThmxHLGzzQGsshfs7wuYB2hivouPCf
kmc+tnTI90mLrV748Yc6M9gq1brUajcy+tL0wdTS0NOJ2FVa/0HFlxaMrt88nko2J7wA+yPM
RY1L+ziU+Qr45JxoCE6pI/6lZNlMtHeYvdveQZs/3n5HAgMBAAGjLjAsMBwGA1UdEQQVMBOB
EWVyaWtAc2xhZ3Rlci5uYW1lMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAZrik
whMvx+aaj7gXQDVuy+zs7eqq1zJilrNS1130Hrq0JeLC6Rnl6a1gE52gap2O6uLyfpdGBmXu
loCzA9OPYKcZT6EtcZKF3+TCP0m9L3G1scQPPrxZt/oA4uZ4MDTvLElPJH2ONOvCoRPrp5aD
YHD5NlsDjs+kG6559873oTwwggMDMIICbKADAgECAhAxibA/VD2o8AZfhnsmgVgNMA0GCSqG
SIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAo
UHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QTAeFw0wNzA5MTcxMDMwMDNaFw0wODA5MTYxMDMwMDNaMGoxEDAOBgNVBAQTB1NsYWd0ZXIx
FTATBgNVBCoTDEVyaWsgTWFydGlqbjEdMBsGA1UEAxMURXJpayBNYXJ0aWpuIFNsYWd0ZXIx
IDAeBgkqhkiG9w0BCQEWEWVyaWtAc2xhZ3Rlci5uYW1lMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAuG5H/p1wMWpFI48LHEjI2iklBUIiT8U4DlBIfrilbAVRr2OwgfF3AplO
/qDtbPTWky+wVcuy8KY+UiVfwb/IGVqx8LEdw+1Nq3ClFvNb+3ZE7vRkwFLeUHPG+/hnoY2b
mSmT4zHR+rySvRu2J2btYBvW9AqBAuIznSEePuHYtmVDfTOSS5VSqHzj+H6PDChZ8vPE4ZsR
yxs80BrLIX7O8LmAdoYr6Ljwn5JnPrZ0yPdJi61e+PGHOjPYKtW61Go3MvrS9MHU0tDTidhV
Wv9BxZcWjK7fPJ5KNie8APsjzEWNS/s4lPkK+OScaAhOqSP+pWTZTLR3mL3b3kGbP95+RwID
AQABoy4wLDAcBgNVHREEFTATgRFlcmlrQHNsYWd0ZXIubmFtZTAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBQUAA4GBAGa4pMITL8fmmo+4F0A1bsvs7O3qqtcyYpazUtdd9B66tCXiwukZ
5emtYBOdoGqdjuri8n6XRgZl7paAswPTj2CnGU+hLXGShd/kwj9JvS9xtbHEDz68Wbf6AOLm
eDA07yxJTyR9jjTrwqET66eWg2Bw+TZbA47PpBuueffO96E8MIIDPzCCAqigAwIBAgIBDTAN
BgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UE
CxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBl
cnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYD
VQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2as
Zw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHT
HUb/XV9lTzGCA3EwggNtAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhAxibA/VD2o8AZfhnsmgVgNMAkGBSsOAwIaBQCgggHQMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDYwNTEzMTk1NlowIwYJKoZI
hvcNAQkEMRYEFF2x1rDklrpNZv6RMI63BqSNC9KtMF8GCSqGSIb3DQEJDzFSMFAwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUr
DgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYDVQQGEwJaQTEl
MCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3Rl
IFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDGJsD9UPajwBl+GeyaBWA0wgYcGCyqG
SIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRp
bmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vp
bmcgQ0ECEDGJsD9UPajwBl+GeyaBWA0wDQYJKoZIhvcNAQEBBQAEggEAK4KUak7G2hjbOyPh
qB+bkZQts0tsLwE9ZX44Z8UqJIDRhiJAkBnTXUTD139s96FXNlCGw+8rs23CPN1b/dPdR82N
VWbTQMfZweE12FRow04wk7S6bw8b9F505HIPZmYKatl4f0gDWRS3e7rPVyBDwXxZRx+ytEur
lLS7vFkZdfwh50Encert/1o7S6+7gyzTjDZe8NhIc2hH8xD1FGKrG0u564L4B33D3ISWMfn+
uppdfryUV41aXViZnpoDcgGjFxHNb76CFX5bdGbwoMD0MDs88VFIq+1wH/GLW9lU0PsJt9Xv
t62p56qobdo0LNlHuT2wKhgxBxJf5dM8oegUkwAAAAAAAA==
--------------ms000304030601050600060603--

--===============2767518458358400287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2767518458358400287==--

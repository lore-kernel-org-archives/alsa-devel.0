From: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb sound cannot get frequency from enpoind
Date: Fri, 12 Sep 2014 14:00:25 +0800
Message-ID: <CAOVJa8Gyd_hbAmrmeYY9RorhMQUK8QnM0r3ySqdNfC_xWK73ng@mail.gmail.com>
References: <CAOVJa8ECMNHi5a-iFsk39E9JfKrA+CykrTa7Fh6AdyfTFqo_SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c2eb5260dc550502d8006d
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOVJa8ECMNHi5a-iFsk39E9JfKrA+CykrTa7Fh6AdyfTFqo_SQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--001a11c2eb5260dc550502d8006d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi all:
I get the same message on kernel 3.16.0 and attach the device
information as well.
(from the description, the ep 0x82 did have different sample rate
configuration, but why uac cannot get it?)
appreciate your help,

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
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
        bTerminalLink           3
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                29
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            7 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        16000
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        24000
        tSamFreq[ 4]        32000
        tSamFreq[ 5]        44100
        tSamFreq[ 6]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0100  1x 256 bytes
        bInterval               4
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
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)

2014-09-12 13:46 GMT+08:00 vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> hi all:
> My kernel is 3.8.0.
> and when I plug in "microsoft LifeCam", I get message at the end of
> mail about cannot get min/max values from camera.
> is there any usb audio class initial sequence we need to check when
> this message pop out?
> Appreciate your help in advance,
>
>
>
> usb 3-1: new high-speed USB device number 2 using Platform-ehci
> Platform-ehci Platform-ehci.0: port 1 reset complete, port enabled
> Platform-ehci Platform-ehci.0: GetStatus port:1 status 00000d 0  ACK
> sig=3Dse0 PEC PE CONNECT
> usb 3-1: skipped 1 descriptor after configuration
> usb 3-1: skipped 6 descriptors after interface
> usb 3-1: skipped 1 descriptor after endpoint
> usb 3-1: skipped 28 descriptors after interface
> usb 3-1: skipped 1 descriptor after endpoint
> usb 3-1: skipped 4 descriptors after interface
> usb 3-1: skipped 2 descriptors after interface
> usb 3-1: skipped 1 descriptor after endpoint
> usb 3-1: default language 0x0409
> usb 3-1: udev 2, busnum 3, minor =3D 257
> usb 3-1: New USB device found, idVendor=3D045e, idProduct=3D075d
> usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> usb 3-1: Product: Microsoft=C3=82=C2=AE LifeCam Cinema(TM)
> usb 3-1: Manufacturer: Microsoft
> usb 3-1: usb_probe_device
> usb 3-1: configuration #1 chosen from 1 choice
> usb 3-1: adding 3-1:1.0 (config #1, interface 0)
> uvcvideo 3-1:1.0: usb_probe_interface
> uvcvideo 3-1:1.0: usb_probe_interface - got id
> uvcvideo: Found UVC 1.00 device Microsoft=C3=82=C2=AE LifeCam Cinema(TM) =
(045e:075d)
> input: Microsoft=C3=82=C2=AE LifeCam Cinema(TM) as
> /devices/platform/Platform-ehci.0/usb3/3-1/3-1:1.0/input/input4
> usb 3-1: adding 3-1:1.1 (config #1, interface 1)
> usb 3-1: adding 3-1:1.2 (config #1, interface 2)
> snd-usb-audio 3-1:1.2: usb_probe_interface
> snd-usb-audio 3-1:1.2: usb_probe_interface - got id
> ALSA sound/usb/stream.c:682 2:3:1: add audio endpoint 0x82
> usb 3-1: khubd timed out on ep0in len=3D0/3
> ALSA sound/usb/clock.c:237 2:3:1: cannot get freq at ep 0x82
> ALSA sound/usb/mixer.c:1305 [5] FU [Mic Capture Switch] ch =3D 1, val =3D=
 0/1/1
> ALSA sound/usb/mixer.c:929 5:2: cannot get min/max values for control 2 (=
id 5)
> ALSA sound/usb/mixer.c:1305 [5] FU [Mic Capture Volume] ch =3D 1, val =3D=
 0/1/1
> ALSA sound/usb/mixer.c:929 5:2: cannot get min/max values for control 2 (=
id 5)
> usb 3-1: adding 3-1:1.3 (config #1, interface 3)
> hub 3-0:1.0: state 7 ports 1 chg 0000 evt 0002
> Platform-ehci Platform-ehci.0: GetStatus port:1 status 00000d 0  ACK
> sig=3Dse0 PEC PE CONNECT
> hub 3-0:1.0: port 1 enable change, status 00000403

--001a11c2eb5260dc550502d8006d
Content-Type: application/x-bzip; name="microsoft.cam.tar.bz"
Content-Disposition: attachment; filename="microsoft.cam.tar.bz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzz45j8q0

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
--001a11c2eb5260dc550502d8006d--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

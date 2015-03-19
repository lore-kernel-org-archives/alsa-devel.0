From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_usb_audio - siberia elite prism soundcard
	issues
Date: Thu, 19 Mar 2015 13:05:17 +0800
Message-ID: <CAN8cciZjEtmS__52oRbda8ePnZTGO_ss65Nwr8qA1D+ip1d-qA@mail.gmail.com>
References: <CAHti5NHPMjxAtg_XLHD1kL4rUCAPaNGa_2ZAZwvv_Kc4u43uAw@mail.gmail.com>
 <54FC9CB0.2030003@ladisch.de>
 <CAHti5NEvVwsxdOnJdJErMCssu3_5ohaRsDC0WVCuhB0upLF_mQ@mail.gmail.com>
 <CAN8cciZcnD4zPbL-jD8+t5AHaugWvbrbo33_iuVBktHnpKpRuw@mail.gmail.com>
 <CAHti5NEfeguhQTZANNg=QnBZXRjDJZV0DAd3H1i+p4nCsmkQmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 06EC3260511
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 06:05:18 +0100 (CET)
Received: by obdfc2 with SMTP id fc2so46833315obd.3
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 22:05:17 -0700 (PDT)
In-Reply-To: <CAHti5NEfeguhQTZANNg=QnBZXRjDJZV0DAd3H1i+p4nCsmkQmQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel <dferradal@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

>> >
>> > > Daniel wrote:
>> > > > numid=1,iface=PCM,name='Capture Channel Map'
>> > > >   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
>> > > >   : values=0,0
>> > > >   |     | chmap-fixed=FL,FR
>> > > > numid=2,iface=PCM,name='Playback Channel Map'
>> > > >   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
>> > > >   : values=0,0
>> > > >   |     | chmap-fixed=FL,FR
>> > >
>> > > This device reports that it supports two channels.
>> > > What makes you think that you can play eight channels?
>> > >
>> > > > amixer: Control hw:2 element read error: Invalid argument
>> > > > usb 1-1.3: 10:0: cannot get min/max values for control 3 (id 10)
>> > > > usb 1-1.3: 2:1: cannot get freq at ep 0x1
>> > >
>> > > These are bugs in the device firmware.  However, the driver could
>> > > handle them better.
>> > >
>> > >
>> >
>> >
>> > Forgive my ignorance if I'm totally wrong, what made me think that is
7.1
>> > capable is:
>> >
>> > The headset is made to emulate 7.1 sound in headphones, that it does
>> > through the sound card it provides.
>> >
>> > Also the aplay output...
>> >
>> > aplay --dump-hw-params returns  CHANNELS: [2 8]
>> >
>> > and "aplay -L" output also reports:
>> > surround71:CARD=Elite,DEV=0
>> >     SteelSeries Siberia Elite, USB Audio
>> >     7.1 Surround output to Front, Center, Side, Rear and Woofer
speakers
>> >
>> >
>> > With the manufacturer driver under other OS's you do select 7.1 setup
and
>> > then you plug the specific headphones to the soundcard and can hear the
>> > surround sound, but I don't mean to compare though, just that it also
made
>> > me believe this hardware supports 7.1
>> >
>> >
>> numid=11,iface=MIXER,name='Speaker Playback Volume' ;
type=INTEGER,access=rw---R--,values=8,min=0,max=74,step=0 :
values=54,54,54,54,54,54,54,54 | dBminmax-min=-74.00dB,max=0.00dB
>>
>> You need workaround since pulseaudio don't like volume control with more
than two channels
>>
>> https://bugs.freedesktop.org/show_bug.cgi?id=84983#c35
>>
>> Can you post output of your usb audio device ?
>>
>> lsusb -vvvv
>
>
>
> Certainly!
>
> Here it is:
>
> Bus 001 Device 003: ID 1038:1225 Ideazon, Inc.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x1038 Ideazon, Inc.
>   idProduct          0x1225
>   bcdDevice            0.03
>   iManufacturer           1 SteelSeries
>   iProduct                2 SteelSeries Siberia Elite
>   iSerial                 3 000000000000
>   bNumConfigurations      1

>
>       AudioControl Interface Descriptor:
>         bLength                13
>         bDescriptorType        36
>         bDescriptorSubtype      4 (MIXER_UNIT)
>       Warning: Descriptor too short

https://github.com/gregkh/usbutils/blob/master/lsusb.c

Seem no warning for descriptor too short for uac2 and can dump those uac2
specific variables

>         bUnitID                10
>         bNrInPins               2
>         baSourceID( 0)          9
>         baSourceID( 1)          1
>         bNrChannels             8
>         wChannelConfig     0x063f
>           Left Front (L)
>           Right Front (R)
>           Center Front (C)
>           Low Freqency Enhancement (LFE)
>           Left Surround (LS)
>           Right Surround (RS)
>           Side Left (SL)
>           Side Right (SR)
>         iChannelNames           0
>         bmControls         0x00
>         bmControls         0x00
>         iMixer                 33 (error)
>

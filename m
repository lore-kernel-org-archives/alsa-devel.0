From: Daniel <dferradal@gmail.com>
Subject: Re: snd_usb_audio - siberia elite prism soundcard
	issues
Date: Fri, 27 Mar 2015 19:55:04 +0100
Message-ID: <CAHti5NE_rD4yporMJfoCt78dkorRQzPWWHsFb7cECHDg81_nBg@mail.gmail.com>
References: <CAHti5NHPMjxAtg_XLHD1kL4rUCAPaNGa_2ZAZwvv_Kc4u43uAw@mail.gmail.com>
 <54FC9CB0.2030003@ladisch.de>
 <CAHti5NEvVwsxdOnJdJErMCssu3_5ohaRsDC0WVCuhB0upLF_mQ@mail.gmail.com>
 <CAN8cciZcnD4zPbL-jD8+t5AHaugWvbrbo33_iuVBktHnpKpRuw@mail.gmail.com>
 <CAHti5NEfeguhQTZANNg=QnBZXRjDJZV0DAd3H1i+p4nCsmkQmQ@mail.gmail.com>
 <CAN8cciZjEtmS__52oRbda8ePnZTGO_ss65Nwr8qA1D+ip1d-qA@mail.gmail.com>
 <CAHti5NEOnozoTDCKgzNsUEE4Yxd-VURXx_mH2vy4rq1dB51ySA@mail.gmail.com>
 <CAN8cciYtRPRwXNS=c9qotvEkAcstiV739EHFNNun-PLY3AvEVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F1542604A6
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 19:55:25 +0100 (CET)
Received: by wgra20 with SMTP id a20so108638698wgr.3
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 11:55:24 -0700 (PDT)
In-Reply-To: <CAN8cciYtRPRwXNS=c9qotvEkAcstiV739EHFNNun-PLY3AvEVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2015-03-24 2:35 GMT+01:00 Raymond Yau <superquad.vortex2@gmail.com>:

>
> >> >> >
> >> >> >
> >> >> numid=11,iface=MIXER,name='Speaker Playback Volume' ;
> type=INTEGER,access=rw---R--,values=8,min=0,max=74,step=0 :
> values=54,54,54,54,54,54,54,54 | dBminmax-min=-74.00dB,max=0.00dB
> >> >>
> >> >> You need workaround since pulseaudio don't like volume control with
> more than two channels
> >> >>
> >> >> https://bugs.freedesktop.org/show_bug.cgi?id=84983#c35
> >> >>
> >> >> Can you post output of your usb audio device ?
> >> >>
> >> >> lsusb -vvvv
> >> >
> >> >
> >> >
> >> > Certainly!
> >> >
> >> > Here it is:
> >> >
> >> > Bus 001 Device 003: ID 1038:1225 Ideazon, Inc.
> >> > Device Descriptor:
> >> >   bLength                18
> >> >   bDescriptorType         1
> >> >   bcdUSB               2.00
> >> >   bDeviceClass            0 (Defined at Interface level)
> >> >   bDeviceSubClass         0
> >> >   bDeviceProtocol         0
> >> >   bMaxPacketSize0        64
> >> >   idVendor           0x1038 Ideazon, Inc.
> >> >   idProduct          0x1225
> >> >   bcdDevice            0.03
> >> >   iManufacturer           1 SteelSeries
> >> >   iProduct                2 SteelSeries Siberia Elite
> >> >   iSerial                 3 000000000000
> >> >   bNumConfigurations      1
> >>
> >> >
> >> >       AudioControl Interface Descriptor:
> >> >         bLength                13
> >> >         bDescriptorType        36
> >> >         bDescriptorSubtype      4 (MIXER_UNIT)
> >> >       Warning: Descriptor too short
> >>
> >> https://github.com/gregkh/usbutils/blob/master/lsusb.c
> >>
> >> Seem no warning for descriptor too short for uac2 and can dump those
> uac2 specific variables
> >>
> >> >         bUnitID                10
> >> >         bNrInPins               2
> >> >         baSourceID( 0)          9
> >> >         baSourceID( 1)          1
> >> >         bNrChannels             8
> >> >         wChannelConfig     0x063f
> >> >           Left Front (L)
> >> >           Right Front (R)
> >> >           Center Front (C)
> >> >           Low Freqency Enhancement (LFE)
> >> >           Left Surround (LS)
> >> >           Right Surround (RS)
> >> >           Side Left (SL)
> >> >           Side Right (SR)
> >> >         iChannelNames           0
> >> >         bmControls         0x00
> >> >         bmControls         0x00
> >> >         iMixer                 33 (error)
> >> >
> >
> >
> > Maybe it's the language barrier, but I am not sure if you wanted me to
> do something. I, out of curiosity, tried to compile that lsusb but I'm
> missing headers such as config.h.
> >
> > Should you need any more feedback from me about this device, please do
> not hesitate asking through mailing list or directly, just consider I'm not
> dev! :)
> >
>
> Do you mean there is no sound using alsa hw device since pulseaudio does
> not support the multichannel speaker playback volume comtrol ?
>
> speaker-test -c8 -t wav -D hw:CARD=Elite
>
> speaker-test -c2 -t wav -D hw:CARD=Elite
>
> You need to know how to compile alsa driver for you running kernel if you
> want to fix the problem
>
> >> >> > > > amixer: Control hw:2 element read error: Invalid argument
>
> If alsamixer or amixer cannot set the speaker playback volume
>
> Try skip the problematic PCM Volume controls by adding
>
> if (state->chip->usb_id == USB_ID(0x1038,0x1225))
> if(unitid == 10)
> ich_has_control = 0;
>
> If the driver really need this mixer unit for the playback path, you need
> to fix those controls
>
> bUnitID 10
> bNrInPins 2
> baSourceID( 0) 9             microphone
> baSourceID( 1) 1             usb streaming
>
> This look like the first four problematic controls related to microphone
> and the last control related to streaming
>
> numid=5,iface=MIXER,name='PCM Volume' ;
> type=INTEGER,access=rw------,values=2,min=0,max=1,step=0 amixer: Control
> hw:2 element read error: Invalid argument
>
> numid=6,iface=MIXER,name='PCM Volume',index=1 ;
> type=INTEGER,access=rw------,values=1,min=0,max=1,step=0 amixer: Control
> hw:2 element read error: Invalid argument
>
> numid=7,iface=MIXER,name='PCM Volume',index=2 ;
> type=INTEGER,access=rw------,values=1,min=0,max=1,step=0 amixer: Control
> hw:2 element read error: Invalid argument
>
> numid=8,iface=MIXER,name='PCM Volume',index=3 ;
> type=INTEGER,access=rw------,values=1,min=0,max=1,step=0 amixer: Control
> hw:2 element read error: Invalid argument
>
> numid=9,iface=MIXER,name='PCM Volume',index=4 ;
> type=INTEGER,access=rw------,values=1,min=0,max=1,step=0 amixer: Control
> hw:2 element read error: Invalid argument
>

Hello,

when I run the tests:

speaker-test -c8 -t wav -D hw:CARD=Elite

speaker-test -c2 -t wav -D hw:CARD=Elite

I only get sound from front left and front right channels.


About compiling the alsa driver in my running kernel or where to place the
code you mention, well, as much as I have tried, my lack of experience has
resulted in failing, although I'm still trying...


I have tried with latest kernel 3.18.10, and kernel 4.0-rc5.


Maybe I'm asking too much, can you provide a mixer.c or all the files I
need to substitude in any kernel version you decide?, I'll just download
the source for that kernel and merge with the file/s you attach and compile
the whole thing, of that I'm sure I can do.

If it's too much I'm asking , don't worry, I'm still trying.

-- 
*Daniel Ferradal*

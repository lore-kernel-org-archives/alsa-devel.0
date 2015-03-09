From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_usb_audio - siberia elite prism soundcard
	issues
Date: Mon, 9 Mar 2015 12:11:07 +0800
Message-ID: <CAN8cciZcnD4zPbL-jD8+t5AHaugWvbrbo33_iuVBktHnpKpRuw@mail.gmail.com>
References: <CAHti5NHPMjxAtg_XLHD1kL4rUCAPaNGa_2ZAZwvv_Kc4u43uAw@mail.gmail.com>
 <54FC9CB0.2030003@ladisch.de>
 <CAHti5NEvVwsxdOnJdJErMCssu3_5ohaRsDC0WVCuhB0upLF_mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CBE4260566
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 05:11:11 +0100 (CET)
Received: by oiav63 with SMTP id v63so27124716oia.8
 for <alsa-devel@alsa-project.org>; Sun, 08 Mar 2015 21:11:08 -0700 (PDT)
In-Reply-To: <CAHti5NEvVwsxdOnJdJErMCssu3_5ohaRsDC0WVCuhB0upLF_mQ@mail.gmail.com>
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

>
> > Daniel wrote:
> > > numid=1,iface=PCM,name='Capture Channel Map'
> > >   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
> > >   : values=0,0
> > >   |     | chmap-fixed=FL,FR
> > > numid=2,iface=PCM,name='Playback Channel Map'
> > >   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
> > >   : values=0,0
> > >   |     | chmap-fixed=FL,FR
> >
> > This device reports that it supports two channels.
> > What makes you think that you can play eight channels?
> >
> > > amixer: Control hw:2 element read error: Invalid argument
> > > usb 1-1.3: 10:0: cannot get min/max values for control 3 (id 10)
> > > usb 1-1.3: 2:1: cannot get freq at ep 0x1
> >
> > These are bugs in the device firmware.  However, the driver could
> > handle them better.
> >
> >
>
>
> Forgive my ignorance if I'm totally wrong, what made me think that is 7.1
> capable is:
>
> The headset is made to emulate 7.1 sound in headphones, that it does
> through the sound card it provides.
>
> Also the aplay output...
>
> aplay --dump-hw-params returns  CHANNELS: [2 8]
>
> and "aplay -L" output also reports:
> surround71:CARD=Elite,DEV=0
>     SteelSeries Siberia Elite, USB Audio
>     7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
>
>
> With the manufacturer driver under other OS's you do select 7.1 setup and
> then you plug the specific headphones to the soundcard and can hear the
> surround sound, but I don't mean to compare though, just that it also made
> me believe this hardware supports 7.1
>
>
numid=11,iface=MIXER,name='Speaker Playback Volume' ;
type=INTEGER,access=rw---R--,values=8,min=0,max=74,step=0 :
values=54,54,54,54,54,54,54,54 | dBminmax-min=-74.00dB,max=0.00dB

You need workaround since pulseaudio don't like volume control with more
than two channels

https://bugs.freedesktop.org/show_bug.cgi?id=84983#c35

Can you post output of your usb audio device ?

lsusb -vvvv

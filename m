From: Daniel <dferradal@gmail.com>
Subject: Re: snd_usb_audio - siberia elite prism soundcard
	issues
Date: Sun, 8 Mar 2015 20:28:02 +0100
Message-ID: <CAHti5NEvVwsxdOnJdJErMCssu3_5ohaRsDC0WVCuhB0upLF_mQ@mail.gmail.com>
References: <CAHti5NHPMjxAtg_XLHD1kL4rUCAPaNGa_2ZAZwvv_Kc4u43uAw@mail.gmail.com>
 <54FC9CB0.2030003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com
 [209.85.215.52])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C942604FC
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 20:33:40 +0100 (CET)
Received: by labgq15 with SMTP id gq15so12981283lab.11
 for <alsa-devel@alsa-project.org>; Sun, 08 Mar 2015 12:33:40 -0700 (PDT)
In-Reply-To: <54FC9CB0.2030003@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2015-03-08 20:02 GMT+01:00 Clemens Ladisch <clemens@ladisch.de>:

> Daniel wrote:
> > numid=1,iface=PCM,name='Capture Channel Map'
> >   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
> >   : values=0,0
> >   |     | chmap-fixed=FL,FR
> > numid=2,iface=PCM,name='Playback Channel Map'
> >   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
> >   : values=0,0
> >   |     | chmap-fixed=FL,FR
>
> This device reports that it supports two channels.
> What makes you think that you can play eight channels?
>
> > amixer: Control hw:2 element read error: Invalid argument
> > usb 1-1.3: 10:0: cannot get min/max values for control 3 (id 10)
> > usb 1-1.3: 2:1: cannot get freq at ep 0x1
>
> These are bugs in the device firmware.  However, the driver could
> handle them better.
>
>
> Regards,
> Clemens
>


Hello,

Forgive my ignorance if I'm totally wrong, what made me think that is 7.1
capable is:

The headset is made to emulate 7.1 sound in headphones, that it does
through the sound card it provides.

Also the aplay output...

aplay --dump-hw-params returns  CHANNELS: [2 8]

and "aplay -L" output also reports:
surround71:CARD=Elite,DEV=0
    SteelSeries Siberia Elite, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers


With the manufacturer driver under other OS's you do select 7.1 setup and
then you plug the specific headphones to the soundcard and can hear the
surround sound, but I don't mean to compare though, just that it also made
me believe this hardware supports 7.1


Thanks for your time.

-- 
*Daniel Ferradal*

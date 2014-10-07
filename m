From: Anthony Labunsky <gdigger@gmail.com>
Subject: Re: [PATCH 00/14] ALSA: Dice enhancement
Date: Tue, 7 Oct 2014 23:39:24 +0400
Message-ID: <CAEG-yBxE9zEceztNTJ+tDPjO9YUvpg+mgLsAzaN5v1LVd3GmYg@mail.gmail.com>
References: <1412422044-15133-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h8ukrlp2o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id B2BA82606B3
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 21:39:25 +0200 (CEST)
Received: by mail-vc0-f176.google.com with SMTP id hq11so5343576vcb.21
 for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2014 12:39:24 -0700 (PDT)
In-Reply-To: <s5h8ukrlp2o.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am using TC Electronic's Desktop Konnekt 6 with snd_dice for a few days
-- no problems with playback ;)
Gentoo x86_64, linux 3.14.14.

On Tue, Oct 7, 2014 at 10:19 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sat,  4 Oct 2014 20:27:10 +0900,
> Takashi Sakamoto wrote:
> >
> > This 14 patchset is to enable ALSA Dice driver to handle more models with
> > some functionalities:
> >  - up to 192.0 kHz
> >  - PCM capture
> >  - MIDI playback/capture
> >  - Duplex streams with synchronization (with snd-firewire-lib)
> >
> > This driver doesn't support:
> >  - Synchronization between multiple devices on the same bus
> >    For this purpose, please join in user-space driver project (FFADO)
> >  - Any control functionality for internal DSP
> >    For this purpose, please use ffado-dbus-server/ffado-mixer,
> >    or write your own application
> >
> > Remarks:
> >  - When this driver is loaded, user-space driver fails to register
> >    notification address, thus cannot handle device for streaming. See:
> >
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081731.html
> >
> > Newly supported models (as long as I know):
> > Supported devices:
> > TC Electronic
> >       Desktop Konnekt 6
> >       Impact Twin
> >       Konnekt 8/24D/Live
> >       Studio Konnekt 48
> > PreSonus
> >       FireStudio 26x26/Mobile/Project/Tube/LightPipe
> >       StudioLive 1602/1642/2442
> >       FireStation
> > Mackie
> >       Onyx Blackbird
> >       Onyx i-series (latter models)
> > Focusrite
> >       Saffire Pro 14/24/24 DSP/26/40/56
> > M-Audio
> >       Profire 610/2626
> > Alessis
> >       IO 24/26
> >       MultiMix 12/16
> > Weiss
> >       ADC2
> >       Vesta
> >       Mineva
> >       AFI 1
> >       TAG DAC 1
> >       INT 202
> >       DAC 202
> >       Flex 5000
> > DnR
> >       Axus FireWire I/O card 16x16
> > Lexicon
> >       I-ONIX FW 810S
> > Allen and Heath
> >       Zed R16
> > Midas
> >       Venice F32
> >
> > Updates from my previous RFC:
> >
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081673.html
> >  - Improve bus reset handling, especially for registering notification
> address
> >    At bus reset, Dice devices initialize a register for notification
> address,
> >    then drivers need to register the address again.
> >    Just after powering on, devices generates any bus reset, then drivers
> often
> >    fail to detect stream formation because this operation requires to
> change
> >    sampling rate.
> >    My improvement is retries to register notification address when
> notification
> >    wait is timed out.
> >  - Remove experimental state
> >  - Fix minor bugs
>
> JFYI,
>
> as the patches are massive and a bit intrusive, they won't fit with
> 3.18 merge, unfortunately.  So we'll plenty of time for review :)
>
>
> thanks,
>
> Takashi -- "There can be only one!"
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
-- gdigger

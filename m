From: Gilles Hemberg <gilles.hemberg@gmail.com>
Subject: Re: [bug] SPDIF (digital-out) not working on
	NForce4/CK804
Date: Fri, 03 Oct 2014 23:02:54 +0200
Message-ID: <542F0EFE.6020303@gmail.com>
References: <542D95C8.8060701@gmail.com>
 <CAN8cciYnAm6ivNk_FG6WbWAicskXQ9E2Pi+LLAb2jLSSwuJC+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 3218D2604CB
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 23:02:59 +0200 (CEST)
Received: by mail-wg0-f42.google.com with SMTP id z12so2430472wgg.13
 for <alsa-devel@alsa-project.org>; Fri, 03 Oct 2014 14:02:58 -0700 (PDT)
In-Reply-To: <CAN8cciYnAm6ivNk_FG6WbWAicskXQ9E2Pi+LLAb2jLSSwuJC+Q@mail.gmail.com>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Command tried:

     speaker-test -c2 -r 48000 -D iec958:CARD=CK804,DEV=0

Still no sound coming through AVR...

For the sake of completeness, I provide a new alsa-info.sh output: 
http://sprunge.us/ZWLF (I blacklisted the snd_hda_intel this time just 
to be on the safe side).

The git-link below ( 
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/NFORCE.conf;hb=HEAD 
) seems to point to the .conf for nForce2/3; min is a nForce4 (don't 
know if nForce4 is supposed to use this same .conf).

THNX already,
Bye!
_____
*Gilles Hemberg*
/gilles.hemberg@gmail.com/



On 03/10/2014 09:31, Raymond Yau wrote:>
>
> > Sorry to bump in like this, but I was advised to submit a bug-report 
> for the ALSA-drivers on my HTPC: no sound comes through out of my AVR 
> when I select the digital output through SPDIF (TOSLINK).
> >
> > The relevant parts of my HTPC are as follows:
> >     * CPU: Athlon64 X2 3800+
> >     * Motherboard: ASUS A8N-SLI Deluxe motherboard (BIOS 1805) 
> NForce4 with CK804 sound (relying on a Realtek ALC850 chip)
>
> >     * RAM: 2x 512 MB DDR-400
> >     * GPU: nVidia Geforce GT240 (which carries a HDMI port and uses 
> the snd-
> >     * Receiver: Marantz SR7500 (supporting both Dolby Digital 5.1 
> and DTS decoding), connected to motherboard's SPDIF TOSLINK port 
> (optical) + JBL 5.1 speaker-set
> >     * OpenElec 4.2.0: Kernel 3.16.3, Alsa 1.0.28
> >
> >
> > Symptoms:
> > Speaker-test does not produce any sound. Command used is as follows:
> >
> >     speaker-test -c2 -r 48000 -D hw:0,2
> >
> > No sound either from other applications (such as XBMC 13.2).
> >
> > SPDIF worked flawlessly on the exact same hardware & connections 
> using Win7/XBMC.
> > Sound does come through the SPDIF when I use hw:0,0 (= analog device).
> >
> >
> > Things tried (none working):
> >     * Blacklisting snd-hda-intel (= HDMI from my GPU) to make sure 
> CK804 is the only sound chip visible.
> >
> >     * amixer set 'IEC958 Playback AC97-SPSA' Playback 100% unmute
>

> http://www.realtek.com.tw/products/productsView.aspx?Langid=1&PFid=31&Level=5&Conn=4&ProdID=59
>
> Take a look at alc850 datasheet
>
> Simple mixer control 'IEC958 Playback AC97-SPSA',0
>   Capabilities: volume volume-joined
>   Playback channels: Mono
>   Capture channels: Mono
>   Limits: 0 - 3
>   Mono: 0 [0%]
>
> This is not volume control, it is SPDIF out Slot Assignment in ac97 link
>
> You have to use iec958:CARD=CK804
>
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/NFORCE.conf;hb=HEAD
>
> Simple mixer control 'IEC958 Playback Source',0
>   Capabilities: enum
>   Items: 'PCM' 'Analog In' 'IEC958 In
>   Item0: 'PCM'
>
>

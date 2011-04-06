From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC Patch] ALSA - EMU10K1 - Remove Center LFE
 Wave Center and Wave LFE control for SB Live! Platinum
Date: Wed, 6 Apr 2011 10:15:21 +0800
Message-ID: <BANLkTike6axtNw1YD9vv7f9jZGHtui9Kuw@mail.gmail.com>
References: <AANLkTikxq8K=91jGGqKsmb=0A8tELF_d_wH7O05sjwRr@mail.gmail.com>
	<s5hbp0mtgwk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id C76C8243EA
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 04:15:21 +0200 (CEST)
Received: by fxm5 with SMTP id 5so775490fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Apr 2011 19:15:21 -0700 (PDT)
In-Reply-To: <s5hbp0mtgwk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/4 Takashi Iwai <tiwai@suse.de>

> At Wed, 30 Mar 2011 20:50:51 +0800,
> Raymond Yau wrote:
> >
> > SB Live! Platinum CT4760P is just a 4 channels sound card with STAC9721
> and
> > Philips UDA1334 DAC
> >
> > Is it feasible to remove "Center" , "LFE", "Wave Cetner" and "Wave LFE"
> > Playback Volume control ?
> >
> > or add a bitmap to disable the creation of those controls
> >
> > Anyone know whether this patch has any side effect for the user with
>  Live
> > Drive
>
> The side-effect is that opening surround51 would spew annoying error
> messages as you've seen.  It should return an error without much
> complaint.
>
> I'm not sure what is the best way to solve it.
> Defining another conf such as EMU10K1-4ch.conf would be an option,
> but it's not elegant...
>
>
> thanks,
>
> Takashi
>
> > AFAIK, speaker-test will fail
> >
> > speaker-test -d -c 6 -t wav -Dsurround51:1
> >
> > speaker-test 1.0.24.2
> >
> > Playback device is surround51:1
> > Stream parameters are 48000Hz, S16_LE, 6 channels
> > WAV file(s)
> > ALSA lib setup.c:565:(add_elem) Cannot obtain info for CTL elem
> > (MIXER,'Headphone Center Playback Switch',1,0,0): No such file or
> directory
> > Playback open error: -2,No such file or directory
>


The point is those 4.1 speakers for SB Live!, SB Live! Platinum and SB Live!
Value only have green jack and blue jack,  the signal of the Subwoofer is
produced from the those jacks

it seem that the device "surround41" is only for SB Live! 5.1 in alsa

    slave.channels 6
    ttable.0.0 1
    ttable.1.1 1
    ttable.2.2 1
    ttable.3.3 1
    ttable.4.5 1
    hint {
        description "4.1 Surround output to Front, Rear and Subwoofer
speakers"
        device $DEV
    }


front:CARD=Live,DEV=0
    SB Live! Platinum [CT4760P], ADC Capture/Standard PCM Playback
    Front speakers
rear:CARD=Live,DEV=0
    SB Live! Platinum [CT4760P], ADC Capture/Standard PCM Playback
    Rear speakers
center_lfe:CARD=Live,DEV=0
    SB Live! Platinum [CT4760P], ADC Capture/Standard PCM Playback
    Center and Subwoofer speakers
surround40:CARD=Live,DEV=0
    SB Live! Platinum [CT4760P], ADC Capture/Standard PCM Playback
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Live,DEV=0
    SB Live! Platinum [CT4760P], ADC Capture/Standard PCM Playback
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Live,DEV=0
    SB Live! Platinum [CT4760P], ADC Capture/Standard PCM Playback
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Live,DEV=0
    SB Live! Platinum [CT4760P], ADC Capture/Standard PCM Playback
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers

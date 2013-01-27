From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
	capture
Date: Sun, 27 Jan 2013 16:49:58 +0100
Message-ID: <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f195.google.com (mail-wi0-f195.google.com
 [209.85.212.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 02311264F23
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2013 16:49:58 +0100 (CET)
Received: by mail-wi0-f195.google.com with SMTP id hj6so437923wib.2
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2013 07:49:58 -0800 (PST)
In-Reply-To: <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

in ap192_ak4114_init() of revo.c I see this:

----
    static const unsigned char ak4114_init_vals[] = {
        AK4114_RST | AK4114_PWN | AK4114_OCKS0 | AK4114_OCKS1,
        AK4114_DIF_I24I2S,
        AK4114_TX1E,
        AK4114_EFH_1024 | AK4114_DIT | AK4114_IPS(1),
        0,
        0
    };
    static const unsigned char ak4114_init_txcsb[] = {
        0x41, 0x02, 0x2c, 0x00, 0x00
    };
----

Something wrong here maybe?

I noticed that the ak4114_init_vals array has 6 values but in
ap192_ak4114_init() 7 values get written to ak4114.regmap.

@Pavel, btw. I also have an ESI Juli@. Spdif capture with this one does not
work at all (as compared to "kind of working" with the Audiophile 192).

- Jonas



2013/1/26 Pavel Hofman <pavel.hofman@ivitera.com>

> > Date 26.1.2013 17:35, Jonas Petersen wrote:
> >> Hi there,
> >>
> >> I'm trying to get spdif capture to work properly on the M-Audio
> >> Audiophile
> >> 192 (VT1724/Envy24HT). It is generally working, but I don't get a clean
> >> signal.
> >>
> >> I have "Multi Track Internal Clock" set to "IEC958 In" (spdif in). When
> >> I
> >> capture via Jack, arecord or Audacity I experience the following two
> >> phenomenons (always):
> >>
> >> 1.) The captured signal ends up 6 dB(FS) to loud (200%)! Everything
> >> above
> >> -6 dB is distorting. A 1 kHz sine test signal at -12 dB (25%) will be
> >> captured as -6 dB (50%).
> >>
> >> 2.) The left and right channels are shifted by one sample! When I feed a
> >> 1
> >> kHz test signal (L+R are _exactly_ the same signal), the right channel
> >> will
> >> be offset by exactly one sample. Zooming into the waveform clearly shows
> >> that. Analyzing the signal with a goniometer shows a (slight but
> >> obvious)
> >> vertical eliptical shape and not the expected single vertical line.
> >>
> >> To make sure the hardware actually works fine, I did install a Windows 7
> >> on
> >> the exact same machine, installed the drivers from M-Audio and did some
> >> recording with audacity. The result is as expected: the -12 dB signal
> >> ends
> >> up as -12 dB and the left and right channel exactly match each other. So
> >> the hardware is willing.
> >>
> >> I am running a Lubuntu 12.10 and I'm am able to compile and run the
> >> current
> >> alsa-driver source with the 3.5.0-22 kernel. I played around a bit with
> >> the
> >> alsa driver source (e.g. pci/ice1712/ice1724.c, pci/ice1712/revo.c) and
> >> I
> >> am able to compile and load a modified driver. So far I only was able to
> >> make the problem worse though.
> >>
> >> I'd now like to ask for some advice on how to approach the problem. I
> >> guess
> >> the fact that the left and right channel differ - even though they
> >> shouldn't - might be a thing to look for. This must be happening at some
> >> stage in the capturing. Is there a way to hook in at different places to
> >> narrow down what causes this?
> >>
> >> Maybe this even already rings somebody's bells?
> >>
> >> I'll be glad to deliver more information when needed.
> >
> > I believe that there must be a S/PDIF receiver IC somewhere on the board
> > and this IC may be wrongly configured.
>
> http://www.nix.ru/autocatalog/m_audio_midiman_sound/34397_2245_draft.jpg
> reveals it is AK4114, just like in ESI Juli. Its default serial data
> protocol  is not 24bit I2S, the format expected by ICE1724.
>
> It should be feasible to trace the GPIOs from ICE1724 to AK4114 and add
> the config code.
>
> Regards,
>
> Pavel.
>
>

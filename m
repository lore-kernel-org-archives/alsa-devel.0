From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Sat, 26 Jan 2013 20:30:45 +0100
Message-ID: <51042EE5.5070900@perex.cz>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id E6AED26168B
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 20:30:45 +0100 (CET)
In-Reply-To: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
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
Cc: Jonas Petersen <jnsptrsn1@gmail.com>
List-Id: alsa-devel@alsa-project.org

Date 26.1.2013 17:35, Jonas Petersen wrote:
> Hi there,
> 
> I'm trying to get spdif capture to work properly on the M-Audio Audiophile
> 192 (VT1724/Envy24HT). It is generally working, but I don't get a clean
> signal.
> 
> I have "Multi Track Internal Clock" set to "IEC958 In" (spdif in). When I
> capture via Jack, arecord or Audacity I experience the following two
> phenomenons (always):
> 
> 1.) The captured signal ends up 6 dB(FS) to loud (200%)! Everything above
> -6 dB is distorting. A 1 kHz sine test signal at -12 dB (25%) will be
> captured as -6 dB (50%).
> 
> 2.) The left and right channels are shifted by one sample! When I feed a 1
> kHz test signal (L+R are _exactly_ the same signal), the right channel will
> be offset by exactly one sample. Zooming into the waveform clearly shows
> that. Analyzing the signal with a goniometer shows a (slight but obvious)
> vertical eliptical shape and not the expected single vertical line.
> 
> To make sure the hardware actually works fine, I did install a Windows 7 on
> the exact same machine, installed the drivers from M-Audio and did some
> recording with audacity. The result is as expected: the -12 dB signal ends
> up as -12 dB and the left and right channel exactly match each other. So
> the hardware is willing.
> 
> I am running a Lubuntu 12.10 and I'm am able to compile and run the current
> alsa-driver source with the 3.5.0-22 kernel. I played around a bit with the
> alsa driver source (e.g. pci/ice1712/ice1724.c, pci/ice1712/revo.c) and I
> am able to compile and load a modified driver. So far I only was able to
> make the problem worse though.
> 
> I'd now like to ask for some advice on how to approach the problem. I guess
> the fact that the left and right channel differ - even though they
> shouldn't - might be a thing to look for. This must be happening at some
> stage in the capturing. Is there a way to hook in at different places to
> narrow down what causes this?
> 
> Maybe this even already rings somebody's bells?
> 
> I'll be glad to deliver more information when needed.

I believe that there must be a S/PDIF receiver IC somewhere on the board
and this IC may be wrongly configured. This IC is not handled in the
current ALSA driver at all. Could you look to your board and check the
used chips? From pictures on internet, a suspicious IC is in the middle
of top on this PCI card. The AKM IC's are for analog audio outputs.

The ICE1724 chip has only serial SPDIF input and SPDIF input clock pins.
The input samples should be copied to the DMA without any modifications
(no volume control etc.).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.

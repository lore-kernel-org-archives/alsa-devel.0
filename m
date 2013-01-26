From: "Pavel Hofman" <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Sat, 26 Jan 2013 22:20:52 +0100
Message-ID: <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D74726260B
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 22:20:53 +0100 (CET)
In-Reply-To: <51042EE5.5070900@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Jonas Petersen <jnsptrsn1@gmail.com>
List-Id: alsa-devel@alsa-project.org

> Date 26.1.2013 17:35, Jonas Petersen wrote:
>> Hi there,
>>
>> I'm trying to get spdif capture to work properly on the M-Audio
>> Audiophile
>> 192 (VT1724/Envy24HT). It is generally working, but I don't get a clean
>> signal.
>>
>> I have "Multi Track Internal Clock" set to "IEC958 In" (spdif in). When
>> I
>> capture via Jack, arecord or Audacity I experience the following two
>> phenomenons (always):
>>
>> 1.) The captured signal ends up 6 dB(FS) to loud (200%)! Everything
>> above
>> -6 dB is distorting. A 1 kHz sine test signal at -12 dB (25%) will be
>> captured as -6 dB (50%).
>>
>> 2.) The left and right channels are shifted by one sample! When I feed a
>> 1
>> kHz test signal (L+R are _exactly_ the same signal), the right channel
>> will
>> be offset by exactly one sample. Zooming into the waveform clearly shows
>> that. Analyzing the signal with a goniometer shows a (slight but
>> obvious)
>> vertical eliptical shape and not the expected single vertical line.
>>
>> To make sure the hardware actually works fine, I did install a Windows 7
>> on
>> the exact same machine, installed the drivers from M-Audio and did some
>> recording with audacity. The result is as expected: the -12 dB signal
>> ends
>> up as -12 dB and the left and right channel exactly match each other. So
>> the hardware is willing.
>>
>> I am running a Lubuntu 12.10 and I'm am able to compile and run the
>> current
>> alsa-driver source with the 3.5.0-22 kernel. I played around a bit with
>> the
>> alsa driver source (e.g. pci/ice1712/ice1724.c, pci/ice1712/revo.c) and
>> I
>> am able to compile and load a modified driver. So far I only was able to
>> make the problem worse though.
>>
>> I'd now like to ask for some advice on how to approach the problem. I
>> guess
>> the fact that the left and right channel differ - even though they
>> shouldn't - might be a thing to look for. This must be happening at some
>> stage in the capturing. Is there a way to hook in at different places to
>> narrow down what causes this?
>>
>> Maybe this even already rings somebody's bells?
>>
>> I'll be glad to deliver more information when needed.
>
> I believe that there must be a S/PDIF receiver IC somewhere on the board
> and this IC may be wrongly configured.

http://www.nix.ru/autocatalog/m_audio_midiman_sound/34397_2245_draft.jpg
reveals it is AK4114, just like in ESI Juli. Its default serial data
protocol  is not 24bit I2S, the format expected by ICE1724.

It should be feasible to trace the GPIOs from ICE1724 to AK4114 and add
the config code.

Regards,

Pavel.

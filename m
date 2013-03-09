From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: twl4030 and Puredata/jack
Date: Sat, 09 Mar 2013 12:21:20 -0800
Message-ID: <513B99C0.8020805@gmail.com>
References: <CAAuz6aqqixPxBZQQ5GJinPDfseSVKcnBCvMnLt-6Uad4fP9uPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f49.google.com (mail-da0-f49.google.com
 [209.85.210.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B642265017
 for <alsa-devel@alsa-project.org>; Sat,  9 Mar 2013 21:21:28 +0100 (CET)
Received: by mail-da0-f49.google.com with SMTP id t11so397786daj.22
 for <alsa-devel@alsa-project.org>; Sat, 09 Mar 2013 12:21:23 -0800 (PST)
In-Reply-To: <CAAuz6aqqixPxBZQQ5GJinPDfseSVKcnBCvMnLt-6Uad4fP9uPw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anders Alex <alibobar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/08/2013 07:31 AM, Anders Alex wrote:
> I will paste a couple of use-cases and their corresponding dmesg output:
>
> When I run ~$ pd -alsa I get:
>
> snd_pcm_hw_params (input): Invalid argument
> snd_pcm_hw_params (output): Invalid argument
>
> and:
> [201429.385345] omap_mcbsp_dai_hw_params: not enough bandwidth for desired
> rate and channels
> [201429.385375] asoc: interface omap-mcbsp-dai.1 hw params failed

Strange.  In kernel 3.2, omap-mcbsp-dai.1 (McBSP1) is used for the 
codec.  But in the mainline it's omap-mcbsp-dai.2.

So the question is... how is the board wired?  And does your kernel 
match the board?

> With 'jackd -d alsa -S'  (need s16_le):
>
> loading driver ..
> creating alsa driver ... hw:0|hw:0|1024|2|48000|0|0|nomon|swmeter|-|16bit
> control device hw:0
> configuring for 48000Hz, period = 1024 frames (21.3 ms), buffer = 2 periods
> ALSA: final selected sample format for capture: 16bit little-endian
> ALSA: use 2 periods for capture
> ALSA: cannot set hardware parameters for capture
> ALSA: cannot configure capture channel

Looking at the source, it looks like hw:0,0 has no capture port.  Try 
adding the -P parameter to jackd.  Playback only.

Also, post the output of:

    $ cat /proc/asound/devices

-gabriel

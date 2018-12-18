From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Tue, 18 Dec 2018 19:10:23 +0200
Message-ID: <a86087c7-c13d-6a4e-b233-89cf0e9fd22b@gmail.com>
References: <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <4b358258-d7ae-d82e-cd58-d4b9e3b6f148@linux.intel.com>
 <20181217173930.GF27909@sirena.org.uk>
 <273cb3d8-7cd6-867a-ebb4-22217f88e0a8@linux.intel.com>
 <fcb1acd1-6485-0c3d-8350-82a6f003f320@gmail.com>
 <a63aa724-a513-80c3-6163-574d287cde06@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EF8326782E
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 18:10:26 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id j2so16729109wrw.1
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 09:10:26 -0800 (PST)
In-Reply-To: <a63aa724-a513-80c3-6163-574d287cde06@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/18/18 4:12 PM, Pierre-Louis Bossart wrote:
> My point was that the machine driver can track DAPM events and put the 
> device in a 'safe' state on SND_SOC_DAPM_EVENT_OFF so that the rate can 
> be changed when playback restarts. I don't see what prevents us from 
> using the same config as during suspend? It's pretty common to play with 
> clocks with these events, and calling clk_disable_unprepare() could lead 
> to whatever configuration sequence is needed for pop-free restart on 
> startup.

I only wanted to point out that, given the current DAPM configuration
of the pcm512x CODEC driver (as determined from monitoring calls to
the .set_bias_level callback, which seems to be the only place where
the power state of the chip is actually manipulated), it seemed like
it wasn't necessarily turned off between sample rate changes, and that
I'm not sure there's a 'safe' state you can put it in, so that it
won't pop on the next change to the clock source, if it's powered up
at the time.

The DAPM subsystem is complex and documentation on it is scarce, but
it seems the former can be fixed.  At least it is implied that the DAC
can be turned on/off at the stream domain level, which seems to be
tied to playback starting/stopping.  If the DAC can be suspended right
after playback stops and powered back up right before playback starts
again, then I don't think anything else needs to be done to avoid
pops, as all clock switching will have been done with the device
suspended.

If this is not possible, then I'm not sure if you can put the device
in a 'safe' state, say with both clocks turned off, or the clock
reference switched away from SCK, or something like that, so that it
won't pop when the sample rate (and hence clock source) is later
changed, while the DAC is powered up.

Anyway, calling my familiarity with the internals of ASOC drivers
superficial, would probably be stretching it, so the above is
(hopefully somewhat educated) guesswork at best.  Ignore it if it
doesn't make sense.

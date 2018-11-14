From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Thu, 15 Nov 2018 01:55:06 +0200
Message-ID: <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
 <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EFA22677E8
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 00:55:09 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id j17-v6so19188280wrq.11
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 15:55:09 -0800 (PST)
In-Reply-To: <20181114230255.GG2089@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Thank you for taking the time to help out.

On 11/15/2018 01:02 AM, Mark Brown wrote:
> I've no idea what you're proposing, sorry.

I mentioned it in the message you replied to initially, so you
can consult that for more details if you want, but I'll give a
summary below:

As far as I could determine experimentally, switching clocks when
the DAC is not suspended seems to result in a spike at the input
of the DAC, the level of which doesn't depend on the digital
volume setting (so that it's always very loud).  I tried various
potential fixes, based on guesses about probable causes of the
spike (see first message where I CCed you for a brief list of
attempted fixes) and it seems that a pop can be avoided either by
suppressing it, by muting the DAC, or by avoiding generating it
in the first place by switching the PCM5122 into standby (via bit
PCM512x_RQST of the PCM512x_POWER register) before switching the
external clock and switching it back out of standby afterwards.

Avoiding the spike instead of relying on muting seems preferable,
but, since the power state of the PCM5122 is manipulated by the
CODEC driver, in response to requests to set the bias level, I'm
concerned about potential race conditions.

Right now I have the following implementation for switching the
external clock:


/* Figure out if a clock switch is necessary based on currently
    used clock and requested sample rate . */

...

if (no_switch_needed)
     return;

snd_soc_dapm_mutex_lock(dapm);
force = (snd_soc_dapm_get_bias_level(dapm) != SND_SOC_BIAS_OFF);

if (force)
     snd_soc_dapm_force_bias_level(dapm, SND_SOC_BIAS_OFF);

/* Switch the clock here. */

...

if (force)
     snd_soc_dapm_sync_unlocked(dapm);

snd_soc_dapm_mutex_unlock(dapm);


It seems to work fine, both in consistently avoiding the pop and
in not producing any obvious side-effects.  Does that look
reasonable, or is there a better way to temporarily switch the
PCM5122 into standby in a safe way?

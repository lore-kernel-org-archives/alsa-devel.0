From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Sat, 10 Nov 2018 17:46:33 +0200
Message-ID: <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 980552679B0
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2018 16:46:36 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id b13so4851609wrx.6
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2018 07:46:36 -0800 (PST)
In-Reply-To: <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/08/2018 03:42 AM, Pierre-Louis Bossart wrote:
> Thanks for starting this thread. You are not the only one fighting to 
> make those Hifiberry DAC+ PRO boards work without convoluted hacks. Our 
> team uses them for validation of the Sound Open Firmware on the UP^2 
> boards and we are not quite happy with the clock definitions and don't 
> really have a line of sight to upstream our changes.

Thanks for responding; I was starting to worry this thread would
go by unnoticed.  I've noticed the less than elegant clock setup
as well, and considered patching it, so that the clocks are
actually selected (i.e. powered up/down inside the clock
driver). I'm not sure whether it would have any practical
significance though, as after probing the card, the CODEC driver
only ever stops or starts the clocks inside PM-related callbacks,
which I don't think the Pi supports.

Are you also getting loud pops when switching between clocks?  I
use the following Python script to reproduce the problem (and
also disable auto-mute via the mixer, as it can mask it):

------------------------------

import alsaaudio, time, random

d = alsaaudio.PCM()
p = True

while True:
     time.sleep(1)

     f = p and 48000 or 44100
     n = p and 2 or 1
     m = p and alsaaudio.PCM_FORMAT_S16_LE or alsaaudio.PCM_FORMAT_S24_LE

     d.setrate(f)
     d.setchannels(n)
     d.setformat(m)

     if random.random() > 0*0.25:
         print "pop!"
         p = not p

------------------------------

I've done some more testing regarding the pop, including:

* Trying to switch the DAC clock reference away from SCK (via
   PCM512x_DAC_REF), prior to switching the clocks (to the BCK, or
   to a reserved value that's supposed to cause a mute according
   to the datasheet).

* Halting the clocks, prior to switching the clock source (via
   PCM512x_SYNCHRONIZE) and letting the CODEC driver resynchronize
   them in its hw_params callback, or resynchronizing after the
   switch.

* Enabling clock error detection, which the CODEC driver mostly
   disables, in the hope that it will force a mute.

None of this fixes the pop, although the first two can lower its
volume somewhat.  All in all, the only changes that silence the
pop are:

* Putting the chip into standby before switching clocks in the
   machine driver and resuming afterwards.

* Muting the output before switching clocks in the machine driver
   and unmuting afterwards.

With any of the above, I get no pop after hundreds of clock
switches (using the above script), which otherwise pop every
time.

Muting the output, or suspending the chip at the beginning of the
CODEC driver (pcm512x) and unmuting, or resuming at the end
doesn't help.  This suggests to me that a spike is generated at
the DAC input sometime during/after the clock switch and that
suspending the chip during the switch avoids it altogether, while
muting the output suppresses it.

Implementing digital_mute in the CODEC driver probably helps
because the output is muted during the machine driver's hw_params
callback, but it would make sense to me to fix the machine
driver, so that the spike is never generated in the first place.
My problem is that the PCM512x_POWER register is manipulated at
the CODEC level, inside DAPM-related callbacks and, as far as I
can see, hw_params, a PCM-related callback, and DAPM callbacks
aren't synchronized through some mutex.  Race conditions should
be possible.

The best solution I've found, is to force the chip into standby
via something like the following:

struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);

snd_soc_dapm_mutex_lock(dapm);
snd_soc_dapm_force_bias_level(dapm, SND_SOC_BIAS_OFF);

/* Switch clock source here. */

snd_soc_dapm_sync_unlocked(dapm);
snd_soc_dapm_mutex_unlock(dapm);

This seems to work fine, but I'm not sure if it's the appropriate
approach, or if it has unwanted side-effects.  I've CCed the
author of pcm512x, who's also a maintainer on ASOC and
DAPM-related stuff.  Perhaps he can advise on this.

-Dimitris

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: Provide a CLOCK_MONOTONIC_RAW
	timestamp type
Date: Tue, 08 Jul 2014 21:54:32 +0200
Message-ID: <53BC4C78.5030702@perex.cz>
References: <1404831109-8008-1-git-send-email-broonie@kernel.org>
 <s5hr41vopyt.wl%tiwai@suse.de> <20140708160036.GA30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 92A3C261A92
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 21:54:32 +0200 (CEST)
In-Reply-To: <20140708160036.GA30458@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Daniel Thompson <daniel.thompson@linaro.org>
List-Id: alsa-devel@alsa-project.org

Date 8.7.2014 18:00, Mark Brown wrote:
> On Tue, Jul 08, 2014 at 05:00:26PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>> due to that. A raw monotonic time which does not include any adjustments
>>> is available in the kernel from getrawmonotonic() so provide userspace with
>>> a new timestamp type SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW which provides
>>> timestamps based on this as an option.
> 
>> This looks good to me.  Or, thinking of the original use case, should
>> we just replace ktime_get_ts() with getrawmonotonic()?  The MONOTONIC
>> mode is really to be monotonic.
> 
> I'm totally OK with that as well if people don't mind that, I just added
> a new clock as the most conservative option.  I can easily respin the
> patch for this if you prefer?

Note that the silent change would break the timestamp compatibility,
because monotonic timestamp is used in alsa-lib by default. I would
prefer to add a new type as originaly proposed and allow to choose
between NTP monotonic and raw monotonic. Also the network timestamp
might allow better synchronization for network apps (not sure about the
real usage now, but we're working on an universal framework).

>> While we're at it: there's been long-standing request from V4L guys
>> for improving the timestamps to sync with video streams.  I suggested
>> to add a new mode that can be set by the driver.  Worth to consider
>> it, too?
> 
> Does the wall clock stuff address that?  I've no objection to adding a
> further type if the existing ones (and this one aren't sufficient).

I'm curious about requested sync, too..

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.

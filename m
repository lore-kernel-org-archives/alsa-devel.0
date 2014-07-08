From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: Provide a CLOCK_MONOTONIC_RAW
 timestamp type
Date: Tue, 08 Jul 2014 19:01:48 +0200
Message-ID: <53BC23FC.7000108@ladisch.de>
References: <1404831109-8008-1-git-send-email-broonie@kernel.org>
 <s5hr41vopyt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 301E42619FB
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 19:02:36 +0200 (CEST)
In-Reply-To: <s5hr41vopyt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Mark Brown wrote:
>> For applications which need to synchronise with external timebases such
>> as broadcast TV applications the kernel monotonic time is not optimal as
>> it includes adjustments from NTP and so may still include discontinuities
>> due to that. A raw monotonic time which does not include any adjustments
>> is available in the kernel from getrawmonotonic() so provide userspace with
>> a new timestamp type SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW which provides
>> timestamps based on this as an option.
>
> This looks good to me.  Or, thinking of the original use case, should
> we just replace ktime_get_ts() with getrawmonotonic()?  The MONOTONIC
> mode is really to be monotonic.

This would break any applications that relate these timestamps to their
own timestamps from clock_gettime(CLOCK_MONOTONIC).


Regards,
Clemens

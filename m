From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 3/3] ALSA: pcm: Add timestamp type to
	sw_params
Date: Thu, 10 Jul 2014 19:57:38 +0200
Message-ID: <53BED412.1030302@ladisch.de>
References: <1404997458-15377-1-git-send-email-tiwai@suse.de>	<1404997458-15377-4-git-send-email-tiwai@suse.de>	<53BEAFF9.5070501@linux.intel.com>
 <s5hsim9kypi.wl%tiwai@suse.de> <53BED162.808@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B173B2607C8
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 19:58:28 +0200 (CEST)
In-Reply-To: <53BED162.808@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> On 7/10/14, 10:42 AM, Takashi Iwai wrote:
>> Pierre-Louis Bossart wrote:
>>> On 7/10/14, 8:04 AM, Takashi Iwai wrote:
>>>> For allowing adjusting the timestamp type on the fly, add it to
>>>> sw_params.  The existing ioctl is still kept for compatibility.
>>>
>>> I have strong objections to this extension. It will result in a
>>> discontinuity in the timestamps reported in pcm_status without a clear
>>> indication of what timestamp is reported (when does this change occur?),
>>> and it's completely unclear how userspace would handle a step (positive
>>> or negative) between ntp-adjusted and non-ntp-adjusted times.
>>
>> Well, I don't understand the logic; it's app itself who changes the
>> timestamp type.  It must know when it's changed (because app is
>> changing it), and how to handle (because app chooses the timestamp
>> type).  And the current type can be queried via sw_params_*_get()
>> thing.
>>
>> Of course, as default, there is no change from the current behavior --
>> it takes CLOCK_MONOTONIC.  So, there should be no breakage by this
>> change unless you change the application side to use the new call.
>>
>>> For apps
>>> that make use of the audio_time reported with a wall clock this could
>>> lead to complete nonsense.
>>> I would have no problems if this was a fixed parameter defined once
>>> before audio streaming starts.
>>
>> You don't have to change the setup after the stream starts.  It's
>> usually set before the stream starting.  The point of using sw_params
>> is that it's independent from the hardware driver, thus it fits better
>> than hw_params.  The switching after stream isn't the purpose.  It's
>> just a gratis bonus.
>
> So we agree that the dynamic switch isn't the intended usage but we
> allow for it anyway... I guess given that we can enable/disable
> timestamps dynamically this follows the same logic, it's just weird to
> have a sw_param whose intended use is really a hw_param, something you
> set once and don't modify later.

The difference between sw_params and hw_params is that the latter are
affected by device constraints (and might have interdependencies).
That sw_params can be changed at any time is just a consequence of that.

> If we want user-space to do the right thing we should at least
> document the consequences of a dynamic switch.

Changing the clock relative to which the timestamp is reported is not
only the desired but the _only_ consequence of this parameter.  (And
changing from/to GETTIMEOFDAY was already possible.)


Regards,
Clemens

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] alsa-lib: Provide a CLOCK_MONOTONIC_RAW
 timestamp type
Date: Thu, 10 Jul 2014 10:10:56 -0500
Message-ID: <53BEAD00.5050304@linux.intel.com>
References: <1404831152-8064-1-git-send-email-broonie@kernel.org>
 <s5h7g3modn8.wl%tiwai@suse.de> <53BD9A92.6090806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 72AB7261B0E
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 17:11:19 +0200 (CEST)
In-Reply-To: <53BD9A92.6090806@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 7/9/14, 2:40 PM, Clemens Ladisch wrote:
> Takashi Iwai wrote:
>> Currently, the timestamp mode is set implicitly in alsa-lib pcm_hw.c:
>> - When kernel PCM protocol version is high enough, alsa-lib hw prefers
>>    the monotonic always (if available), then set pcm->monotonic = 1.
>> - Application can ask whether the current timestamp is monotonic or
>>    not via snd_pcm_hw_params_is_monotonic().
>> So, only adding the flag above doesn't suffice.  If we need to add a
>> new mode, the API has to be extended as well.
>>
>> But how?  The current API assumes that the monotonic mode was already
>> determined before hw_params.  We may add a set of new hw_params get
>> and set calls for tstamp mode while keeping the old API.  This would
>> be one option.  Another option would be to add a new PCM open flag
>> SND_PCM_TSTAMP_MONOTONIC_RAW, and snd_pcm_hw_params_is_monotonic_raw()
>> function.  The latter is easier (a simpler addition), while the former
>> is more extensible to newer formats in future.
>
> These timestamps cannot be handled by hardware drivers; they are always
> read by the ALSA framework, in software.  Furthermore, switching between
> MONOTONIC and MONOTONIC_RAW is possible at any time.  Therefore, the
> timestamp mode should be made a part of sw_params; just add a field
> named tstamp_mode ...

Humm... why would anyone switch modes at run time during 
playback/capture? I have seen timestamps being used mainly to track that 
playback/capture is happening as predicted, improve A/V sync or sleep 
for a predictable time with interrupts disabled (PulseAudio, Android, 
ChromeOS, etc). NTP adjustments are really adding noise more than 
information for those usages. I have yet to see a case where the use of 
those NTP adjustments would matter for userspace, and for now I really 
don't see the point of making this dynamically configurable as a 
software parameter. I would personally make this new mode the default.
-Pierre

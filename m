From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/7] ALSA: hda: Refactor display power
 management
Date: Tue, 11 Dec 2018 08:34:44 -0600
Message-ID: <a650e6aa-60fe-7f60-ca23-5c819c9e353d@linux.intel.com>
References: <20181209093318.27829-1-tiwai@suse.de>
 <20181209093318.27829-3-tiwai@suse.de>
 <1ff2c83b-fb5e-2972-77d0-e32c247e9912@linux.intel.com>
 <s5ha7lcwo34.wl-tiwai@suse.de>
 <1eada34e-94fb-a6dd-dde9-3a6e40b9bc50@linux.intel.com>
 <s5hftv4kvls.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 21558267BCB
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 15:34:46 +0100 (CET)
In-Reply-To: <s5hftv4kvls.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>>>>>      a codec was done indirectly via link_power bus ops.)
>>>>>
>>>>> - snd_hdac_display_power() receives the codec address index.  For
>>>>>      turning on/off from the controller, pass HDA_CODEC_IDX_CONTROLLER.
>>>> The need for this virtual index==16 isn't fully clear to me,
>>>> especially if you use the bitfields instead of reference counts.
>>>>
>>>> Isn't there a risk of the controller setting the bit16 to zero, but
>>>> you still have bit4 on (assuming the idx is 4). If you use this
>>>> virtual index, it should override the actual physical bits when
>>>> set/cleared.
>>> This is the index for a controller, i.e. we'd need bits for the max
>>> number of codecs + 1.
>>>
>>> Actually we do support only up to 8 codecs (HDA_MAX_CODECS), so it
>>> should be 8, instead of 16, too.  I'll update to be HDA_MAX_CODECS.
>>>
>>>> Or is this meant to actually implement a preemption mechanism, where
>>>> the display power remains on for as long as the controller wishes,
>>>> regardless of what the patch_hdmi and hdac_hdmi code requests?
>>> Right.  That's the mechanism at the initial phase, we need the display
>>> power on while probing the codec, i.e. before identifying the codec
>>> ID.
>>>
>>>> Also don't we already have the HDMI codec address already after the
>>>> probe, so couldn't we provide the address directly?
>>> The resume seemed requiring the controller to take the display power
>>> at first, so the same mechanism is used.
>> ok, makes sense, thanks for the explanations.
>>
>> So I guess for the SOF patches, the only change would be to add the
>> second argument HDA_CODEC_IDX_CONTROLLER to snd_hdac_display_power()
>> calls, the rest looks unchanged or hidden inside the hdac library or
>> hdac_hdmi parts.
> Yes, other than that, this change makes things easier.
>
> Since we don't manage with refcount, the only important point is to
> turn off/on properly at suspend/resume (also off at remove), no matter
> how many times it gets called.
Ah yes, we are missing this on remove since we assumed the refcount 
would already be zero. I guess we'll have to revalidate this part 
anyways once your patches are merged (already have an SOF issue filed to 
track this change).

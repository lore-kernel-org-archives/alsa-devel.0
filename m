From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/7] ALSA: hda: Refactor display power
 management
Date: Tue, 11 Dec 2018 07:58:37 -0600
Message-ID: <1eada34e-94fb-a6dd-dde9-3a6e40b9bc50@linux.intel.com>
References: <20181209093318.27829-1-tiwai@suse.de>
 <20181209093318.27829-3-tiwai@suse.de>
 <1ff2c83b-fb5e-2972-77d0-e32c247e9912@linux.intel.com>
 <s5ha7lcwo34.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 35677267BA8
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 14:58:39 +0100 (CET)
In-Reply-To: <s5ha7lcwo34.wl-tiwai@suse.de>
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


On 12/11/18 12:54 AM, Takashi Iwai wrote:
> On Mon, 10 Dec 2018 21:52:05 +0100,
> Pierre-Louis Bossart wrote:
>>
>> On 12/9/18 3:33 AM, Takashi Iwai wrote:
>>> The current HD-audio code manages the DRM audio power via too complex
>>> redirections, and this seems even still unbalanced in a corner case as
>>> Intel DRM CI has been intermittently reporting.  This patch is a big
>>> surgery for addressing the complexity and the possible unbalance.
>>>
>>> Basically the patch changes the display PM in the following ways:
>>>
>>> - Both HD-audio controller and codec drivers call a single helper,
>>>     snd_hdac_display_power().  (Formerly, the display power control from
>>>     a codec was done indirectly via link_power bus ops.)
>>>
>>> - snd_hdac_display_power() receives the codec address index.  For
>>>     turning on/off from the controller, pass HDA_CODEC_IDX_CONTROLLER.
>> The need for this virtual index==16 isn't fully clear to me,
>> especially if you use the bitfields instead of reference counts.
>>
>> Isn't there a risk of the controller setting the bit16 to zero, but
>> you still have bit4 on (assuming the idx is 4). If you use this
>> virtual index, it should override the actual physical bits when
>> set/cleared.
> This is the index for a controller, i.e. we'd need bits for the max
> number of codecs + 1.
>
> Actually we do support only up to 8 codecs (HDA_MAX_CODECS), so it
> should be 8, instead of 16, too.  I'll update to be HDA_MAX_CODECS.
>
>> Or is this meant to actually implement a preemption mechanism, where
>> the display power remains on for as long as the controller wishes,
>> regardless of what the patch_hdmi and hdac_hdmi code requests?
> Right.  That's the mechanism at the initial phase, we need the display
> power on while probing the codec, i.e. before identifying the codec
> ID.
>
>> Also don't we already have the HDMI codec address already after the
>> probe, so couldn't we provide the address directly?
> The resume seemed requiring the controller to take the display power
> at first, so the same mechanism is used.

ok, makes sense, thanks for the explanations.

So I guess for the SOF patches, the only change would be to add the 
second argument HDA_CODEC_IDX_CONTROLLER to snd_hdac_display_power() 
calls, the rest looks unchanged or hidden inside the hdac library or 
hdac_hdmi parts.

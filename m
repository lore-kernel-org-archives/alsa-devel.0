From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: hdac_hdmi: add Icelake support
Date: Mon, 12 Nov 2018 21:04:11 +0800
Message-ID: <ae98c656-07eb-0f4e-57f4-adbb3d751ff9@linux.intel.com>
References: <20181110211846.23667-1-yung-chuan.liao@linux.intel.com>
 <s5hftw8ngd4.wl-tiwai@suse.de>
 <ac9cecd2-7321-34dd-a317-4d6d3c21635e@linux.intel.com>
 <s5h5zx3o6um.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 866CB26751A
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 14:04:17 +0100 (CET)
In-Reply-To: <s5h5zx3o6um.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/12/2018 1:35 AM, Takashi Iwai wrote:
> On Sun, 11 Nov 2018 16:10:10 +0100,
> Pierre-Louis Bossart wrote:
>>
>> On 11/11/18 2:55 AM, Takashi Iwai wrote:
>>> On Sat, 10 Nov 2018 22:18:46 +0100,
>>> Bard liao wrote:
>>>> From: Bard liao <bard.liao@intel.com>
>>>>
>>>> Add Icelake device id. Also, Icelake's pin2port mapping table is
>>>> complicated. So we use a mapping table to do the pin2port mapping.
>>>>
>>>> Signed-off-by: Bard liao <bard.liao@intel.com>
>>> The recent code has already pin2port callback in drm_audio_component
>>> ops.  This is called in sound/hda/hdac_component.c before eld notify
>>> callback gets called.  So, use this callback instead of introducing
>>> yet another one.
>> Sorry Takashi, can you elaborate? What this patch does is modify the
>> existing implementation of the .pin2port callback, not add a new
>> one. The existing logic (return pin - 4) is no longer sufficient on
>> IceLake.
> The recent change added the pin2port call in
> drm_audio_component_audio_ops.  You can put the ICL-specific call into
> this if any specific conversion is needed.

hdac_hdmi_pin2port is indeed the pin2port call back function in
drm_audio_component_audio_ops :)
What the patch did is to modify the current pin2port call back
function in drm_audio_component_audio_ops.

>>> Also, it'd be helpful if you fix the same for the legacy HD-audio HDMI
>>> codec driver.
>> Our intention was to revisit differences between legacy and non-legacy
>> in a separate patch if that's all right with you. We've identified
>> missing IDs and other things that should be fixed separately.
> Sure, I don't mean to fix both in a single patch, but just to remind
> you guys not to forget about that code path.
>
>
> thanks,
>
> Takashi
>

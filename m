From: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH V2 1/1] drm/i915/audio: apply SKL codec
	wake up patch to BXT
Date: Thu, 19 Nov 2015 18:01:51 +0200
Message-ID: <87d1v6t1u8.fsf@intel.com>
References: <1447944288-28499-1-git-send-email-han.lu@intel.com>
 <20151119155549.GJ17050@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 24059265AF5
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 17:03:38 +0100 (CET)
In-Reply-To: <20151119155549.GJ17050@phenom.ffwll.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Vetter <daniel@ffwll.ch>, han.lu@intel.com
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, tiwai@suse.de, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, han.lu@linux.intel.com, libin.yang@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Nov 2015, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Nov 19, 2015 at 10:44:48PM +0800, han.lu@intel.com wrote:
>> From: "Lu, Han" <han.lu@intel.com>
>> 
>> For SKL we added a commit 632f3ab95fe2 ("drm/i915/audio: add codec wakeup
>> override enabled/disable callback"), in order to enable codec wakeup
>> override signal, to allow re-enumeration of the controller on SKL after
>> resume from low power state.
>> In SKL, HDMI/DP codec and PCH HD Audio Controller are in different power
>> wells, so it's necessary to reset display audio codecs when power well on,
>> otherwise display audio codecs will disappear when resume from low power
>> state.
>> Reset steps when power on:
>>     enable codec wakeup -> azx_init_chip() -> disable codec wakeup
>> Since the power well design did not change from SKL to BXT, we need to
>> apply the workaround to BXT also.
>> 
>> v2: add explanation
>> 
>> Signed-off-by: Lu, Han <han.lu@intel.com>
>> 
>> diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
>> index 63d4706..8310bf3 100644
>> --- a/drivers/gpu/drm/i915/intel_audio.c
>> +++ b/drivers/gpu/drm/i915/intel_audio.c
>> @@ -591,7 +591,8 @@ static void i915_audio_component_codec_wake_override(struct device *dev,
>>  	struct drm_i915_private *dev_priv = dev_to_i915(dev);
>>  	u32 tmp;
>>  
>> -	if (!IS_SKYLAKE(dev_priv) && !IS_KABYLAKE(dev_priv))
>> +	if (!IS_SKYLAKE(dev_priv) && !IS_BROXTON(dev_priv) &&
>> +			!IS_KABYLAKE(dev_priv))
>
> if (INTEL_INFO(dev)->gen < 9)
> 	return;
>
> for future-proofing? At least make it an IS_GEN9 check instead of
> listening all of them in a long list.

http://mid.gmane.org/87a8qacq5w.fsf@intel.com ...

> -Daniel
>
>>  		return;
>>  
>>  	/*
>> -- 
>> 2.5.0
>> 

-- 
Jani Nikula, Intel Open Source Technology Center

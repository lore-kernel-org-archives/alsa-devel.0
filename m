From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda: hdmi - add Icelake support
Date: Thu, 14 Mar 2019 08:05:23 +0100
Message-ID: <96c6fddd-c998-6901-5395-059c01c33c05@perex.cz>
References: <20190313160923.10471-1-perex@perex.cz>
 <9485bfe9-441b-5d52-420d-662ae372a8a1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 426CEF8961E
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2019 08:05:28 +0100 (CET)
In-Reply-To: <9485bfe9-441b-5d52-420d-662ae372a8a1@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Bard liao <bard.liao@intel.com>
List-Id: alsa-devel@alsa-project.org

Dne 13. 03. 19 v 21:55 Pierre-Louis Bossart napsal(a):
> On 3/13/19 11:09 AM, Jaroslav Kysela wrote:
>> This is just a port of the ASoC Icelake HDMI codec code to the legacy
>> HDA driver with some cleanups.
>>
>> ASoC commit 019033c854a20e10f691f6cc0e897df8817d9521:
>>    "ASoC: Intel: hdac_hdmi: add Icelake support"
> 
> Thanks Jaroslav, we were just talking today about this but you beat us 
> to it.
> One comment below on the geminilake ID:
> 
>>   #define is_geminilake(codec) (((codec)->core.vendor_id == 0x8086280d) || \
>>   				((codec)->core.vendor_id == 0x80862800))
> 
>> +HDA_CODEC_ENTRY(0x80862800, "Geminilake HDMI",	patch_i915_glk_hdmi),
> 
> This 0x2800 ID does not seem to be legit. No one at Intel, including the 
> hardware IP owner, was able to confirm why this value was provided 
> upstream, it is not part of any internal hardware documentation, is 
> suspiciously out-of-sequence and is not used in the hdac_hdmi code. The 
> contributor who released this value is no longer with Intel so I would 
> really suggest removing this ID from the list supported by the legacy 
> driver. I can send a patch next week for this.

Yes, the ID 0x80862800 is suspicious and it will be fine to remove it in
the another patch with a proper comment. I preserved the functionality
in my change. Thanks for your explanation.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/5] ALSA: hda: move parts of NHLT code
 to new module
Date: Mon, 22 Jul 2019 07:14:28 -0500
Message-ID: <97359d3a-a3a0-696a-3d3f-64bd608eea5f@linux.intel.com>
References: <20190719203752.11151-1-pierre-louis.bossart@linux.intel.com>
 <20190719203752.11151-3-pierre-louis.bossart@linux.intel.com>
 <daaa01dc-d963-f215-90b1-132fde8e489a@intel.com>
 <s5h7e8aa1qs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 360A3F8049C
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 14:23:26 +0200 (CEST)
In-Reply-To: <s5h7e8aa1qs.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org



On 7/22/19 3:54 AM, Takashi Iwai wrote:
> On Sat, 20 Jul 2019 23:06:46 +0200,
> Cezary Rojewski wrote:
>>
>>> --- a/sound/hda/Kconfig
>>> +++ b/sound/hda/Kconfig
>>> @@ -29,3 +29,6 @@ config SND_HDA_PREALLOC_SIZE
>>>      	  Note that the pre-allocation size can be changed dynamically
>>>    	  via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
>>> +
>>> +config SND_INTEL_NHLT
>>> +	tristate
>>
>> If above is true, "depends on ACPI" would be expected.
> 
> This won't fix things in practice as the Kconfig reverse selection
> ignores the dependencies of the selected item.  It'd be as a help for
> readers, though.

There is a fallback if ACPI is not defined, so the code would always 
compile. Configurations which select SND_INTEL_NHLT already depend on ACPI.

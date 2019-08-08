From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RESEND PATCH v3] ASoC: Intel: Skylake:
 large_config_get overhaul
Date: Thu, 8 Aug 2019 12:31:09 +0200
Message-ID: <1f65d726-dac1-bd3f-d207-8b3ae753bee3@intel.com>
References: <20190807134745.1648-1-cezary.rojewski@intel.com>
 <4b0e1051-946b-ea7c-1e09-93e0825e5ac8@linux.intel.com>
 <b03e179d-23f8-ae3e-fcd2-996433e44894@intel.com>
 <9fd54b42-acb0-805c-5e36-5fedd3b5e322@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22D94F800E4
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 12:31:14 +0200 (CEST)
In-Reply-To: <9fd54b42-acb0-805c-5e36-5fedd3b5e322@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 2019-08-08 05:30, Pierre-Louis Bossart wrote:
>>>
>>> [1] here you are just saying that the looping is really not required 
>>> so there are no tests at all...
>>>
>>> [4] So shouldn't you split the two parts of this patch and separate 
>>> looping from not touching the data that's vendor-specific?
>>
>> So, looping mainly gets used in _sets_, for _gets_ I've not seen a 
>> live example, really - despite FW supporting such flow. However, I'd 
>> like to verify before adding any looping, possibly by creating a 
>> custom module myself. Followup to your point: existing looping was not 
>> tested either.
> 
> So how about removing this looping first in the existing code and add 
> the needed changes in a second patch? wouldn't that help make the 
> changes more self-contained? A large part of your patch below has 
> indentation differences which make it hard to figure out what the new 
> approach is.

Agreed. Must say, didn't get you at first.
Update v4 has been sent and should do a better job at guiding the reader 
through changes.

Czarek

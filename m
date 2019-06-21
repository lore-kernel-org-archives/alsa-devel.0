From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: Skylake: Switch to modern
 UUID API
Date: Fri, 21 Jun 2019 05:41:48 +0200
Message-ID: <76ae3d0e-a948-f8f9-d6af-13c523414352@linux.intel.com>
References: <20190619150213.87691-1-andriy.shevchenko@linux.intel.com>
 <a987bd54-5364-f046-a928-44a97ed0307f@linux.intel.com>
 <20190620150907.GG9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2556F808AF
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2019 05:41:54 +0200 (CEST)
In-Reply-To: <20190620150907.GG9224@smile.fi.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


>>>    	char mod_name[64]; /* guid str = 32 chars + 4 hyphens */
>>> -	uuid_le *uuid_mod;
>>> -	uuid_mod = (uuid_le *)guid;
>>>    	snprintf(mod_name, sizeof(mod_name), "%s%pUL%s",
>>> -				"intel/dsp_fw_", uuid_mod, ".bin");
>>> +					     "intel/dsp_fw_", guid, ".bin");
>>
>> indentation looks off, not sure if this is a diff effect.
> 
> Ah, this can be modified to the below (by a separate patch, since Mark applied
> this one already):
> 
> 	snprintf(mod_name, sizeof(mod_name), "intel/dsp_fw_%pUL.bin", guid);
> 
> What do you think?
> 
> P.S. And it will take only one line.

Sounds good to me. Not sure why it was written this way.

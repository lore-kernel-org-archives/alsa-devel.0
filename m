From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 1/8] ASoC: Intel: Skylake: fix widget
	handling
Date: Wed, 25 Jul 2018 11:39:33 -0500
Message-ID: <d783cb0a-3c7e-edef-a648-e5a352aabdb3@linux.intel.com>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-2-pierre-louis.bossart@linux.intel.com>
 <20180725105928.GL3661@vkoul-mobl>
 <8f35758e-1592-cf0f-832c-cc358a7b2659@linux.intel.com>
 <20180725161156.GV3661@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 20BD526774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:39:36 +0200 (CEST)
In-Reply-To: <20180725161156.GV3661@vkoul-mobl>
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
To: Vinod <vkoul@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> include DAPM Mux and output widgets into the list.
>>>
>>> Pierre,
>>>
>>> Curious how is this a fix?
>>
>> This is Skylake-specific topology black magic that you are probably better
>> equiped to understand that me... This just takes out the outputs and mux
>> from a number of topology handling cases.
> 
> :D
> 
> I agree with the change. But it is not a fix.. So "Add additional widget
> handling" would be a better title.
> 
> Fix is used for bugs and should be applied to next -rc.

ok, will change.

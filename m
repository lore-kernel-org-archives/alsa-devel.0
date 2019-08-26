From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 29/35] ASoC: Intel: Skylake: Flip SST
 initialization order
Date: Mon, 26 Aug 2019 22:03:29 +0200
Message-ID: <58e4a176-3f91-ab5f-1cc8-48a5b4c9bc52@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-30-cezary.rojewski@intel.com>
 <f025c4c4-4987-e3c0-302f-1ee47dba60ac@linux.intel.com>
 <1d289b44-cd68-bee5-498b-953186d99150@intel.com>
 <19ee20ec-2b29-639b-6181-05f4582a8f18@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6923CF801ED
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 22:03:38 +0200 (CEST)
In-Reply-To: <19ee20ec-2b29-639b-6181-05f4582a8f18@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 2019-08-26 18:39, Pierre-Louis Bossart wrote:
> 
> 
> On 8/24/19 5:54 AM, Cezary Rojewski wrote:
>> On 2019-08-23 22:18, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 8/22/19 2:04 PM, Cezary Rojewski wrote:
>>>> To this date Skylake SST were following ill flow of initialization by
>>>
>>> 'ill' as in 'sick'? that's probably a bit strong and judgmental?
>>> or is this a typo?
>>>
>>
>> ill seems like a perfect opposite of healthy, ain't it? Because 
>> certainly, the initialization pattern observed in /skylake is 
>> everything but healthy.
> 
> I don't know what 'healthy' means either in this context.
> 
> s/ill/incorrect/?
> 

In essence, most of what is required is actually done even in existing 
/skylake init. How it is done leaves a lot to be desired, though. 
Initialization is cleaned up to improve code quality and make it look 
cohesive - removal of duplications, usage of sst-framework functions and 
so on.

Followup segments - including but not limited to power-management - 
touch this stuff quite a bit. With initialization updated, each 
power-management patch fixes single spot rather than 3 (skl-sst, 
bxt-sst, cnl-sst). Should probe more readable and easy to review.

That's why I described it via 'ill'.
Although I do agree, could have chosen a better description.

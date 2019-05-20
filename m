From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: sof-rt5682: Few minor
 fixes for AMP SSP and codec button
Date: Mon, 20 May 2019 08:39:24 -0500
Message-ID: <bc2f98be-6eb7-b668-8d6e-2be7e8ecc929@linux.intel.com>
References: <20190518183009.13359-1-pierre-louis.bossart@linux.intel.com>
 <20190518183009.13359-2-pierre-louis.bossart@linux.intel.com>
 <20190520123114.GA10827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55BA8F80726
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2019 15:39:28 +0200 (CEST)
In-Reply-To: <20190520123114.GA10827@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 5/20/19 7:31 AM, Mark Brown wrote:
> On Sat, May 18, 2019 at 01:30:07PM -0500, Pierre-Louis Bossart wrote:
>> From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
>>
>>      This fixes:
>>      1. BIT mask for AMP SSP was incorrect.
>>      2. The RT5682 codec button mapping is corrected.
> 
> Indentation is a bit weird here, and these are really two changes that
> should be split.
> 
>> @@ -519,6 +520,7 @@ static int sof_audio_probe(struct platform_device *pdev)
>>   
>>   	/* compute number of dai links */
>>   	sof_audio_card_rt5682.num_links = 1 + dmic_num + hdmi_num;
>> +
>>   	if (sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT)
>>   		sof_audio_card_rt5682.num_links++;
>>   
> 
> and this is an unrelated indentation change.

ok, I'll send a v2.

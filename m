From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/7] ASoC: Intel: Fix Kconfig
Date: Mon, 20 Nov 2017 10:18:01 -0600
Message-ID: <3c0db712-ed68-35ce-d50a-0a4557b42ef1@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-2-pierre-louis.bossart@linux.intel.com>
 <s5hine78rbx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C0E0266F52
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 17:18:05 +0100 (CET)
In-Reply-To: <s5hine78rbx.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, vinod.koul@intel.com, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org



On 11/18/2017 10:49 AM, Takashi Iwai wrote:
> On Sat, 18 Nov 2017 01:01:56 +0100,
> Pierre-Louis Bossart wrote:
>> +if SND_SOC_INTEL_BAYTRAIL
>>   
>>   config SND_SOC_INTEL_BYT_MAX98090_MACH
>>   	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
>> +	default n
> default=n is superfluous, can be dropped.
>
>>   	depends on X86_INTEL_LPSS && I2C
>> -	depends on SND_SST_IPC_ACPI = n
>> -	depends on SND_SOC_INTEL_BAYTRAIL
>>   	select SND_SOC_MAX98090
> So the dependency on ND_SST_IPC_ACPI=n is removed here too, and I
> guess this will allow this machine driver built although it shouldn't
> be?
This dependency doesn't really make sense any longer at the machine 
driver level. There is now an explicit layer on the platform side 
(SND_SOC_INTEL_BAYTRAIL) where the exclusion with SND_SOC_INTEL_HIFI2 
platforms should be handled.
I also removed this dependency because it was 'one way', I couldn't find 
a way to show explicit mutual exclusions without getting into circular 
dependencies.

>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 4/8] ASoC: Intel: move all ACPI match
 tables to common module
Date: Tue, 26 Sep 2017 14:13:23 -0500
Message-ID: <6c836c0f-5403-f7d2-5433-8197f8501e9e@linux.intel.com>
References: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
 <20170908205702.1985-5-pierre-louis.bossart@linux.intel.com>
 <20170926042300.GL30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 16617267140
 for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2017 21:13:30 +0200 (CEST)
In-Reply-To: <20170926042300.GL30097@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 9/25/17 11:23 PM, Vinod Koul wrote:
> On Fri, Sep 08, 2017 at 03:56:58PM -0500, Pierre-Louis Bossart wrote:
>> First step of cleaning, move all tables to soc-acpi-intel-match module
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/sound/soc-acpi-intel-match.h          |  32 +++
>>   sound/soc/intel/Kconfig                       |  24 +-
>>   sound/soc/intel/Makefile                      |   2 +-
>>   sound/soc/intel/atom/sst/sst_acpi.c           | 311 ++-----------------------
>>   sound/soc/intel/common/Makefile               |   2 +
>>   sound/soc/intel/common/soc-acpi-intel-match.c | 323 ++++++++++++++++++++++++++
>>   sound/soc/intel/common/sst-acpi.c             |  44 +---
>>   7 files changed, 395 insertions(+), 343 deletions(-)
>>   create mode 100644 include/sound/soc-acpi-intel-match.h
>>   create mode 100644 sound/soc/intel/common/soc-acpi-intel-match.c
>>
>> diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
>> new file mode 100644
>> index 0000000..1a9191c
>> --- /dev/null
>> +++ b/include/sound/soc-acpi-intel-match.h
>> @@ -0,0 +1,32 @@
>> +
>> +/*
>> + * Copyright (C) 2017, Intel Corporation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License version
>> + * 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef __LINUX_SND_SOC_ACPI_INTEL_MATCH_H
>> +#define __LINUX_SND_SOC_ACPI_INTEL_MATCH_H
> 
> do we need LINUX on this one, it already too long :)

I checked and all include/sound/soc* files have this LINUX_SND_SOC 
prefix. I don't mind removing it but then someone will object it's not 
consistent.

> 
>> +
>> +#include <linux/stddef.h>
>> +#include <linux/acpi.h>
>> +
>> +/*
>> + * these tables are not constants, some fields can be used for
>> + * pdata or machine ops
>> + */
>> +extern struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[];
>> +extern struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[];
>> +extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_legacy_machines[];
>> +extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_machines[];
>> +extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cherrytrail_machines[];
> 
> so the header is just for externs, not a pretty thing, can we avoid these
> somehow. Do they need to be in common file, why not keep then in respective
> byt/hsw file.

Because they will be shared between drivers, that's the whole point.
I can't put a common table in either of sound/soc/sof or 
sound/soc/intel/atom. I didn't find a better solution than a module with 
just tables + matching functions in it.

> 
> 
>> +config SND_SOC_INTEL_COMMON
>> +	tristate
>> +
>>   config SND_SOC_INTEL_SST
>>   	tristate
>> +	select SND_SOC_INTEL_COMMON
>>   	select SND_SOC_INTEL_SST_ACPI if ACPI
>> -	select SND_SOC_INTEL_SST_MATCH if ACPI
>> +	select SND_SOC_ACPI_INTEL_MATCH if ACPI
>>   
>> -config SND_SOC_INTEL_SST_MATCH
>> +config SND_SOC_ACPI_INTEL_MATCH
>>   	tristate
>>   	select SND_SOC_ACPI if ACPI
>>   
>> @@ -145,7 +149,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
>>   	select SND_SOC_RT5640
>>   	select SND_SST_ATOM_HIFI2_PLATFORM
>>   	select SND_SST_IPC_ACPI
>> -	select SND_SOC_INTEL_SST_MATCH if ACPI
>> +	select SND_SOC_ACPI_INTEL_MATCH if ACPI
> 
> why do you need this change, SND_SOC_INTEL_SST selects
> SND_SOC_ACPI_INTEL_MATCH, so we should select top symbol which is
> SND_SOC_INTEL_SST

The idea is also to share machine drivers between SOF and closed-source 
based platform drivers, so if we keep the semantic of INTEL_SST as is 
then it needs to go away from the machine parts.

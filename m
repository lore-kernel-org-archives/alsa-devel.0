From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: SOF: uapi headers - add missing
 include for stdint.h
Date: Wed, 29 May 2019 09:13:52 +0200
Message-ID: <286ab50b-b0ac-3e98-b4c6-c0304b7414f7@perex.cz>
References: <20190528200206.2793-1-perex@perex.cz>
 <2baa9302-3e1d-6710-ed3e-13122094f8b8@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 321BCF8065A
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2019 09:13:57 +0200 (CEST)
In-Reply-To: <2baa9302-3e1d-6710-ed3e-13122094f8b8@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Dne 28. 05. 19 v 23:45 Pierre-Louis Bossart napsal(a):
> Hi Jaroslav,
> 
> On 5/28/19 3:02 PM, Jaroslav Kysela wrote:
>> The modified header files depend on types defined in <stdint.h>.
> 
> Humm, not an objection but more a question: may I ask in which cases the 
> compilation would fail or what types were problematic? I see stdint.h 
> being used by only 3 files in include/uapi so not sure if we missed 
> something?

We have some automatic tests in our kernel integration, so the uapi headers
should be useable standalone. But looking further to the uapi tree,
uapi/scsi/scsi_bsg_fc.h does not have stdint.h include statement, too. So the
situation is not black and white. I will recommend to add explicit include of
stdint.h to our test. Please, ignore this patch.

					Thanks,
						Jaroslav

> Also we removed some of those files recently since they were not used by 
> the kernel, we only have abi.h, fw.h, header.h and tokens.h in this 
> directory, so that patch would not apply against Mark's tree.
> 
>>
>> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Mark Brown <broonie@kernel.org>
>> ---
>>   include/uapi/sound/sof/eq.h       | 4 ++++
>>   include/uapi/sound/sof/fw.h       | 4 ++++
>>   include/uapi/sound/sof/header.h   | 4 ++++
>>   include/uapi/sound/sof/manifest.h | 4 ++++
>>   include/uapi/sound/sof/trace.h    | 4 ++++
>>   5 files changed, 20 insertions(+)
>>
>> diff --git a/include/uapi/sound/sof/eq.h b/include/uapi/sound/sof/eq.h
>> index 666c2b6a3229..106d56e357e0 100644
>> --- a/include/uapi/sound/sof/eq.h
>> +++ b/include/uapi/sound/sof/eq.h
>> @@ -9,6 +9,10 @@
>>   #ifndef __INCLUDE_UAPI_SOUND_SOF_USER_EQ_H__
>>   #define __INCLUDE_UAPI_SOUND_SOF_USER_EQ_H__
>>   
>> +#ifndef __KERNEL__
>> +#include <stdint.h>
>> +#endif
>> +
>>   /* FIR EQ type */
>>   
>>   #define SOF_EQ_FIR_IDX_SWITCH	0
>> diff --git a/include/uapi/sound/sof/fw.h b/include/uapi/sound/sof/fw.h
>> index 1afca973eb09..4f2de19a3b86 100644
>> --- a/include/uapi/sound/sof/fw.h
>> +++ b/include/uapi/sound/sof/fw.h
>> @@ -13,6 +13,10 @@
>>   #ifndef __INCLUDE_UAPI_SOF_FW_H__
>>   #define __INCLUDE_UAPI_SOF_FW_H__
>>   
>> +#ifndef __KERNEL__
>> +#include <stdint.h>
>> +#endif
>> +
>>   #define SND_SOF_FW_SIG_SIZE	4
>>   #define SND_SOF_FW_ABI		1
>>   #define SND_SOF_FW_SIG		"Reef"
>> diff --git a/include/uapi/sound/sof/header.h b/include/uapi/sound/sof/header.h
>> index 7868990b0d6f..6a62ae8f0eb9 100644
>> --- a/include/uapi/sound/sof/header.h
>> +++ b/include/uapi/sound/sof/header.h
>> @@ -9,6 +9,10 @@
>>   #ifndef __INCLUDE_UAPI_SOUND_SOF_USER_HEADER_H__
>>   #define __INCLUDE_UAPI_SOUND_SOF_USER_HEADER_H__
>>   
>> +#ifndef __KERNEL__
>> +#include <stdint.h>
>> +#endif
>> +
>>   /*
>>    * Header for all non IPC ABI data.
>>    *
>> diff --git a/include/uapi/sound/sof/manifest.h b/include/uapi/sound/sof/manifest.h
>> index 2009ee30fad0..d57aa2bc4764 100644
>> --- a/include/uapi/sound/sof/manifest.h
>> +++ b/include/uapi/sound/sof/manifest.h
>> @@ -9,6 +9,10 @@
>>   #ifndef __INCLUDE_UAPI_SOUND_SOF_USER_MANIFEST_H__
>>   #define __INCLUDE_UAPI_SOUND_SOF_USER_MANIFEST_H__
>>   
>> +#ifndef __KERNEL__
>> +#include <stdint.h>
>> +#endif
>> +
>>   /* start offset for base FW module */
>>   #define SOF_MAN_ELF_TEXT_OFFSET		0x2000
>>   
>> diff --git a/include/uapi/sound/sof/trace.h b/include/uapi/sound/sof/trace.h
>> index ffa7288a0f16..1652bc08d576 100644
>> --- a/include/uapi/sound/sof/trace.h
>> +++ b/include/uapi/sound/sof/trace.h
>> @@ -9,6 +9,10 @@
>>   #ifndef __INCLUDE_UAPI_SOUND_SOF_USER_TRACE_H__
>>   #define __INCLUDE_UAPI_SOUND_SOF_USER_TRACE_H__
>>   
>> +#ifndef __KERNEL__
>> +#include <stdint.h>
>> +#endif
>> +
>>   /*
>>    * Host system time.
>>    *
>>
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

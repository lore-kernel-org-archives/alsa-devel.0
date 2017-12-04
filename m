From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC 06/10] ASoC: hdac_hda: add ASoC based HDA
 codec driver
Date: Mon, 4 Dec 2017 15:35:54 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AC5EED@BGSMSX104.gar.corp.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1512119648-2700-7-git-send-email-rakesh.a.ughreja@intel.com>
 <f3560882-d825-01c6-d3d4-b712bf46ea6d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 45954266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 16:36:00 +0100 (CET)
In-Reply-To: <f3560882-d825-01c6-d3d4-b712bf46ea6d@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Saturday, December 2, 2017 1:07 AM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; tiwai@suse.de; liam.r.girdwood@linux.intel.com
>Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [alsa-devel] [RFC 06/10] ASoC: hdac_hda: add ASoC based HDA
>codec driver
>
>On 12/1/17 3:14 AM, Rakesh Ughreja wrote:
>> This patch adds ASoC based HDA codec driver that can be used with
>> all Intel platforms.
>>
>> FIXME:
>> KConfig change allows users to compile legacy HDA codec drivers either
>> as ASoC or ALSA codec driver. This is not a good approach and need
>> suggestion to improve it.
>>
>> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>> ---
>>   sound/pci/hda/Kconfig         | 11 +++++
>>   sound/pci/hda/hda_codec.h     | 26 +++++++++++-
>>   sound/soc/codecs/Kconfig      |  6 +++
>>   sound/soc/codecs/Makefile     |  2 +
>>   sound/soc/codecs/hdac_hda.c   | 95
>+++++++++++++++++++++++++++++++++++++++++++
>>   sound/soc/codecs/hdac_hda.h   | 16 ++++++++
>>   sound/soc/intel/skylake/skl.c | 18 +++++++-
>>   7 files changed, 171 insertions(+), 3 deletions(-)
>>   create mode 100644 sound/soc/codecs/hdac_hda.c
>>   create mode 100644 sound/soc/codecs/hdac_hda.h
>>
>> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
>> index 7f3b5ed..010dd7d 100644
>> --- a/sound/pci/hda/Kconfig
>> +++ b/sound/pci/hda/Kconfig
>> @@ -215,6 +215,17 @@ config SND_HDA_GENERIC
>>   comment "Set to Y if you want auto-loading the codec driver"
>>   	depends on SND_HDA=y && SND_HDA_GENERIC=m
>>
>> +config SND_ASOC_HDA_GENERIC
>> +        bool "Build HDA drivers as HDA ASoC Codec drivers"
>> +	select SND_SOC_HDAC_HDA
>> +        def_bool n
>> +        help
>> +          Select to build legacy HD-audio codec drivers as ASoC
>> +          codec drivers.
>> +
>> +comment "Set to Y if you want to enable support for HDA audio codec with
>> +	 DSP on Intel platforms"
>> +
>>   config SND_HDA_POWER_SAVE_DEFAULT
>>   	int "Default time-out for HD-audio power-save mode"
>>   	depends on PM
>> diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
>> index 2d02d02..67ce2e6 100644
>> --- a/sound/pci/hda/hda_codec.h
>> +++ b/sound/pci/hda/hda_codec.h
>> @@ -104,9 +104,33 @@ int __hda_codec_driver_register(struct
>hda_codec_driver *drv, const char *name,
>>   #define hda_codec_driver_register(drv) \
>>   	__hda_codec_driver_register(drv, KBUILD_MODNAME, THIS_MODULE)
>>   void hda_codec_driver_unregister(struct hda_codec_driver *drv);
>> +
>> +/*
>> + * FIXME:
>> + * In this implementation one can compile codec drivers either as ALSA or as
>> + * ASoC, but not both.
>> + * This may be not the be the best way to build the HDA codec drivers as ALSA
>> + * vs ASoC driver. Need to find a better way, where the driver can be built
>> + * as ALSA as well as ASoC at the same time. Even though practically people
>> + * would never use them at the same time. But may be disto guys may want to
>> + * do it.
>
>Distros *have* to do it, since the DSP usage can be changed in
>user-visible BIOS settings or disabled.

Yes, agree.

>
>> + */
>> +
>> +#ifdef CONFIG_SND_ASOC_HDA_GENERIC
>> +int __hdac_hda_codec_driver_register(struct hda_codec_driver *drv,
>> +	const char *name, struct module *owner);
>> +#define hdac_hda_codec_driver_register(drv) \
>> +	__hdac_hda_codec_driver_register(drv, KBUILD_MODNAME,
>THIS_MODULE)
>> +void hdac_hda_codec_driver_unregister(struct hda_codec_driver *drv);
>> +
>> +#define module_hda_codec_driver(drv) \
>> +	module_driver(drv, hdac_hda_codec_driver_register, \
>> +			hdac_hda_codec_driver_unregister)
>> +#else
>>   #define module_hda_codec_driver(drv) \
>>   	module_driver(drv, hda_codec_driver_register, \
>> -		      hda_codec_driver_unregister)
>> +			hda_codec_driver_unregister)
>> +#endif
>
>Couldn't you use a common registration that internally checks if you are
>running in legacy or DSP/ASoC mode and branch accordingly?

Yes, this requires change in the legacy codec driver. Takashi also
suggested that we need to change the legacy driver code in order to make
it work. Now that we are okay to change the legacy driver source code,
I will come up with some proposal.

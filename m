From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA
	codec driver
Date: Fri, 15 Dec 2017 12:20:30 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579ADA90D@BGSMSX104.gar.corp.intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1513337448-31685-7-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hd13ggr18.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E906267B4F
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 13:20:37 +0100 (CET)
In-Reply-To: <s5hd13ggr18.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Friday, December 15, 2017 5:08 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul, Vinod
><vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [RFC v3 06/11] ASoC: hdac_hda: add ASoC based HDA codec driver
>
>On Fri, 15 Dec 2017 12:30:43 +0100,
>Rakesh Ughreja wrote:
>>
>> This patch adds ASoC based HDA codec driver that can be used with
>> all Intel platforms.
>>
>> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>> ---
>>  sound/pci/hda/hda_codec.h     |  1 +
>>  sound/pci/hda/hda_generic.c   | 25 ++++++++++++
>>  sound/soc/codecs/Kconfig      |  6 +++
>>  sound/soc/codecs/Makefile     |  2 +
>>  sound/soc/codecs/hdac_hda.c   | 94
>+++++++++++++++++++++++++++++++++++++++++++
>>  sound/soc/codecs/hdac_hda.h   | 22 ++++++++++
>>  sound/soc/intel/skylake/skl.c | 10 ++++-
>>  7 files changed, 158 insertions(+), 2 deletions(-)
>>  create mode 100644 sound/soc/codecs/hdac_hda.c
>>  create mode 100644 sound/soc/codecs/hdac_hda.h
>>
>> diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
>> index ef626cf..1525c5a 100644
>> --- a/sound/pci/hda/hda_codec.h
>> +++ b/sound/pci/hda/hda_codec.h
>> @@ -96,6 +96,7 @@ typedef int (*hda_codec_patch_t)(struct hda_codec *);
>>
>>  struct hda_codec_driver {
>>  	struct hdac_driver core;
>> +	struct hdac_driver *asocdrv;
>>  	const struct hda_device_id *id;
>>  };
>>
>> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
>> index 09ab02e..e0b46a4 100644
>> --- a/sound/pci/hda/hda_generic.c
>> +++ b/sound/pci/hda/hda_generic.c
>> @@ -38,6 +38,7 @@
>>  #include "hda_jack.h"
>>  #include "hda_beep.h"
>>  #include "hda_generic.h"
>> +#include "../../sound/soc/codecs/hdac_hda.h"
>>
>>
>>  /**
>> @@ -5964,12 +5965,36 @@ static int snd_hda_parse_generic_codec(struct
>hda_codec *codec)
>>  int __hda_codec_driver_register(struct hda_codec_driver *drv, const char
>*name,
>>  			       struct module *owner)
>>  {
>> +	int ret;
>> +
>> +	/*
>> +	 * Register ASoC HDA driver as well
>> +	 */
>> +	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)) {
>> +
>> +		drv->core.id_table = drv->id;
>> +		drv->asocdrv = kmalloc(sizeof(*drv->asocdrv), GFP_KERNEL);
>> +		if (!drv->asocdrv)
>> +			return -ENOMEM;
>> +
>> +		ret = __hdac_hda_codec_driver_register(&drv->core, name,
>owner);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>
>Hrm, now I see why you moved the function.
>But this change essentially means that the code-path is always enabled
>when the ASoC HD-audio driver is *built*.  Distros may build both but
>blacklist, and it would break the legacy driver.

In this series, I am registering the driver two times. First using generic
ASoC driver and then using Generic legacy driver. I am appending "-asoc"
string to the driver name while registering for ASoC HDA, so do second
time registration.

Are you suggesting that I should do only once ? Now I understand that
there is no point in doing two times registration.

>
>Can we check differently?  For example, we may put some difference in
>the driver and check it here instead of the static IS_ENABLED().

Do you think a module parameter is a good idea ?

>The code can be put with #if IS_ENABLED() for optimization, but the
>actual behavior should be runtime-dependent.

Sure, I will do it.

>
>
>thanks,
>
>Takashi

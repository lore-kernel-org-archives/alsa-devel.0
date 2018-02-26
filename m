From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v1 5/9] ALSA: hda - split snd_hda_codec_new
	function
Date: Mon, 26 Feb 2018 08:28:56 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B29AC2@BGSMSX104.gar.corp.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-6-git-send-email-rakesh.a.ughreja@intel.com>
 <96204f32-54ea-baaa-c3ed-94774f7728c5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DB35267A0F
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 09:29:25 +0100 (CET)
In-Reply-To: <96204f32-54ea-baaa-c3ed-94774f7728c5@linux.intel.com>
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
>Sent: Friday, February 23, 2018 10:20 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; tiwai@suse.de;
>liam.r.girdwood@linux.intel.com
>Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [PATCH v1 5/9] ALSA: hda - split snd_hda_codec_new function
>
>On 2/23/18 2:12 AM, Rakesh Ughreja wrote:
>> Split snd_hda_codec_new into two separate functions.
>> snd_hda_codec_device_init allocates memory and registers with bus.
>> snd_hda_codec_device_new initialializes the fields and performs
>> snd_device_new. This enables reuse of legacy HDA codec drivers as ASoC
>> codec drivers.
>>
>> In addition mark some functions with EXPORT_SYMBOL_GPL so that it can be
>> called by ASoC codec drivers.
>
>I don't get the commit message.
>You first say that we can now reuse legacy HDaudio codec drivers in an
>ASoC framework, then say that there will be additional ASoC codec
>drivers? Why would we do this, it seems like a contradicting goal?
>

Yes, its misleading, so correcting the line as,

In addition mark some functions with EXPORT_SYMBOL_GPL so that it can be
called by ASoC wrapper around the legacy HDA driver (hdac_hda).

>>
>> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>> ---
>>   sound/pci/hda/hda_codec.c | 67 +++++++++++++++++++++++++++++++++++--
>----------
>>   sound/pci/hda/hda_codec.h |  2 ++
>>   2 files changed, 52 insertions(+), 17 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
>> index 5bc3a74..c487411 100644
>> --- a/sound/pci/hda/hda_codec.c
>> +++ b/sound/pci/hda/hda_codec.c
>> @@ -856,6 +856,38 @@ static void snd_hda_codec_dev_release(struct device
>*dev)
>>   	kfree(codec);
>>   }
>>
>> +static int snd_hda_codec_device_init(struct hda_bus *bus, struct snd_card
>*card,
>> +			unsigned int codec_addr, struct hda_codec **codecp)
>> +{
>> +	int err;
>> +	char component[31];
>
>looks like magic number?

I kept it as it was in the previous code, but now defined a macro
#define COMPONENT_NAME_SIZE 31

>
>> +	struct hda_codec *codec;
>
>reverse x-mas tree order?

Yes, changed.

Regards,
Rakesh

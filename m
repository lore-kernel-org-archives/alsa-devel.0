From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Tue, 27 Feb 2018 03:34:43 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B2AAE9@BGSMSX104.gar.corp.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-9-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hmv00ggc4.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579B2A211@BGSMSX104.gar.corp.intel.com>
 <s5h606krqt1.wl-tiwai@suse.de>
 <48068a1a-7638-292f-bab4-ca0c2446c595@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 899CC267ADD
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 04:34:53 +0100 (CET)
In-Reply-To: <48068a1a-7638-292f-bab4-ca0c2446c595@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Tuesday, February 27, 2018 12:49 AM
>To: Takashi Iwai <tiwai@suse.de>; Ughreja, Rakesh A
><rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; Koul, Vinod <vinod.koul@intel.com>;
>liam.r.girdwood@linux.intel.com; Patches Audio <patches.audio@intel.com>;
>broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension for
>legacy HDA codec drivers
>
>On 2/26/18 3:25 AM, Takashi Iwai wrote:
>> On Mon, 26 Feb 2018 11:11:44 +0100,
>> Ughreja, Rakesh A wrote:
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>> Sent: Friday, February 23, 2018 3:48 PM
>>>> To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>>>> Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>>>> liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul,
>>>> Vinod <vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>>>> Subject: Re: [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension for legacy
>HDA
>>>> codec drivers
>>>>
>>>> On Fri, 23 Feb 2018 09:12:29 +0100,
>>>> Rakesh Ughreja wrote:
>>>>>
>>>>> +static int hdac_hda_codec_probe(struct snd_soc_codec *codec)
>>>>> +{
>>>>> +	struct hdac_hda_priv *hda_pvt = snd_soc_codec_get_drvdata(codec);
>>>>> +	struct snd_soc_dapm_context *dapm =
>>>>> +			snd_soc_component_get_dapm(&codec-
>>>>> component);
>>>>> +	struct hdac_device *hdev = &hda_pvt->codec.core;
>>>>> +	struct hda_codec *hcodec = &hda_pvt->codec;
>>>>> +	struct hdac_ext_link *hlink = NULL;
>>>>> +	hda_codec_patch_t patch;
>>>>> +	int ret, i = 0;
>>>>> +	u16 codec_mask;
>>>>> +
>>>>> +	hda_pvt->scodec = codec;
>>>>> +	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
>>>>> +	if (!hlink) {
>>>>> +		dev_err(&hdev->dev, "hdac link not found\n");
>>>>> +		return -EIO;
>>>>> +	}
>>>>> +
>>>>> +	ret = snd_hdac_ext_bus_link_get(hdev->bus, hlink);
>>>>
>>>> So this is the essential part for the ext-hda stuff.  But...
>>>>
>>>>> +
>>>>> +	udelay(1000);
>>>>> +	do {
>>>>> +		codec_mask = snd_hdac_chip_readw(hdev->bus, STATESTS);
>>>>> +		if (codec_mask)
>>>>> +			break;
>>>>> +		i++;
>>>>> +		udelay(100);
>>>>> +	} while (i < 100);
>>>>> +
>>>>> +	if (!codec_mask) {
>>>>> +		dev_err(&hdev->dev, "No codecs found after link reset\n");
>>>>> +		return -EIO;
>>>>> +	}
>>>>> +
>>>>> +	snd_hdac_chip_writew(hdev->bus, STATESTS, STATESTS_INT_MASK);
>>>>
>>>> Why do you need this?  The callback gets called by the HD-audio
>>>> controller driver and it already should have checked the codec mask
>>>> bits.
>>>
>>> With the multiple link support on the same HDA controller, when the link
>>> gets turned ON immediately codec may not indicate its presence. As per
>>> the HDA spec, it may take up to 521uSec before the codec responds.
>>>
>>> In the legacy HDA the link was turned ON/OFF only during CRST time, but
>>> now it can happen anytime.
>>
>> This must be documented.  Otherwise no one understands it.
>>
>> And I still don't think such stuff belonging to the codec driver.
>> It's rather a job of the controller driver to assure the codec access.
>> If any, we should fix that side instead.
>
>
>I missed what the 'multiple-link' notion means or which part of the spec
>this is referring to?
>The code here assumes one analog codec and one iDisp, there isn't any
>support for additional codecs.
>What am I missing?

HDA Spec section 4.3 - Codec discovery.
In SKL onwards there are two links and both are individually
powered ON/OFF.

Regards,
Rakesh

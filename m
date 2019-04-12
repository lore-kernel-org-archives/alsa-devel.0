From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ASoC: codec: hdac_hdmi add device_link to
 card device
Date: Fri, 12 Apr 2019 13:54:29 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19528194BC@SHSMSX103.ccr.corp.intel.com>
References: <1555036832-2850-1-git-send-email-libin.yang@intel.com>
 <8c33f4c2-39ce-a620-b540-c933e4157b83@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D1952818DDD@SHSMSX103.ccr.corp.intel.com>
 <bad8c9b5-1ee4-d34c-4145-b294a60d3a02@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E680F89616
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 15:54:34 +0200 (CEST)
In-Reply-To: <bad8c9b5-1ee4-d34c-4145-b294a60d3a02@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Friday, April 12, 2019 9:52 PM
>To: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org;
>tiwai@suse.de; broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH] ASoC: codec: hdac_hdmi add device_link to
>card device
>
>
>>>> +	device_link_add(component->card->dev, &hdev->dev,
>>> DL_FLAG_RPM_ACTIVE |
>>>> +			DL_FLAG_AUTOREMOVE_CONSUMER);
>>>
>>> Should device_link_free() be added to hdmi_codec_remove then?
>>
>> As Takashi suggested, I add the DL_FLAG_AUTOREMOVE_CONSUMER flag.
>> This will make sure the link will be freed when machine driver are removed.
>> And as machine driver depends on the hdac_hdmi module, when
>> hdmi_codec_remove() is called, the link is freed already.
>
>ok, maybe adding a comment would help dummies like me who didn't know
>about this flag? Thanks!

Thanks for suggestion. I will add the comment.

Regards,
Libin

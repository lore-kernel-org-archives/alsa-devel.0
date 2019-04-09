From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ASoC: cAVS: add device_link to HDMI audio
Date: Tue, 9 Apr 2019 01:09:10 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952816A1F@SHSMSX103.ccr.corp.intel.com>
References: <1554686513-7770-1-git-send-email-libin.yang@intel.com>
 <70a4cd39-bf42-6c2c-6b3f-ffc343b016d1@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D19528165F4@SHSMSX103.ccr.corp.intel.com>
 <cf76f322-f470-0815-d8a2-f89090519734@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A36AF8076C
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 03:11:54 +0200 (CEST)
In-Reply-To: <cf76f322-f470-0815-d8a2-f89090519734@linux.intel.com>
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
>Sent: Monday, April 8, 2019 10:43 PM
>To: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org;
>tiwai@suse.de; broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH] ASoC: cAVS: add device_link to HDMI audio
>
>
>>> 2. if this is really a generic issue then shouldn't it be fixed for
>>> all users of the iDISP link? Why stop at the HDAudio machine driver?
>>
>> I will submit other patches for other machine drivers. Which HDAudio
>> machine driver do you mean?
>
>if you plan on updating other drivers, then by all means let's use a common
>set of helper functions. I see you have follow-up patches on github already,
>let's avoid copy/paste if possible if the same functionality is needed in
>multiple places.

Sure, I will do it. Thanks for suggestion.

>
>>>
>>> 3. we already have the component model to deal with interaction between
>>> i915 and audio, now we are adding a second layer. That looks clunky.
>>
>> The component model between i915 and audio is used to communicate
>> between display driver and audio driver. This patch is used to setup the
>> consumer and supplier relationship.
>
>consumer of what? it's very vague for people who haven't really looked
>into the details.

In our case, the consumer is the machine device, and it's the consumer
of the HDMI codec device. I will add the comments in the patch.

Regards,
Libin

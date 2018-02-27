From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v1 9/9] ASoC: Intel: Boards: add support
 for HDA codecs
Date: Tue, 27 Feb 2018 17:06:50 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B2B32D@BGSMSX104.gar.corp.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-10-git-send-email-rakesh.a.ughreja@intel.com>
 <2536565b-4783-0829-536e-ee24e435c041@linux.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579B2A59B@BGSMSX104.gar.corp.intel.com>
 <9bcab530-3517-5a27-7a49-65af8aff6ba5@linux.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579B2B1C8@BGSMSX104.gar.corp.intel.com>
 <s5hr2p6nziy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 10D4A2676D7
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 18:06:55 +0100 (CET)
In-Reply-To: <s5hr2p6nziy.wl-tiwai@suse.de>
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
 Vinod" <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, February 27, 2018 10:25 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; liam.r.girdwood@linux.intel.com; Koul, Vinod
><vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [alsa-devel] [PATCH v1 9/9] ASoC: Intel: Boards: add support for HDA
>codecs
>
>On Tue, 27 Feb 2018 17:20:05 +0100,
>Ughreja, Rakesh A wrote:
>>
>> >> The hdac_hda is just a wrapper around the legacy codec driver
>> >> and so it relies on the functionality of the legacy HDA codec driver
>> >> for all the functionality including pin re-tasking.
>> >>
>> >> The widget names that you see above is just to complete the
>> >> DAPM route. Based on your comment I am planning to rename it as
>> >> following
>> >>
>> >> Analog In Endpoint
>> >> Analog Output Endpoint
>> >> Digital In Endpoint
>> >> Digital Out Endpoint
>> >>
>> >> and will connect it to the Codec Pins.
>> >>
>> >> Also I think it makes sense to rename the codec Pin names accordingly
>> >>
>> >> Codec Analog Input Pin
>> >> Codec Analog Output Pin
>> >> Codec Digital Input Pin
>> >> Codec Digital Output Pin
>> >
>> >Humm, what if you have more than one analog input? It's almost as if
>> >this list should be created dynamically based on what is exposed by the
>> >codec, I don't see how a static list will cover all configurations.
>>
>> If it is really required it can be done, the codec->pcm_list_head has got
>> entries stored.
>>
>> But I am not sure what is the behavior of the legacy HDA codec driver
>> when it sees more than one Analog inputs.
>>
>> Takashi, will I see two Analog entries in the pcm_list_head ?
>
>Yes, in a few cases, the generic parser creates another PCM for analog
>I/O as "Alt Analog":

But this again is static and its named as "Alt Analog". 
So, in the current code if I just create one more as "Alt Analog" DAI
it should be fine ?

I do map them by searching the pcm_list_head when the application
opens them.

Will I see more than one "Analog" and "Alt Analog" ever in the
pcm_list_head ? or at max I am going to see one "Analog" and an
additional "Alt Analog" PCM.

Regards,
Rakesh

From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v1 5/9] ALSA: hda - split
	snd_hda_codec_new	function
Date: Mon, 26 Feb 2018 09:09:54 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B2A1B1@BGSMSX104.gar.corp.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-6-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hpo4vhco5.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579B29AE3@BGSMSX104.gar.corp.intel.com>
 <s5hefl8gn2k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id F0B80267A2F
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 10:10:01 +0100 (CET)
In-Reply-To: <s5hefl8gn2k.wl-tiwai@suse.de>
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
>Sent: Monday, February 26, 2018 2:11 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; Koul, Vinod <vinod.koul@intel.com>; Patches
>Audio <patches.audio@intel.com>; pierre-louis.bossart@linux.intel.com
>Subject: Re: [alsa-devel] [PATCH v1 5/9] ALSA: hda - split snd_hda_codec_new
>function
>
>On Mon, 26 Feb 2018 09:33:01 +0100,
>Ughreja, Rakesh A wrote:
>>
>>
>>
>> >-----Original Message-----
>> >From: Takashi Iwai [mailto:tiwai@suse.de]
>> >Sent: Friday, February 23, 2018 10:22 PM
>> >To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>> >Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>> >liam.r.girdwood@linux.intel.com; Koul, Vinod <vinod.koul@intel.com>;
>Patches
>> >Audio <patches.audio@intel.com>; pierre-louis.bossart@linux.intel.com
>> >Subject: Re: [alsa-devel] [PATCH v1 5/9] ALSA: hda - split snd_hda_codec_new
>> >function
>> >
>> >On Fri, 23 Feb 2018 09:12:26 +0100,
>> >Rakesh Ughreja wrote:
>> >>
>> >> +int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card
>*card,
>> >> +			unsigned int codec_addr, struct hda_codec *codec)
>> >> +{
>> >>  	char component[31];
>> >
>> >Unused after the patch?
>>
>> We still use the component variable to construct the name, so I think we still
>> need it. Following code,
>>
>> +	sprintf(component, "hdaudioC%dD%d", card->number, codec_addr);
>> +	err = snd_hdac_device_init(&codec->core, &bus->core, component,
>> +				   codec_addr);
>
>Ah yeah, I re-sused the variable for the name string.
>It should have been named as "name" or such.

Let me correct it then. I will rename it to char name[DEVICE_NAME_LEN];

Regards,
Rakesh

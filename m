From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Tue, 7 Jul 2009 12:46:38 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC23C9@bgsmsx501.gar.corp.intel.com>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<s5hzlblhk4v.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5BBC2280@bgsmsx501.gar.corp.intel.com>
	<s5heistasy0.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5BBC23A6@bgsmsx501.gar.corp.intel.com>
	<s5hab3harxd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 915EB1038BC
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 09:17:40 +0200 (CEST)
In-Reply-To: <s5hab3harxd.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> >> >
>> >> >> +	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
>> >> >> +	.info 		=	snd_intelmad_line_volume_info,
>> >> >> +	.get 		=	snd_intelmad_volume_get,
>> >> >> +	.put		=	snd_intelmad_volume_set,
>> >> >
>> >> >Can it have the dB information via TLV?
>> >> No. It actually differs across the 3 sound cards supported and it's
>> >> not a direct TLV that can be used.
>> >
>> >Then you'd set a static TLV entry after creating the ctl element
>> >instance, or return a TLV entry dynamically via the tlv callback.
>> Sorry I misunderstood. The value that is passed in min and max is in
>> dB.
>> For min and max values, it's a static dB value that I return. But
>> when the volume adjustments need to be done, based on the value
>> given by ALSA, I set the sound card registers to reflect that dB
>> value.
>
>The value to be set is always raw.  That is, alsa-lib computes the
>raw value from the given dB value based on the TLV information (dB
>min/max), supposing the volume scale is logarithmic.
>
>Isn't it the case for you?
Yes. I set the raw min and max values in db. And alsa-lib computes the volume value to be set (which is in between the min and max) and provides the same to the driver. The driver sets the corresponding sound card registers to reflect the same. In our case, the scale is not logarithmic in couple of sound cards and the vendor abstraction file would need to take care of the same to set the registers correctly.

>
>> When volume is queried for, I read the specific sound card
>> register and return the dB value to ALSA.
>> Will this implementation be ok?
>
>
>Takashi

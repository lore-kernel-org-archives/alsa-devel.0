From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Tue, 7 Jul 2009 11:50:46 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC2280@bgsmsx501.gar.corp.intel.com>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<s5hzlblhk4v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 273C9246B2
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:21:42 +0200 (CEST)
In-Reply-To: <s5hzlblhk4v.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
>> +	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
>> +	.info 		=	snd_intelmad_line_volume_info,
>> +	.get 		=	snd_intelmad_volume_get,
>> +	.put		=	snd_intelmad_volume_set,
>
>Can it have the dB information via TLV?
No. It actually differs across the 3 sound cards supported and it's not a direct TLV that can be used.

Thanks,
Harsha

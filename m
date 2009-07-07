From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 5/13] Intel SST driver interface
 module
Date: Tue, 7 Jul 2009 11:52:37 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC2291@bgsmsx501.gar.corp.intel.com>
References: <1246604638-12896-1-git-send-email-vinod.koul@intel.com>
	<s5hfxde2f47.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5BBC2232@bgsmsx501.gar.corp.intel.com>
	<s5hmy7haui1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 20A2B246B2
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:23:12 +0200 (CEST)
In-Reply-To: <s5hmy7haui1.wl%tiwai@suse.de>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "R,
	Dharageswari" <dharageswari.r@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, July 07, 2009 11:46 AM
>To: Harsha, Priya
>Cc: Koul, Vinod; alsa-devel@alsa-project.org; R, Dharageswari
>Subject: Re: [alsa-devel] [PATCH] [RFC 5/13] Intel SST driver interface
>module
>
>At Tue, 7 Jul 2009 11:38:54 +0530,
>Harsha, Priya wrote:
>>
>> >> +void set_port_params(struct snd_sst_params *str_param,
>> >> +				enum snd_sst_stream_ops ops)
>> >
>> >Is it a global function??
>> Yes it is prototype defined in intel_sst_common.h
>
>Then the name is way too generic.
Sure. I'll update them. Ill also make sure that every function name use is not a too generic before next submission.

>
>
>Takashi

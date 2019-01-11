From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi
	audio	suspend/resume
Date: Fri, 11 Jan 2019 14:35:34 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527B044F@SHSMSX103.ccr.corp.intel.com>
References: <1546827721-25586-1-git-send-email-libin.yang@intel.com>
 <e2c257fb-e292-b23d-1f20-e5467e0d93dd@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D19527AE0B4@SHSMSX103.ccr.corp.intel.com>
 <s5hd0p71jvh.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AE92B@SHSMSX103.ccr.corp.intel.com>
 <s5h8szui68f.wl-tiwai@suse.de>	<s5h4laii46l.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AF06F@SHSMSX103.ccr.corp.intel.com>
 <s5h4lagyagb.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AFEB3@SHSMSX103.ccr.corp.intel.com>
 <s5hd0p3mi6t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 801C8266914
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 15:35:38 +0100 (CET)
In-Reply-To: <s5hd0p3mi6t.wl-tiwai@suse.de>
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Friday, January 11, 2019 9:35 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: liam.r.girdwood@linux.intel.com; Lin, Mengdong
><mengdong.lin@intel.com>; alsa-devel@alsa-project.org; broonie@kernel.org;
>Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>Subject: Re: [alsa-devel] [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi audio
>suspend/resume
>
>On Fri, 11 Jan 2019 06:20:23 +0100,
>Yang, Libin wrote:
>>
>> The below patch may have a small confliction that the trigger will be
>> called twice as our SOF has already call snd_pcm_suspend() in card
>> suspend.
>
>It should be no problem, snd_pcm_suspend() can be called multiple times.  If
>it's already suspended, just nothing happens.

Got it. Thanks.

Regards,
Libin

>
>
>thanks,
>
>Takashi

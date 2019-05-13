From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH V2] ASoC: soc-pcm: BE dai needs prepare
 when pause release after resume
Date: Mon, 13 May 2019 01:09:52 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195283A385@SHSMSX103.ccr.corp.intel.com>
References: <1557282761-26146-1-git-send-email-libin.yang@intel.com>
 <aa0c6eea81a721f340dd1362801e49049a6620dd.camel@linux.intel.com>
 <s5htve4mymn.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1952838E47@SHSMSX103.ccr.corp.intel.com>
 <20190512080756.GI21483@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19458F8961A
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 03:10:00 +0200 (CEST)
In-Reply-To: <20190512080756.GI21483@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, "Wang,
 Rander" <rander.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Sunday, May 12, 2019 4:08 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: Takashi Iwai <tiwai@suse.de>; Ranjani Sridharan
><ranjani.sridharan@linux.intel.com>; alsa-devel@alsa-project.org; Sridharan,
>Ranjani <ranjani.sridharan@intel.com>; pierre-louis.bossart@linux.intel.com;
>Wang, Rander <rander.wang@intel.com>
>Subject: Re: [alsa-devel] [PATCH V2] ASoC: soc-pcm: BE dai needs prepare
>when pause release after resume
>
>On Thu, May 09, 2019 at 02:30:39AM +0000, Yang, Libin wrote:
>
>> I think this may be a ASoC FE-BE defect.
>> In this case, ASoC will call FE dai prepare(), but it will not call BE
>> dai prepare() because of the judgement. This is why I made the patch.
>
>If it's calling only the front end but not the back end that definitely sounds like
>DPCM is causing trouble again.

Yes. This is caused by dpcm_be_dai_prepare(). dpcm_be_dai_prepare()
should call BE dai prepare() in the case of pause release after S3.
But as the be->dpcm[stream].state is SND_SOC_DPCM_STATE_PAUSED,
it will not call BE dai prepare.

Regards,
Libin

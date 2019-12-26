Return-Path: <SRS0=4Kwc=2Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1243C2D0DA
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Dec 2019 09:16:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F9C2080D
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Dec 2019 09:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n0YfbMaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F9C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EEE016E8;
	Thu, 26 Dec 2019 10:16:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EEE016E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577351815;
	bh=mhAoBc5fILCdHE6W7AUXVXPL6c0Wzm+hRndrN3yIckw=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n0YfbMazCFXWM15/tqxM/Pbe5bGeCUGmRcn5SEFDOIL4ZIwGzCtCVfp1erkHADQkm
	 3A/2cRbs5tTwWNYVfcclQV3AOemtgd5K+m5fD7l0aZ/b3KoBwD3+JWLkZSPZvqBrzm
	 jBqQ7eXszGtvPHNnwCD3m2SllX5UKuhYhCeBa/OA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE0AAF80138;
	Thu, 26 Dec 2019 10:16:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6C19F80139; Thu, 26 Dec 2019 10:16:02 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C485BF8012E
 for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2019 10:15:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C485BF8012E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Dec 2019 01:15:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,358,1571727600"; d="scan'208";a="212325303"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga008.jf.intel.com with ESMTP; 26 Dec 2019 01:15:41 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Dec 2019 01:15:40 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Dec 2019 01:15:40 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.19]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.90]) with mapi id 14.03.0439.000;
 Thu, 26 Dec 2019 17:15:38 +0800
From: "Liao, Bard" <bard.liao@intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Bard liao
 <yung-chuan.liao@linux.intel.com>
Thread-Topic: [PATCH RFC 1/3] ASoC: Add initial support for multiple CPU DAIs
Thread-Index: AQHVu7vHh/BgXJtR00az77gX2e7FjafLjA2AgACSG6A=
Date: Thu, 26 Dec 2019 09:15:38 +0000
Message-ID: <567A313375B6F043A9BE3A1D9B8C6E7F0B4D2C61@SHSMSX101.ccr.corp.intel.com>
References: <20191225191501.23848-1-yung-chuan.liao@linux.intel.com>
 <20191225191501.23848-2-yung-chuan.liao@linux.intel.com>
 <87tv5nsdqo.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87tv5nsdqo.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "tiwai@suse.de" <tiwai@suse.de>,
 "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH RFC 1/3] ASoC: Add initial support for
	multiple CPU DAIs
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



> -----Original Message-----
> From: Kuninori Morimoto [mailto:kuninori.morimoto.gx@renesas.com]
> Sent: Thursday, December 26, 2019 4:17 PM
> To: Bard liao <yung-chuan.liao@linux.intel.com>
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; tiwai@suse.de;
> liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Liao,
> Bard <bard.liao@intel.com>
> Subject: Re: [PATCH RFC 1/3] ASoC: Add initial support for multiple CPU DAIs
> 
> 
> Hi Bard
> 
> Actually I have plan to post semi-multi CPU DAI support as part of ASoC cleanup.
> The reason why "semi-multi" is that I can't test all features.
> It cares Multi-CPU as much as possible.
> 
> Thus, your and my patches are 100% conflict :) But, it is OK for me.
> I'm happy to adjust to yours.
> 
> Some comment from me
> 
> > From: Shreyas NC <shreyas.nc@intel.com>
> >
> > ASoC core supports multiple codec DAIs but supports only a CPU DAI.
> > To support multiple cpu DAIs, add cpu_dai and num_cpu_dai in
> > snd_soc_dai_link and snd_soc_pcm_runtime structures similar to support
> > for codec_dai. This is intended as a preparatory patch to eventually
> > support the unification of the Codec and CPU DAI.
> >
> > Inline with multiple codec DAI approach, add support to allocate,
> > init, bind and probe multiple cpu_dai on init if driver specifies
> > that. Also add support to loop over multiple cpu_dai during suspend
> > and resume.
> >
> > This is intended as a preparatory patch to eventually unify the CPU
> > and Codec DAI into DAI components.
> >
> > Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > ---
> (snip)
> > @@ -1149,6 +1154,9 @@ struct snd_soc_pcm_runtime {
> >  	struct snd_soc_dai **codec_dais;
> >  	unsigned int num_codecs;
> >
> > +	struct snd_soc_dai **cpu_dais;
> > +	unsigned int num_cpu_dai;
> 
> Codec is using "num_codecs";
> So, I think "num_cpus" is better for CPU.

Agree. I will update it.

> 
> 
> > @@ -1020,14 +1036,6 @@ static int soc_dai_link_sanity_check(struct
> snd_soc_card *card,
> >  			return -EPROBE_DEFER;
> >  	}
> >
> > -	/* FIXME */
> > -	if (link->num_cpus > 1) {
> > -		dev_err(card->dev,
> > -			"ASoC: multi cpu is not yet supported %s\n",
> > -			link->name);
> > -		return -EINVAL;
> > -	}
> > -
> >  	/*
> >  	 * CPU device may be specified by either name or OF node, but
> >  	 * can be left unspecified, and will be matched based on DAI
> 
> I think you want to sanity check for each CPU DAI by using
> for_each_rtd_cpu_dai() here, not only removing FIXME ?

Sure, thanks for reminding.

> 
> 
> 
> 
> In my quick check, I think your patch-set doesn't care these functions ?
> # Mine version is also doesn't care. Thus it indicates warning message there.
> # Because I'm not sure how to handle these...
> 
> 	- soc_init_pcm_runtime()
> 	- snd_dmaengine_pcm_prepare_slave_config()
> 	- dmaengine_pcm_set_runtime_hwparams()
> 	- dmaengine_pcm_compat_request_channel()
> 	- dpcm_state_read_file()
> 	- dpcm_path_get()
> 	- dpcm_runtime_merge_chan()
> 	- soc_new_pcm()
> 	- soc_dpcm_fe_runtime_update()
> 
> For soc_new_pcm(), I think you need to care playback/capture flag for Multi-
> CPU/Codec.
> 
> For soc_dpcm_fe_runtime_update(),
> you need to care about Multi-CPU.
> But, it doesn't care Multi-Codec, either...
> 
> I attached mine version.

Thank you very much for the comments and patch.
I will read your version and merge our versions.
Thanks again for the quick reply.

> 
> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

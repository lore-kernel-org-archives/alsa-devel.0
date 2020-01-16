Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCAC32771
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:06:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD83E2081E
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bbnWdmah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD83E2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3703A17AE;
	Thu, 16 Jan 2020 03:06:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3703A17AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579140415;
	bh=JI0GkKoF4PTldyWDg06NyLaUDMQlLifH8VESgt5vk0g=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bbnWdmahLyBuL1t79ZtD+icmALJeGzy8yECDLREb+USHh+vuiCAmfniYWk9pJV7ek
	 eRmCILN8IxVxFyXI3Yc/K8uAUOYNPr++TZkCusAzKiq3KEitU7RV74vua+90f0E/vL
	 JktV6rDE95BTofR3ZmfEJN+5JhGlqUW3cxF7HVwo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC907F8014B;
	Thu, 16 Jan 2020 03:06:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39B79F801EB; Thu, 16 Jan 2020 03:06:02 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED8BAF800E9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 03:05:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED8BAF800E9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 18:05:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,324,1574150400"; d="scan'208";a="213914034"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga007.jf.intel.com with ESMTP; 15 Jan 2020 18:05:53 -0800
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 18:05:52 -0800
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jan 2020 10:05:41 +0800
Received: from shsmsx606.ccr.corp.intel.com ([10.109.6.216]) by
 SHSMSX606.ccr.corp.intel.com ([10.109.6.216]) with mapi id 15.01.1713.004;
 Thu, 16 Jan 2020 10:05:41 +0800
From: "Liao, Bard" <bard.liao@intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard liao
 <yung-chuan.liao@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, 
 "tiwai@suse.de" <tiwai@suse.de>
Thread-Topic: [alsa-devel] [PATCH RFC v2 2/4] ASoC: Add multiple CPU DAI
 support for PCM ops
Thread-Index: AQHVy2dlf4WgbR04fk2eit1O7SrIZ6fsASKAgACJbdA=
Date: Thu, 16 Jan 2020 02:05:41 +0000
Message-ID: <eb5f5e4115a14c46bccd034f1127a5a3@intel.com>
References: <20200114175152.3291-1-yung-chuan.liao@linux.intel.com>
 <20200114175152.3291-3-yung-chuan.liao@linux.intel.com>
 <dc9075b8-7418-e910-47cd-eb181a4d9028@linux.intel.com>
In-Reply-To: <dc9075b8-7418-e910-47cd-eb181a4d9028@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-originating-ip: [10.239.127.36]
MIME-Version: 1.0
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] [PATCH RFC v2 2/4] ASoC: Add multiple CPU DAI
 support for PCM ops
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
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Thursday, January 16, 2020 9:48 AM
> To: Bard liao <yung-chuan.liao@linux.intel.com>; broonie@kernel.org;
> tiwai@suse.de
> Cc: alsa-devel@alsa-project.org; liam.r.girdwood@linux.intel.com;
> kuninori.morimoto.gx@renesas.com; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [alsa-devel] [PATCH RFC v2 2/4] ASoC: Add multiple CPU DAI
> support for PCM ops
> 
> 
> > @@ -1810,18 +1972,22 @@ static int dpcm_apply_symmetry(struct
> snd_pcm_substream *fe_substream,
> >   {
> >   	struct snd_soc_dpcm *dpcm;
> >   	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
> > -	struct snd_soc_dai *fe_cpu_dai = fe->cpu_dai;
> > +	struct snd_soc_dai *fe_cpu_dai;
> >   	int err;
> > +	int i;
> >
> >   	/* apply symmetry for FE */
> >   	if (soc_pcm_has_symmetry(fe_substream))
> >   		fe_substream->runtime->hw.info |=
> SNDRV_PCM_INFO_JOINT_DUPLEX;
> >
> >   	/* Symmetry only applies if we've got an active stream. */
> > -	if (fe_cpu_dai->active) {
> > -		err = soc_pcm_apply_symmetry(fe_substream, fe_cpu_dai);
> > -		if (err < 0)
> > -			return err;
> > +	/* Do we need to support Multi cpu for FE? */
> > +	for_each_rtd_cpu_dai(fe, i, fe_cpu_dai) {
> > +		if (fe_cpu_dai->active) {
> > +			err = soc_pcm_apply_symmetry(fe_substream,
> fe_cpu_dai);
> > +			if (err < 0)
> > +				return err;
> > +		}
> 
> that part seems inconsistent with Patch 4 where you add warnings/error
> everywhere there's a FE with num_cpus>1

Actually, I have a question here. Do we need to support Multi cpu for FE?
If yes, what is the use case? 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

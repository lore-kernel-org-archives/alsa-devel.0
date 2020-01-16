Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1C2C32771
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:26:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D3B222C3
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GnnBEy4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D3B222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F101117B5;
	Thu, 16 Jan 2020 03:25:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F101117B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579141563;
	bh=e9ZohhahC0jq1dNoTBOXGocdAid9y+tO4nXjk3xFykU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GnnBEy4kWJIlAsnLTp/OV40rA21Q77cQzIYQUgeBOWCDHmQLHrZraLBT6qL2Q4tJ7
	 6K7yrbz0fAXsG+ao58YcVq+ONDDRqHYkSAD6WolDZuvwpWYsBf+5zdOj2HJ8iGGZ2q
	 fNCe+Bai8VfQO4e2G8TdquXSp2qns0nlSfCbO2As=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 834A0F80086;
	Thu, 16 Jan 2020 03:25:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02822F8014E; Thu, 16 Jan 2020 03:25:10 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44578F80086
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 03:25:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44578F80086
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 18:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,324,1574150400"; d="scan'208";a="423848262"
Received: from cecox1-mobl.amr.corp.intel.com (HELO [10.251.131.55])
 ([10.251.131.55])
 by fmsmga005.fm.intel.com with ESMTP; 15 Jan 2020 18:25:03 -0800
To: "Liao, Bard" <bard.liao@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>
References: <20200114175152.3291-1-yung-chuan.liao@linux.intel.com>
 <20200114175152.3291-3-yung-chuan.liao@linux.intel.com>
 <dc9075b8-7418-e910-47cd-eb181a4d9028@linux.intel.com>
 <eb5f5e4115a14c46bccd034f1127a5a3@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <80b2ed69-666a-90e4-0548-53b952f5bd6d@linux.intel.com>
Date: Wed, 15 Jan 2020 20:25:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <eb5f5e4115a14c46bccd034f1127a5a3@intel.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


>>> +	/* Do we need to support Multi cpu for FE? */
>>> +	for_each_rtd_cpu_dai(fe, i, fe_cpu_dai) {
>>> +		if (fe_cpu_dai->active) {
>>> +			err = soc_pcm_apply_symmetry(fe_substream,
>> fe_cpu_dai);
>>> +			if (err < 0)
>>> +				return err;
>>> +		}
>>
>> that part seems inconsistent with Patch 4 where you add warnings/error
>> everywhere there's a FE with num_cpus>1
> 
> Actually, I have a question here. Do we need to support Multi cpu for FE?
> If yes, what is the use case?

I can't think of any case where we'd need a multi-cpu FE, and if you 
look at the existing code it doesn't look possible:

we have code in soc-dapm.c that checks that num_cpus==num_codecs and 
flags an error if you had 2 cpu_dais and 1 codec_dai.

And if you continue with soc-topology, we have hard-coded num_cpus = 1; 
and num_codecs = 1; for topology-created FE dailinks.

In other words, we'd a major topology change to support a multi-cpu FE, 
quite unlikely for now.

The multi-cpu representation is IMO only needed for specific hardware 
setups, just like the multi-codec part is tied to TDM usages.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

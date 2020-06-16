Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D71C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:06:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC4B208B8
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nJTXg1AA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC4B208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52F09166C;
	Tue, 16 Jun 2020 17:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52F09166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592320004;
	bh=M6mGS5CRfVUXcUuTgq+XPwYBJXYb2kp8nGOPtfIm+u0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nJTXg1AAjAgBZ9EQYc5OAnDlv5YqI1vCa2GRGlqK+Rgobz30DcK4WyEAXXAOwFBNz
	 T61y/WaTINGEoAFf3KjrORobfmANwy0uOzY+KUYHM9l05iM2JurtjdN3Y1vmw9Z3ua
	 5K7FF1lV0dVc1zIiXyRjt8MYur9/l6xYWGF/8kc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E712AF80114;
	Tue, 16 Jun 2020 17:05:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C6BAF8022B; Tue, 16 Jun 2020 17:05:52 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FBB6F80114
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 17:05:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FBB6F80114
IronPort-SDR: RN1p/CjA7Ig2p8sCsCj6PNuXYo/VopYPOReVcwoLPbzj8SIBIrFoi81bhwwzmij3/fGUN6x+5C
 vFemn+gyytuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 08:05:45 -0700
IronPort-SDR: jxzbzGApxJIaJDhqEbJ2zUypeSFkgQd+pygrV5wmB/uD0O90pYPpLRO+JzyCur2pM7I1p+yUgW
 0hf2X2ftiPqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; d="scan'208";a="298939342"
Received: from nafrose-mobl.amr.corp.intel.com (HELO [10.254.107.226])
 ([10.254.107.226])
 by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2020 08:05:39 -0700
Subject: Re: [PATCH 1/4] ASoC: soc-pcm: dpcm: fix playback/capture checks
To: Mark Brown <broonie@kernel.org>
References: <20200608194415.4663-1-pierre-louis.bossart@linux.intel.com>
 <20200608194415.4663-2-pierre-louis.bossart@linux.intel.com>
 <20200616085409.GA110999@gerhold.net> <20200616090210.GA111206@gerhold.net>
 <254a667e-fa49-240a-6386-7e82df8e5c35@linux.intel.com>
 <20200616145251.GO4447@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <af973f45-59b9-ecff-7d78-97d8352ed072@linux.intel.com>
Date: Tue, 16 Jun 2020 10:05:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616145251.GO4447@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
 tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 6/16/20 9:52 AM, Mark Brown wrote:
> On Tue, Jun 16, 2020 at 09:23:25AM -0500, Pierre-Louis Bossart wrote:
>> On 6/16/20 4:02 AM, Stephan Gerhold wrote:
>>> On Tue, Jun 16, 2020 at 10:54:17AM +0200, Stephan Gerhold wrote:
> 
>>>> For the QCOM case it may be feasible to set dpcm_playback/dpcm_capture
>>>> appropriately because it is basically only used with one particular
>>>> DAI driver. But simple-audio-card is generic and used with many
>>>> different drivers so hard-coding a call into some other driver like
>>>> Srinivas did above won't work in that case.
> 
>> Doesn't simple-card rely on DT blobs that can also be updated?
> 
> DT is an ABI just like ACPI - it's just more featureful.  Many systems
> can easily update their DTs but not all of them and users don't always
> want to try to keep it in lock step with the kernel.  Stuff like this is
> why I've been dubious about putting DPCM things in there, it's too much
> of a hard coding of internal APIs.

ok, but is there any actual use of dpcm_playback/capture outside of C code?

simple-card.c and audio-graph-card do hard-code but that's done with C 
in the driver:

	ret = asoc_simple_parse_daifmt(dev, cpu_ep, codec_ep,
				       NULL, &dai_link->dai_fmt);
	if (ret < 0)
		goto out_put_node;

	dai_link->dpcm_playback		= 1;
	dai_link->dpcm_capture		= 1;


that that should be fixed based on the DAI format used in that dai_link 
- in other words we can make sure the capabilities of the dailink are 
aligned with the dais while parsing the DT blobs.

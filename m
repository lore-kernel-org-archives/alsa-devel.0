Return-Path: <SRS0=5I5Q=XH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B494C49ED9
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:59:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84F2208C2
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B4y04U5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84F2208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06B56172F;
	Thu, 12 Sep 2019 11:58:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06B56172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568282376;
	bh=TOCxNw5UICsQwylsVhUa7uk64SymXos00cGnFQlml0s=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B4y04U5uCOCDw67dyaXEkcbbJ4VWVk9fzMIiZW8ATq7lszIY3ExPyzQ8JKy6EZt6Q
	 RlcOM58Y/FojTaeeL5MQ36Wb6FoKHUc3QP2dBo+wDtCcOsuTciBskoiYabWZQ3Dclo
	 L7eAP6BAqiNB0aHegg+k7V5eqfejZe0G/nAEhupA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9856BF80321;
	Thu, 12 Sep 2019 11:58:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B2FCF80368; Thu, 12 Sep 2019 11:58:44 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41860F80143
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2019 11:58:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41860F80143
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Sep 2019 02:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="175919090"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga007.jf.intel.com with ESMTP; 12 Sep 2019 02:58:36 -0700
Date: Thu, 12 Sep 2019 12:58:36 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <536bafff-963b-c6ed-bdac-f8a522a799c1@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1909121227500.16459@zeliteleevi>
References: <20190910182916.29693-1-kai.vehmanen@linux.intel.com>
 <20190910182916.29693-4-kai.vehmanen@linux.intel.com>
 <536bafff-963b-c6ed-bdac-f8a522a799c1@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: tiwai@suse.de, libin.yang@intel.com, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3 03/10] ASoC: hdac_hda: add support for
 HDMI/DP as a HDA codec
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

Hi,

On Tue, 10 Sep 2019, Pierre-Louis Bossart wrote:

> On 9/10/19 1:29 PM, Kai Vehmanen wrote:
> > +	.id = HDAC_HDMI_0_DAI_ID,
> > +	.name = "intel-hdmi-hifi1",
> > +	.ops = &hdac_hda_dai_ops,
> > +	.playback = {
> > +		.stream_name    = "hifi1",
> > +		.channels_min   = 1,
> > +		.channels_max   = 16,
> 
> IIRC HDMI only deals with 8ch?

good catch. I had just copied these from hdac-hda.c. HDMI2.0 actually 
bumped this from 8 to 32 channels.

The constraints remain pretty wide and unsupported configurations will be 
caught at runtime in PCM open in patch_hdmi.c where requested channel 
count is compared to ELD information.

In comparison, the hdac-hdmi does query and add some static constraints 
with snd_hdac_query_supported_pcm(), but e.g. for channels it just sets 
min/max to 2.

> > +		.rates          = SNDRV_PCM_RATE_8000_192000,
> 
> And frequencies above 32kHz

Ack, will fix. I'll probably keep the maximum at 192kHz. HDMI2.0/DP1.4 in 
fact bumped maximum to 1536kHz, but practically that is probably for 
8x192kHz (or 32x48kHz) audio.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

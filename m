Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8986C54FCB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:24:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF50205C9
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oCQcLhXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF50205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2854167A;
	Fri, 24 Apr 2020 15:23:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2854167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587734660;
	bh=4IpDB0pM7alidlb450/JmG+QN0Jougp5+gx3AIlG804=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCQcLhXdm1SwD0No8vwqJHwBJQr4u4721p9g1V0jSjPvggY4ZLLFKLXECN9Znf9Xz
	 28Ju+nzI2rg9WVhX8MZCbKvge02x6INKF/9VIg9ZO7p9DcOhaa3k0cbSnxWo+FH2zt
	 YM7sjL9clJbf284voG7IswvN7jAH+FeYUqkkbvig=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62F95F800BE;
	Fri, 24 Apr 2020 15:23:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C257AF80142; Fri, 24 Apr 2020 15:23:28 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B473CF800BE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 15:23:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B473CF800BE
IronPort-SDR: YGjL3x1p9T5nUNZBOr/VRm3i73tslgPStitiIXdTvz0ClTVAQZen01UIgCj3HFIWbzK4l451Rp
 Hx+l+H24RPUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2020 06:23:22 -0700
IronPort-SDR: Cez/pMlOKqPaMhc1EvaxqeI/yndB4s8i6ZJRDL7b82N8seRtBbQzRWhZQpvW1KgzhuIZ8kpIZx
 5TOAc6Xm3AjA==
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; d="scan'208";a="366345474"
Received: from mgorski-mobl.ger.corp.intel.com (HELO [10.209.18.202])
 ([10.209.18.202])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2020 06:23:20 -0700
Subject: Re: [PATCH v3 2/3] ASoC: Intel: Multiple I/O PCM format support for
 pipe
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200423111148.6977-1-mateusz.gorski@linux.intel.com>
 <20200423111148.6977-3-mateusz.gorski@linux.intel.com>
 <e13f51b7-da52-ad7a-d000-1c0099cbf21d@linux.intel.com>
From: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Message-ID: <1b3afeed-09aa-9eca-be96-529696239711@linux.intel.com>
Date: Fri, 24 Apr 2020 15:23:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e13f51b7-da52-ad7a-d000-1c0099cbf21d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Cc: cezary.rojewski@intel.com, broonie@kernel.org, tiwai@suse.com,
 Pavan K <pavan.k.s@intel.com>
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


> maybe one nit-pick is that there is a one-line difference between the 
> _set and _get functions, and it might be simpler to use a common 
> helper with a boolean flag used at the end to do this:
>
> > +    ucontrol->value.enumerated.item[0]  = pipe->pipe_config_idx;
>
> or that:
>
> > +    pipe->pipe_config_idx = ucontrol->value.enumerated.item[0];


Thanks for this hint, adressed in v4 together with comment about access 
rights.

Mateusz


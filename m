Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09111C2D0A3
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 20:11:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C6E206A5
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 20:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qIzyECA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C6E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D0FF173D;
	Mon, 16 Nov 2020 21:10:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D0FF173D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605557484;
	bh=wfkfLatGJSw21LF22PkO4Wii+0EYbfHj4uWnMXhtfbo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qIzyECA7ZYNyvEmDMoLBMm6fX5rZUh4LP0szMEcORJK8yDhqjraZuTB0qFpu7XyQ2
	 6MGodCsB9MK14APcNUwppq/Pkxm7/89Lmmo+BRqiQQwAjh1/ur5kvvwyHGaLhyLi4/
	 vDiyZREKrHC+2XRwgLBBesi46XFBZhE/DoCjDa4Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B846F80167;
	Mon, 16 Nov 2020 21:10:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13C06F8014A; Mon, 16 Nov 2020 21:10:33 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83BACF800D8
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 21:10:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83BACF800D8
IronPort-SDR: MPSpyGXVqPwcDOaYXAZiNmC6rf+QACtGNFM3F1aog9LtARoFmTXk33mLboGWtqkecXacSlK9YQ
 V65C51U1AAZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="170025404"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; d="scan'208";a="170025404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 12:10:18 -0800
IronPort-SDR: sKrlPR+VCCA5PtQS6VzImtQq32xpBTpaC/GUR/amDpFVI31OJ3x8KvVXThWfqbuGmmHhXZX8bU
 vexEQD/d395w==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; d="scan'208";a="367619680"
Received: from jporter-mobl1.amr.corp.intel.com (HELO [10.212.245.89])
 ([10.212.245.89])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 12:10:17 -0800
Subject: Re: [PATCH 3/5] ASoC: soc-generic-dmaengine-pcm: Add custom prepare
 and submit function
To: Mark Brown <broonie@kernel.org>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
References: <20201116061905.32431-1-michael.wei.hong.sit@intel.com>
 <20201116061905.32431-4-michael.wei.hong.sit@intel.com>
 <20201116195816.GH4739@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4bd0ad0c-70b9-9a75-5a8f-86cf95c486d5@linux.intel.com>
Date: Mon, 16 Nov 2020 14:10:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116195816.GH4739@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, lars@metafoo.de, andriy.shevchenko@intel.com,
 alsa-devel@alsa-project.org, jee.heng.sia@intel.com, tiwai@suse.com,
 liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>
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



On 11/16/20 1:58 PM, Mark Brown wrote:
> On Mon, Nov 16, 2020 at 02:19:03PM +0800, Michael Sit Wei Hong wrote:
> 
>> In the Intel KeemBay solution, the DW AXI-based DMA has a limitation on
>> the number of DMA blocks per transfer. In the case of 16 bit audio ASoC
>> would allocate blocks exceeding the DMA block limitation.
> 
>> The ASoC layers are not aware of such DMA limitation, and the DMA engine
>> does not provide an API to set the maximum number of blocks per linked link.
> 
> Can we not extend the dmaengine API so that the ASoC layer (and any
> other users) can become aware of this limitation and handle it
> appropriately rather than jumping straight to some client driver
> specific handling?

This was supposed to be an RFC, I asked Vinod/Lars to be copied for 
feedback. Unfortunately the RFC tag is missing and Vinod's email wasn't 
the right one... (fixed now).

This patchset suggests an ALSA-only quirk, having other more generic 
means to deal with this limitation would be fine - we just wanted to 
have a discussion on preferred directions. The IPs used are not 
Intel-specific so sooner or later someone else will have similar 
limitations to work-around.

Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7FC43463
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:11:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE98D23888
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UtqHlz//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE98D23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3093B16B0;
	Fri, 18 Sep 2020 17:10:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3093B16B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600441899;
	bh=y8D1OHF+ywXE8qT96kX4LtN5m+yN9pGoq+ZfxJgxADc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UtqHlz//1ZuG0/711jgeBUVE9+vkeXtcUKSTJh0DkUrJvhXTnP4hAnoesiAg5jAJh
	 usc7isdGx2vWUUk8zyJcJ1H7ZHjylNZCRvVju3/Q7X1fDg7Yk1h6PJFr2p2PzCYT7N
	 aMDjpxTLLxcFJe4w+pOBWWYE8iB0++DJlQyDnMnA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F906F80150;
	Fri, 18 Sep 2020 17:10:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84F3DF8015A; Fri, 18 Sep 2020 17:10:46 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD495F8012D
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 17:10:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD495F8012D
IronPort-SDR: 62+/yqj4L7oCa9rTE4X7GjOGtJxHctHYEXPIOyktG1zTG/eW2O+H3jN7pFwKDzCYzcxlpgZ+kF
 Ya6nJZBYhgZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="224124897"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="224124897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 08:10:26 -0700
IronPort-SDR: dOtXpYSi4LiuqNRT90e4YmtQJtKZBB/dCbvx3vIX7taPDv31qXkMlIKiQfKh92GU3e7slJrEQ/
 tJumBvT+c0cQ==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="332666597"
Received: from tsecasiu-mobl.amr.corp.intel.com (HELO [10.213.179.236])
 ([10.213.179.236])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 08:10:25 -0700
Subject: Re: [PATCH 3/7] ASoC: SOF: intel: hda: support also devices with 1
 and 3 dmics
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200825235040.1586478-1-ranjani.sridharan@linux.intel.com>
 <20200825235040.1586478-4-ranjani.sridharan@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b799ec66-356d-865e-a30b-ca28d5046326@linux.intel.com>
Date: Fri, 18 Sep 2020 10:10:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825235040.1586478-4-ranjani.sridharan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Jaska Uimonen <jaska.uimonen@linux.intel.com>, Stable <stable@vger.kernel.org>
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



On 8/25/20 6:50 PM, Ranjani Sridharan wrote:
> From: Jaska Uimonen <jaska.uimonen@linux.intel.com>
> 
> Currently the dmic check code supports only devices with 2 or 4 dmics.
> With other dmic counts the function will return 0. Lately we've seen
> devices with only 1 dmic thus enable also configurations with 1, and
> possibly 3, dmics. Add also topology postfix -1ch and -3ch for new dmic
> configuration.
> 
> Signed-off-by: Jaska Uimonen <jaska.uimonen@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

we now have multiple reports of devices with a single microphone where 
audio is broken without this patch, e.g. 
https://github.com/thesofproject/linux/issues/2451

This patch should be applied to -stable versions all the way to 5.6. It 
would be desirable for 5.5 and 5.4 as well but it will not apply 
cleanly. It's be trivial to provide a modified patch for these earlier 
kernel versions but I don't know what the process might be here?



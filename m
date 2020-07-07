Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E409FC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:30:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7315920720
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qP3hoxIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7315920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E0B316C7;
	Tue,  7 Jul 2020 21:29:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E0B316C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594150211;
	bh=dzs9xvz0L5k25RLQa0bz0DK93U9gRSBktEK5woJLnJM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qP3hoxIzPNlGVoYbBcf1lX5/zlE3kO8o4twmMNyR0bIM/YDLWECWSwlTabqCTaUuk
	 CTv+susK7v+IlJg1bnbWtOcI7vgmrtpCBXODGnem7937MpH/jI3fKBj/bNTi6dkL+U
	 zwMmqeggPXKmqK4Ng7EIlQz4WfgKDG65u+TeGmFQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69B07F802DD;
	Tue,  7 Jul 2020 21:26:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D863DF80264; Tue,  7 Jul 2020 21:26:55 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78D64F800DF
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:26:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78D64F800DF
IronPort-SDR: D3MabGganRjkSiminompUd/2h8pVaddsTF39OHHC6EqQMs6+vNQMomm8HQwSSlsGVZF5olcMsW
 gobjRmprH+Rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="146751734"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="146751734"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:26:51 -0700
IronPort-SDR: i8p44p0pWWlOKfP9MwzqRPEQ4Qe8pRdooKE0Tcf3tP5wSyQX1KXMG/fXggJfa7AlYTHeR/pC0m
 ppUTWWAThu1g==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="297493452"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO [10.254.77.62])
 ([10.254.77.62])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:26:50 -0700
Subject: Re: [PATCH 10/11] ASoC: qdsp6-dai: add gapless support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <62af11d3-db26-a31b-00c8-9d78b11862cc@linux.intel.com>
Date: Tue, 7 Jul 2020 12:07:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 vkoul@kernel.org
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



On 7/7/20 11:36 AM, Srinivas Kandagatla wrote:
> Add support to gapless playback by implementing metadata,
> next_track, drain and partial drain support.
> 
> Gapless on Q6ASM is implemented by opening 2 streams in a single asm stream

What does 'in a single asm stream' means?

> and toggling them on next track.

It really seems to me that you have two streams at the lowest level, 
along with the knowledge of how many samples to remove/insert and hence 
could do a much better job - including gapless support between unrelated 
profiles and cross-fading - without the partial drain and next_track 
mechanism that was defined assuming a single stream/profile.


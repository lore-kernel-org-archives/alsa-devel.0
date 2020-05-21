Return-Path: <SRS0=D4yB=7D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D25FC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 May 2020 17:18:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BA520759
	for <alsa-devel@archiver.kernel.org>; Thu, 21 May 2020 17:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GdAGZXb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BA520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26F7A178A;
	Thu, 21 May 2020 19:17:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26F7A178A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590081529;
	bh=T+q1TbHh2YR7l93iyy2ODbfa1VewzInRZXBF6wYDvFs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GdAGZXb5nSI9XojXeABNvjspaPLZuOfFhxjLhvE8DxUkSgdDQl//jUatw0OKih1Kn
	 lMfVFWeWeOLSd6H01L/21vmmx+tlu/rUIdAqVb3EIBljOMXeKabzYXf4B3Ns3HgvdC
	 LaKLbxC9k7NkbR2MisZ4ggsyqJNiN7OQN0WqhMuU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A857EF801A3;
	Thu, 21 May 2020 19:17:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1180F801D8; Thu, 21 May 2020 19:17:57 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33D6CF80111
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2020 19:17:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33D6CF80111
IronPort-SDR: ZxBfSIyLxw8C3hv4XsrEaaUe1zrB8QWV2x1zKCJjhZ55XRPlAutv6gbB3sihjVH2e+NrOBrzeZ
 7ioJjSUqmHpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2020 10:17:50 -0700
IronPort-SDR: GcWwo029F+zhMQKXSnt859lu8SH4OQataP1SFcNCkiokDTsERhh6JTKZEvM5sNpN0Bi0R6mUDy
 UI6R0DszYwGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; d="scan'208";a="254042885"
Received: from dsrao-mobl.amr.corp.intel.com (HELO [10.255.229.80])
 ([10.255.229.80])
 by orsmga007.jf.intel.com with ESMTP; 21 May 2020 10:17:49 -0700
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To: =?UTF-8?Q?=c5=81ukasz_Majczak?= <lma@semihalf.com>
References: <20200521162518.1809995-1-lma@semihalf.com>
 <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com>
Date: Thu, 21 May 2020 12:17:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Ross Zwisler <zwisler@google.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
 Alex Levin <levinale@chromium.org>
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



On 5/21/20 12:08 PM, Łukasz Majczak wrote:
>>
>> don't add a new dailink, this is not right.
>>
> Can you advise a better solution how to assign different fixup
> functions to mic and to speakers? I was looking at "dmic01" dailink in
> skl_nau88l25_max98357a.c as an example.

I am not sure I follow. the DMICs are handled on a shared SSP, so how 
would one set a different fixup? The word length have to be the same.

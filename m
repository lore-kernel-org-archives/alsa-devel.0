Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F2C2BB55
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:44:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C687020857
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LKVOJZKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C687020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FB40852;
	Wed, 15 Apr 2020 17:43:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FB40852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586965480;
	bh=ctNFtJ8Robsgvx5Vxm7+CwPXQBCI+bsI2uShmDI2ErQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LKVOJZKep/POP1MiD5SgQLZgnY4bgCFR0ZPYkXAqNEo2YGiauMSFx5w77vtWJWLLm
	 blCgQf9JK0X7nb5REJlnnvfBzwNI/2BNN4a8+oicmD/lB/xtVD/WdpH0qTLdAVV8Md
	 uXXXRr0LW2us5ODIZHMaQ0wYE6VZE3znfJ3ucFdg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8561FF80229;
	Wed, 15 Apr 2020 17:43:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48117F80245; Wed, 15 Apr 2020 17:43:47 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D7E8F80124
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 17:43:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D7E8F80124
IronPort-SDR: 6Fe6+iVRrYSRmRwwFXfT/gc0z9+O1f2hTGmqBBH2FZsyDNbj1OH8YxkChMi9Hjon5mQXG2IGe/
 w0hkO7S+OitA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 08:43:39 -0700
IronPort-SDR: +FiXEmL9Tt/0kH1pJvxNZQzDJdqz3vJV+Z/KWxF4nBU0tBnvtvGlUGIpPKV+KY72+hgOnYyRxc
 T6j7fL9laM2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; d="scan'208";a="400349715"
Received: from ccarey-mobl.amr.corp.intel.com (HELO [10.209.36.121])
 ([10.209.36.121])
 by orsmga004.jf.intel.com with ESMTP; 15 Apr 2020 08:43:39 -0700
Subject: Re: Baytrail audio not working on next branch
To: Jaime Perez <19.jaime.91@gmail.com>, alsa-devel@alsa-project.org
References: <CAM2dokvhFWfXev+JMfKnCxCPdLrFgG7xqf=8Dt5N92BPqOGKcA@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <efc2d79c-7d08-2d7c-9e4d-18f93b1ca302@linux.intel.com>
Date: Wed, 15 Apr 2020 10:43:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAM2dokvhFWfXev+JMfKnCxCPdLrFgG7xqf=8Dt5N92BPqOGKcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 4/15/20 5:10 AM, Jaime Perez wrote:
> tested 20200409 20200413 20200414 tags
> 
> maybe related issue
>   https://bugzilla.kernel.org/show_bug.cgi?id=201787

yes, please try the patch shared yesterday on alsa-devel, thanks!

[RFC TEST] ASoC: soc-dai: revert all changes to DAI startup/shutdown 
sequence



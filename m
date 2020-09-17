Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF5C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:01:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A339A2075B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s1CcCrYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A339A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC24415F2;
	Thu, 17 Sep 2020 15:00:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC24415F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600347706;
	bh=+/TcQjWfgQwbpadNoreIYAPjVJefNp+YTxhMDwt9tV0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s1CcCrYmVbjgw+6Y5pgStByNOs6LznOo19qKO1KSYQgTaswMemnZblW4csnYrdtQS
	 pUu2U7vgE2UY5GcdhHZ6tgnFkzmXNFHEFJQ5gm+taBO0leFgEGPs8n7jN1K1e9mdFe
	 hTC0lAuHm2a5aX1LdK9E8HqkyPmK6dtj6c0C5gdE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48FD7F801EC;
	Thu, 17 Sep 2020 15:00:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3100F80212; Thu, 17 Sep 2020 15:00:52 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB754F800E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 15:00:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB754F800E8
IronPort-SDR: eDv6cw0ykTwsCkjwShUJ4y3l45EiapQyRV6ORmPFkEnIXSnb7Prh/cEcFsZNabtnG2NnVIc1xw
 TQF7zA3o49Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="160614503"
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; d="scan'208";a="160614503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 06:00:41 -0700
IronPort-SDR: YfCIRlLWjqb8WKxzzwATt8g4UZ3ltV9vmIXYNyJ+7T7ROebzGEmK17wgUIkHae6AZvu1Ra0Aye
 6vnyLKXtainQ==
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; d="scan'208";a="483735931"
Received: from apauly-mobl.amr.corp.intel.com (HELO [10.254.96.60])
 ([10.254.96.60])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 06:00:40 -0700
Subject: Re: [PATCH] ASoC: rt715: Add module parameter to fix dmic pop sound
 issue.
To: Mark Brown <broonie@kernel.org>
References: <20200916204758.53651-1-pierre-louis.bossart@linux.intel.com>
 <20200917112547.GC4755@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9cbc7629-f28e-461c-1787-da5280269f99@linux.intel.com>
Date: Thu, 17 Sep 2020 08:00:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917112547.GC4755@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Jack Yu <jack.yu@realtek.com>, alsa-devel@alsa-project.org, tiwai@suse.de,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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



On 9/17/20 6:25 AM, Mark Brown wrote:
> On Wed, Sep 16, 2020 at 03:47:58PM -0500, Pierre-Louis Bossart wrote:
>> From: Jack Yu <jack.yu@realtek.com>
>>
>> Add module parameter "power_up_delay" to fix pop noise on capture. The
>> power_up_delay value is set with a default value of 400ms, smaller
>> values are not recommended.
> 
> Normally we would just add a delay in the driver unconditionally, why
> make this a module paramter?  If there are board variations then we
> should be getting them from board data, not forcing individual users to
> bodge things with a module parameter.

that wasn't the intent. 400ms is the recommended value, but the 
parameter provides a way to experiment without having to recompile 
during integration/debug stages.

It was my recommendation to add this parameter, I don't mind removing it 
if you prefer it that way. Or I can respin the commit message and 
comments to make it clearer what the intended use was.


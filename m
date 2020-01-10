Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D73C33C99
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 04:43:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17692077B
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 04:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OjhLRmVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17692077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2575917A1;
	Fri, 10 Jan 2020 05:42:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2575917A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578631403;
	bh=zdscDpnJvOySGhQBddd+A/GKv2ReCO1SvnqIdJBt6hE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OjhLRmVG64wDVzzeqqizPTG15CQRMftkuwBhQ7KVALVYHpPymI4OZcVQxRI9ogoAO
	 E8+yjrz1g8qWzB/1jpJAupF5i+tgHqQFAwWI/7I5alv/Go217xLcnKN8zdD2AEQkSd
	 5DEENN3DrJcCgLsLRb8njuaz8aVCN7JBeJxDvgb8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 796B6F80116;
	Fri, 10 Jan 2020 05:42:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB594F8011C; Fri, 10 Jan 2020 05:42:30 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B7CEF800E4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 05:42:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B7CEF800E4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2020 20:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,415,1571727600"; d="scan'208";a="224085721"
Received: from cgrageda-mobl.amr.corp.intel.com (HELO [10.254.8.138])
 ([10.254.8.138])
 by orsmga003.jf.intel.com with ESMTP; 09 Jan 2020 20:42:23 -0800
To: shumingf@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20200110014606.17333-1-shumingf@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <708f809f-f2f5-d24b-9484-2b815d3d8f41@linux.intel.com>
Date: Thu, 9 Jan 2020 22:42:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110014606.17333-1-shumingf@realtek.com>
Content-Language: en-US
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, flove@realtek.com,
 bard.liao@intel.com, pierre-louis.bossart@intel.com
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: rt1308-sdw: add rt1308 SdW
 amplifier driver
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



On 1/9/20 7:46 PM, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> This is the initial amplifier driver for rt1308-sdw.
> 
> Signed-off-by: Shuming Fan <shumingf@realtek.com>

this driver has also been tested extensively by Intel using Realtek 
3-in-1 eval boards connected to CML/ICL/TGL reference platforms, as well 
as form-factor devices, so

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C1DC4741F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:21:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FF52080D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ksMjxx2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FF52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9510F1671;
	Thu,  5 Nov 2020 17:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9510F1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604593265;
	bh=I+PhcVbCdyYdG/m4R/pJlGLcfSs5SGi03gSFn8+aQ/I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ksMjxx2kwSanv3KKHfEgXDMWt+TMthRk7sla+c/bRPZqRzIHLHt6Oq8WSkPhiPV/c
	 yCTmSSHf4fb96zbdcM1GxDpSZuIq01c9CKdPa5lfzqamf8S/+3auIIjRRzQfEMSx1U
	 6VupGe8w23VjRJTbXzVcyTob9t4vmqpghevIN1Ec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33E8BF80150;
	Thu,  5 Nov 2020 17:20:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37973F80162; Thu,  5 Nov 2020 17:20:13 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A15F9F800EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 17:20:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A15F9F800EC
IronPort-SDR: gptXBiJ3JBH9GY/5MukVNkW7nT5L6q4vdcP1lexwErhgsVbk3lVLzAzlu7pRwATkVHuPhcBTLI
 FnvgQQzq9c/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="157192118"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; d="scan'208";a="157192118"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 08:20:02 -0800
IronPort-SDR: ZUeKpsT88n2eEQDLWRohP3as8XuAKRILY7VEXFRa6wAxHjAow/TenrS0Eacz+7M0E1caHY3EyM
 LcTKxgSuoBXw==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; d="scan'208";a="539465896"
Received: from umedepal-mobl2.amr.corp.intel.com (HELO [10.254.6.114])
 ([10.254.6.114])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 08:20:01 -0800
Subject: Re: [PATCH v3 0/6] ASoC: codecs: add support for LPASS Codec macros
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f4cf1bd6-cf11-60bb-3169-c54d2cf72e19@linux.intel.com>
Date: Thu, 5 Nov 2020 10:20:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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



On 11/5/20 5:34 AM, Srinivas Kandagatla wrote:
> This patchset adds support for two Codec Macro blocks( WSA and VA) available in
> Qualcomm LPASS (Low Power Audio SubSystem).
> 
> There are WSA, VA, TX and RX Macros on LPASS IP, each of the Macro block
> has specific connectivity like WSA Macros are intended to connect
> to WSA Smart speaker codecs via SoundWire. VA Macro is intended for DMICs,
> and TX/RX for Analog codecs via SoundWire like other WCD Codecs to provide
> headphone/ear/lineout etc ..
> 
> Most of the work is derived from downstream Qualcomm kernels.
> Credits to various Qualcomm authors from Patrick Lai's team who have
> contributed to this code.
> 
> This patchset has been tested on support to Qualcomm Robotics RB5 Development
> Kit based on QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers
> with onboard DMIC connected to internal LPASS codec via WSA  and VA macros
> respectively.

For the series,

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


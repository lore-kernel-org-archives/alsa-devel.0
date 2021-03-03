Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D2C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 22:00:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D6664EED
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 22:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D6664EED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 564E41A00;
	Wed,  3 Mar 2021 22:59:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 564E41A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614808816;
	bh=iySlkCO1K550Oh3Lu70T+zfKLxZBYvLbiffNx7eKi6E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m9TZthgYDg+kK4saeYrYQl61z3XgWiwRHuwsoGRODeq+SVZ4p7wLie6BwyfOwhgKB
	 Oqkq1fgjQBSCkyTLa4sqV0mcgsJMx8G60EYCLjeMLy3S/9n8t++SuwDpA9X9fxHyYt
	 L6v55ksR+SPY54scbJaOG7GDVBN2xTKUxxO5NvZ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6677F8025E;
	Wed,  3 Mar 2021 22:59:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D166F80257; Wed,  3 Mar 2021 22:59:24 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E15DF80227
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 22:59:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E15DF80227
IronPort-SDR: KxtYm+OrXtqRn56Kce5lPXDzpMNiz94JuAQpsn4WEkidFFJxEZA80142zcPMLN8AfWjwcsS8ln
 PCxr1atyLO3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174405686"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="174405686"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 13:59:13 -0800
IronPort-SDR: xPuyXcgcp6AOnk3OFK851lgX0vAM/NBvbQ0XwP74WyfCB4aJvCI4Javx8OhCLDT8ngD4ZjmfuB
 gl+tbVVgTmgg==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="586487017"
Received: from srcook1-mobl1.amr.corp.intel.com (HELO [10.209.143.11])
 ([10.209.143.11])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 13:59:12 -0800
Subject: Re: [PATCH v2 1/5] soundwire: qcom: add support to missing transport
 params
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
 <20210226155814.27536-2-srinivas.kandagatla@linaro.org>
 <00842f73-c0fb-5728-3ed0-c0a1fd75f94e@linux.intel.com>
 <31eca99d-9f84-e088-443b-9aae782c2df2@linaro.org>
 <06a687f6-e79c-9bad-32c2-ea61356f882e@linux.intel.com>
 <d0dc4c6f-cbd5-06e8-6ed8-234a55f9de9c@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <de3b8223-f51d-6cb1-6346-7bd7dcefb482@linux.intel.com>
Date: Wed, 3 Mar 2021 10:16:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0dc4c6f-cbd5-06e8-6ed8-234a55f9de9c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
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


> soundwire-controller@3210000 {
>      reg = <0 0x3210000 0 0x2000>;
>      compatible = "qcom,soundwire-v1.5.1";
>      interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
>      clocks = <&rxmacro>;
>      clock-names = "iface";
>      qcom,clock-stop-mode0;
>      qcom,din-ports = <0>;
>      qcom,dout-ports = <5>;
> 
>      qcom,ports-sinterval-low = /bits/ 8 <0x03 0x1F 0x1F 0x07 0x00>;
>      qcom,ports-offset1 = /bits/ 8 <0x00 0x00 0x0B 0x01 0x00>;
>      qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
>      qcom,ports-hstart = /bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
>      qcom,ports-hstop = /bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
>      qcom,ports-word-length = /bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
>      qcom,ports-block-pack-mode = /bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
>      qcom,ports-lane-control = /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
>      qcom,ports-block-group-count = /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
> 
>      #sound-dai-cells = <1>;
>      #address-cells = <2>;
>      #size-cells = <0>;
> };
>> properties that may or may not be valid. If this is intentional and 
>> desired, this should still be captured somehow, e.g. in the bindings 
>> documentation or in the code with a comment, no?
> 
> Yes, I agree with you on this, I should document this in bindings!

thanks for the explanations, it'd be useful indeed to document what this 
magic 0xFF value means.


Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5515C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Apr 2022 18:00:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E4921B04;
	Wed, 20 Apr 2022 19:59:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E4921B04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650477648;
	bh=N62cvOlKD0daSm/0St1yA0uiCTqXXL1RTNMqabzw2jQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ILMLCbrl9aDG6hqjrh2CF+aM86yq7XxR1tbrfa1KiInQrvefu/B12g35r3mXNYMcn
	 q7hr+q0ASSEGbxS+G9OpRfIkPsXww6eyINFxJNp2lIcOzCavYcrSfYE0PqgL/hHJPQ
	 Jq04SrD94T0pCPNOrgMzCexuWuBGUq6o55VuheaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2A2AF80116;
	Wed, 20 Apr 2022 19:59:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2034EF8010B; Wed, 20 Apr 2022 19:59:55 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C4F9F8010B
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 19:59:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C4F9F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="AZEKzby+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650477592; x=1682013592;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=N62cvOlKD0daSm/0St1yA0uiCTqXXL1RTNMqabzw2jQ=;
 b=AZEKzby+SM/Nz/LLz+abw8Qj+XETFrYIwgNzgbiUH0ZCRFmI9hgubP/E
 +vSM7I/6Jjfvx3PD9A/kjuvcJTO7F/0z6xlA+2zGwyme7F+Qn0F2tu/ub
 HwsCr3VbOZ6xrrQjq2pNPWvzuc0zbT/ldA4b3oCCcJi/IxK+IkvhGN1rL
 vlZBRJMPf92g+rOdcbTaLS1nKadauXCT4WhMWNjFfQg9bClgCU277WEcv
 Sue0Ys0vLTJyzBrq1p4vZPJv7R5yKO1SibimkxM9aYtPrOsBcb5gqcgAA
 vhSPni5i/CbsmZg628Kwb3GlZqWeoFW2bafbvUjFYkLdOLkxXMf8mMtN9 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263875243"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; d="scan'208";a="263875243"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2022 10:59:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; d="scan'208";a="576721817"
Received: from sbidasar-mobl.amr.corp.intel.com (HELO [10.209.100.171])
 ([10.209.100.171])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2022 10:59:45 -0700
Message-ID: <80503ba6-5a84-9481-11fc-6f0c4303331b@linux.intel.com>
Date: Wed, 20 Apr 2022 12:53:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] soundwire: qcom: add runtime pm support
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, robh+dt@kernel.org, 
 vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
 Mark Brown <broonie@kernel.org>
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org>
 <20220228172528.3489-2-srinivas.kandagatla@linaro.org>
 <10eb3973-03c4-74cd-d28a-014fc280cdf8@linux.intel.com>
 <e8ac9fab-85af-8f3c-eb68-c2d4d2f7f046@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <e8ac9fab-85af-8f3c-eb68-c2d4d2f7f046@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
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


>>> @@ -1197,12 +1224,23 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>>>   static int swrm_reg_show(struct seq_file *s_file, void *data)
>>>   {
>>>       struct qcom_swrm_ctrl *swrm = s_file->private;
>>> -    int reg, reg_val;
>>> +    int reg, reg_val, ret;
>>> +
>>> +    ret = pm_runtime_get_sync(swrm->dev);
>>> +    if (ret < 0 && ret != -EACCES) {
>>> +        dev_err_ratelimited(swrm->dev,
>>> +                    "pm_runtime_get_sync failed in %s, ret %d\n",
>>> +                    __func__, ret);
>>> +        pm_runtime_put_noidle(swrm->dev);
>> ... here it's missing?
>>
>> I have a fix ready but thought I would check first if this was intentional
> 
> Its not intentional.
> 
> 
>>
>> https://github.com/thesofproject/linux/pull/3602/commits/6353eec8dc971c5f0fda0166ae1777f71784ea32
> 
> Fix looks good.

Thanks Srini, I'll add Fixes tags and share on alsa-devel.

I guess we need to thank Mark Brown for his guidance to use pm_runtime_resume_and_get(), that's how I saw those two cases :-)

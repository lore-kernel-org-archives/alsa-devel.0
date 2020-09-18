Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD56C43464
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:25:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E69D21D42
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GVqKLMAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E69D21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0508316C0;
	Fri, 18 Sep 2020 16:24:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0508316C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600439145;
	bh=sfwxGrnqdo3Jg4YNMZADJDr8aOBTH+XNfeUxarUSSFs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GVqKLMANKELTch4s8kEPO59wMmipGK55Ei7tnHEZoMPWqs7gJqOeyFMfrFiXF4zaj
	 u1ksJX0/0HNP/1a9pwTKEaexEp4nVWW2ulbbTiqVlvXi5AqRyVwGR1xcGV5xGEs7FZ
	 Yvr2icUBB027l0vNVzLW0RB4fgLuNc/YY8KzdPFw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94930F8015A;
	Fri, 18 Sep 2020 16:24:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD86EF8012D; Fri, 18 Sep 2020 16:24:53 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4DE3F8012D
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 16:24:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4DE3F8012D
IronPort-SDR: DWXoZ8qqu4Y//iCTJU1tWvWGVhM8RggncMqjp60VcXiWm+dRv+Ibzbi6b4xHWhLu0P/H44RuGs
 qjWOJAUYiM3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157336298"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="157336298"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 07:24:39 -0700
IronPort-SDR: oEMaa35wqp74nmd7eSyMUREs8GikMXXV2AZ4t+UFjNojhyS6Ot3Kt8sIeUxjLQeyddWXJpDz7N
 ZY1OBT5zz1AA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="332653960"
Received: from tsecasiu-mobl.amr.corp.intel.com (HELO [10.213.179.236])
 ([10.213.179.236])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 07:24:39 -0700
Subject: Re: [PATCH v2 1/2] soundwire: bus: add enumerated Slave device to
 device list
To: Vinod Koul <vkoul@kernel.org>
References: <20200917160007.153106-1-pierre-louis.bossart@linux.intel.com>
 <20200917160007.153106-2-pierre-louis.bossart@linux.intel.com>
 <20200918120502.GR2968@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eb02ba7f-5f80-cfde-9225-064d185fd64d@linux.intel.com>
Date: Fri, 18 Sep 2020 08:54:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918120502.GR2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org,
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



On 9/18/20 7:05 AM, Vinod Koul wrote:
> On 17-09-20, 11:00, Pierre-Louis Bossart wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Currently Slave devices are only added on startup, either from Device
>> Tree or ACPI entries. However Slave devices that are physically
>> present on the bus, but not described in platform firmware, will never
>> be added to the device list. The user/integrator can only know the
>> list of devices by looking a dynamic debug logs.
>>
>> This patch suggests adding a Slave device eveb there is no matching DT or
>> ACPI entry, so that we can see this in sysfs entry.
>>
>> Initial code from Srinivas. Comments, fixes for ACPI probe and edits
>> of commit message by Pierre.
> 
> You should add yours as Co-developed. That is the standard tag for these
> things

ok, I've never used this tag before but it seems appropriate indeed, 
thanks for the suggestion.

Should I add your Co-developed tag to the second patch as well then?


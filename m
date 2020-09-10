Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CECC433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:03:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35B921D6C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U1IB1RE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35B921D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E1991698;
	Thu, 10 Sep 2020 16:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E1991698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599746624;
	bh=B6eM1yQy9oyPwY6y4Rsa5k4o97TjelO+RvyPwgmofxE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1IB1RE/a2X/370aDxHDWSUkhhzZ35tvx+nBTK+PgOk+0ELWSHYeWu1gxi+Hjjwj4
	 7WFjddfVg+HgxXeVF24E5NC0gY6nbRzXkWGyP6IFoj6cokY0a5xIQGzZ5UqsC1Tfd3
	 weaYUJbQcmH9e/RnCgnbMmBw1HjDaYHbMN+gQEH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF02DF801F2;
	Thu, 10 Sep 2020 16:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CF75F80264; Thu, 10 Sep 2020 16:02:52 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E614F800E9
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 16:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E614F800E9
IronPort-SDR: VHiCl0IgyT+YDlIsl1A3m3YL8ZVHp9tGtcr+iWejFuPC1DXaSXuSDYG+TbqndyPf8KNasab+n1
 u8H61B/AEFVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="159484804"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="159484804"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 07:02:38 -0700
IronPort-SDR: Ka9Vqfs5i/2dOTqodoODRERtS3b5CqFhX+fj9c3C+8NdRDTsvPJ8fNe6M0apBAb8AFFZ65Rmlf
 tNkf/2qB4OTg==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="480900189"
Received: from minfanti-mobl.amr.corp.intel.com (HELO [10.254.126.4])
 ([10.254.126.4])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 07:02:37 -0700
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
To: Vinod Koul <vkoul@kernel.org>
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
 <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
 <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
 <d0c71a83-9dc1-83c3-5cb1-d8fb7dc7f809@linaro.org>
 <ed88432c-e21c-b5fc-3abc-5f574769b722@linux.intel.com>
 <20200910085621.GS77521@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f3880470-cdc4-7b84-97a1-303f9a95d3f4@linux.intel.com>
Date: Thu, 10 Sep 2020 09:02:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910085621.GS77521@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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


>>> May be we could make the enumerated devices discovery bit more verbose!
>>
>> Maybe adding a device number sysfs entry would help, e.g. reporting
>> NotAttched or a value in [0,11] would tell you if the device is actually
>> present.
> 
> Agreed, I cooked this patch to report verbose device status, let me know
> if you are okay with this. I think this would be useful regardless of
> current discussion.
> 
> On Db845c I see:
> 
> root@linaro-alip:/sys/bus/soundwire/devices# cat sdw:0:217:2010:0:1/status
> Attached
> root@linaro-alip:/sys/bus/soundwire/devices# cat sdw:0:217:2010:0:2/status
> Attached

looks like we are all aligned on the idea, I have a similar patch to at 
https://github.com/thesofproject/linux/pull/2426

The difference is that the sysfs status and device_number is added even 
without a driver probe and when there's no firmware description. sysfs 
is currently only added after the driver probe, which wouldn't work for 
the case Srinivas was trying to deal with.

but the way you dealt the status below is better than the switch case I 
used, so will merge this into my code.

Srinivas' patch needs a fix for ACPI platforms, won't probe otherwise 
since we don't have an of_node. If that's alright with everyone I can 
submit a patchset that gathers the 3 contributions.

> 
> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
> index f510071b0add..3b2765f10024 100644
> --- a/drivers/soundwire/sysfs_slave.c
> +++ b/drivers/soundwire/sysfs_slave.c
> @@ -97,8 +97,27 @@ static ssize_t modalias_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(modalias);
>   
> +#define SDW_SLAVE_MAX (SDW_SLAVE_RESERVED + 1)
> +
> +static const char *const slave_status[SDW_SLAVE_MAX] = {
> +	[SDW_SLAVE_UNATTACHED] =  "UNATTACHED",
> +	[SDW_SLAVE_ATTACHED] = "Attached",
> +	[SDW_SLAVE_ALERT] = "Alert",
> +	[SDW_SLAVE_RESERVED] = "Reserved",
> +};
> +
> +static ssize_t status_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +
> +	return sprintf(buf, "%s\n", slave_status[slave->status]);
> +}
> +static DEVICE_ATTR_RO(status);
> +
>   static struct attribute *slave_attrs[] = {
>   	&dev_attr_modalias.attr,
> +	&dev_attr_status.attr,
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(slave);
> 

Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F3AC43464
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:26:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D333B208C3
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QFQusgKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D333B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C197016CC;
	Fri, 18 Sep 2020 16:25:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C197016CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600439197;
	bh=0HyxU8n/RVVdRH/gPRozSO+RwkrksisJb+6HenCxpdM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFQusgKkamPgXeYHFBdaLZ6KZesu72FwllNlyJpcroYtV9Bk7azctG3jsgwDRFjh0
	 NoHnE/D7t3wH1PgzJ8Uooc3zEDxhuFPh/2LUS3r+pqWGJ9ksIsADa6oCzrrrV3vR/J
	 WnpV77ZLxVzyIagw+6BtpvnlLpRUqTdNu7uwjBg8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AA59F8015D;
	Fri, 18 Sep 2020 16:24:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D556BF800E8; Fri, 18 Sep 2020 16:24:54 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8ED40F800E8
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 16:24:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ED40F800E8
IronPort-SDR: 8zBxVr3xgmlZT+xRj2R0ahxXBQ+yNtENnClMBViveNCoIBVCrKpdVhm0FabzkkgaTGH9h/pZTO
 /pdPJLYYfI+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157336302"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="157336302"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 07:24:41 -0700
IronPort-SDR: 9H0j1WCh4LHBop/GgIdiwl89F+leKXJLfERJFpJTSsvvYxREg4ncgdiwBknKa9sfDkEo87AVW6
 qFwhlhfr0FLg==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="332653963"
Received: from tsecasiu-mobl.amr.corp.intel.com (HELO [10.213.179.236])
 ([10.213.179.236])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 07:24:40 -0700
Subject: Re: [PATCH v2 2/2] soundwire: sysfs: add slave status and device
 number before probe
To: Vinod Koul <vkoul@kernel.org>
References: <20200917160007.153106-1-pierre-louis.bossart@linux.intel.com>
 <20200917160007.153106-3-pierre-louis.bossart@linux.intel.com>
 <20200918121614.GS2968@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8729c1d-6d36-ad34-34c3-899ba0f5366d@linux.intel.com>
Date: Fri, 18 Sep 2020 09:21:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918121614.GS2968@vkoul-mobl>
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




>>    * Base file is device
>>    *	|---- modalias
>> + *	|---- dev-status
>> + *		|---- status
>> + *		|---- device_number
> 
> Any reason why we want this under dev-status.
> 
> Both the status and device_number belong to the device, so we can
> put them under device and use device properties

We already use directories for device-level and port-level properties, I 
just thought it be cleaner to continue this model. We might also expand 
the information later on, e.g. provide interrupt status.

I don't mind if we remove the directory and move everything up one 
level, but it wouldn't be consistent with the previous work.

>> +static ssize_t device_number_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>> +
>> +	if (slave->status == SDW_SLAVE_UNATTACHED)
>> +		return sprintf(buf, "%s", "N/A");
> 
> Do we really want N/A here, 0 should imply UNATTACHED and then the
> status_show would tell UNATTACHED.

Actually no. If you look at the standard, 'Unattached' is an 'internal 
state of a Slave that indicates that it is not synchronized with to the 
Frame boundaries within the Bitstream'. A Slave device can only become 
attached and report it's presence as Device0 in a PING frame once it's 
ATTACHED - which in turn means the device has been able to sync for 15 
frames. A device number of zero means the device is able to respond to 
command but has not yet been enumerated, or was enumerated previously 
but lost sync or went through a reset sequence and reattached. A device 
number of zero does not mean the device is unattached, the logic is as 
follow:

Attached -> Device 0 or 1..11
Unattached -> No concept of device number (or not an observable value).

We should not overload what 'Device0' means and instead follow the 
standard to the letter. We also don't want the attribute to come and go 
dynamically, so N/A (Not Applicable) is IMHO the only way to convey this 
meaning.

Does this help?

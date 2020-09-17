Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468B0C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:55:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB83206B6
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cMLN23ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB83206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 387CA15F2;
	Thu, 17 Sep 2020 14:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 387CA15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600347356;
	bh=z50WhvASlvffVDpmiLeU+MWG5XEsqGVtPR54ac5/tOg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMLN23evZ8CtNS1/NfnVQ2btmycmkbWj6JMCVU5byplP51WV61YAZRwvcVJC7v56W
	 NsKVwNoI8zorEgW/VgKeCN5KSsUfPLAdvem+VKaqal7v8p/s0s/jnkYjA516nlAYzl
	 GsBYl6zHGg7vnHu4PPQJNBhj5vVoQQ91hpFiQ1u0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A515CF801EC;
	Thu, 17 Sep 2020 14:55:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C27FF80212; Thu, 17 Sep 2020 14:55:04 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21463F80134
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 14:54:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21463F80134
IronPort-SDR: EOPG3nvs7DQJdpeRznGZ7rFjY60HYLP9wEwnzfX5cx3sdpUwn6irYmZKg8V43j49/P7GGINbbV
 8fMOXRulMkLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="159739534"
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; d="scan'208";a="159739534"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 05:54:52 -0700
IronPort-SDR: uWCLXaus5th3eIlL7kfVQYFQxxBGJfIPgTEoIc6sKVk+8wATdY9ElZ0NuhrQ8KTTTzbfSNfTi+
 4L+AX0NZUDHg==
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; d="scan'208";a="483733742"
Received: from apauly-mobl.amr.corp.intel.com (HELO [10.254.96.60])
 ([10.254.96.60])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 05:54:51 -0700
Subject: Re: [PATCH 2/2] soundwire: sysfs: add slave status and device number
 before probe
To: Greg KH <gregkh@linuxfoundation.org>
References: <20200916201504.52211-1-pierre-louis.bossart@linux.intel.com>
 <20200916201504.52211-3-pierre-louis.bossart@linux.intel.com>
 <20200917091938.GB52206@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2fc52eda-5c4a-e970-8a74-43c2037f9e0f@linux.intel.com>
Date: Thu, 17 Sep 2020 07:54:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917091938.GB52206@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, tiwai@suse.de, vkoul@kernel.org,
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

Thanks for the review Greg,

>> +int sdw_slave_status_sysfs_init(struct sdw_slave *slave)
>> +{
>> +	return device_add_group(&slave->dev, &sdw_slave_status_attr_group);
> 
> DOesn't this race with userspace?  Why not make this part of the default
> set of device attributes and have the driver core create them
> automatically?

What did you mean by 'default set of device attributes', would you mind 
providing a pointer to an example so that I can look into this?

What we have in this patch is added by the SoundWire core but you're 
probably thinking of something else. thanks for enlightening the rest of 
us:-)

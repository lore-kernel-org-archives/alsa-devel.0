Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F61C3A5A8
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:19:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FDD2168B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s5wVcTPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FDD2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C05DA16B8;
	Wed,  4 Sep 2019 15:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C05DA16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567603184;
	bh=Ky3kdKWfCHMNYfvlWMtufLe1WU43buc28mwabp6gl3w=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s5wVcTPlITAl+c78ejyn4Ox/q1se0ifp01ZZqimzEV6VMgL7hg1Q43F53Lf++5PIn
	 S9qRZRr0D2O90ws/iWrqMnUc8DlSiUidkbsuzIZGue+m08sACUhgdCdH6Y4qTMNgNt
	 IYSCS4gIcPfBbnNr9hQ0AqqDvQYfru30J3eRa1Vk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D588F80394;
	Wed,  4 Sep 2019 15:18:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92DFAF803A6; Wed,  4 Sep 2019 15:18:52 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 627B1F8011E
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 15:18:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 627B1F8011E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 06:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; d="scan'208";a="194727790"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 06:18:47 -0700
Received: from ravisha1-mobl1.amr.corp.intel.com (unknown [10.255.36.89])
 by linux.intel.com (Postfix) with ESMTP id 1BC465808A9;
 Wed,  4 Sep 2019 06:18:46 -0700 (PDT)
To: Vinod Koul <vkoul@kernel.org>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-3-pierre-louis.bossart@linux.intel.com>
 <20190904071317.GJ2672@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <71411347-93cf-2617-4edd-f6b401fe7a9b@linux.intel.com>
Date: Wed, 4 Sep 2019 08:18:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904071317.GJ2672@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: cadence_master: add
 hw_reset capability in debugfs
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

On 9/4/19 2:13 AM, Vinod Koul wrote:
> On 13-08-19, 16:32, Pierre-Louis Bossart wrote:
>> Provide debugfs capability to kick link and devices into hard-reset
>> (as defined by MIPI). This capability is really useful when some
>> devices are no longer responsive and/or to check the software handling
>> of resynchronization.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 046622e4b264..bd58d80ff636 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -340,6 +340,23 @@ static int cdns_reg_show(struct seq_file *s, void *data)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>>   
>> +static int cdns_hw_reset(void *data, u64 value)
>> +{
>> +	struct sdw_cdns *cdns = data;
>> +	int ret;
>> +
>> +	if (value != 1)
>> +		return 0;
> 
> Should this not be EINVAL to indicate invalid value passed?

Maybe. I must admit I don't know what -EINVAL would do, this is used for 
debugfs so it's not clear to me if the user will see a difference?

> 
>> +
>> +	ret = sdw_cdns_exit_reset(cdns);
>> +
>> +	dev_dbg(cdns->dev, "link hw_reset done: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
>> +
>>   /**
>>    * sdw_cdns_debugfs_init() - Cadence debugfs init
>>    * @cdns: Cadence instance
>> @@ -348,6 +365,9 @@ DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>>   void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>>   {
>>   	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
>> +
>> +	debugfs_create_file("cdns-hw-reset", 0200, root, cdns,
>> +			    &cdns_hw_reset_fops);
>>   }
>>   EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
>>   
>> -- 
>> 2.20.1
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

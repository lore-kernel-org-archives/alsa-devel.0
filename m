Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8097CC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:50:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B07D2087C
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="by++aMG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B07D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE5D716BE;
	Wed,  9 Sep 2020 15:49:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE5D716BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599659437;
	bh=KoyLEV3ITUFM98M8gfMWgIn5sXzdWHPpSiv4ic0RkG4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=by++aMG0E7Uwr3lNlKf0rNaDQbv6NkdEBiH3E5NthAaJ5nyOFwixW7OikyDO51onA
	 4cD6vZl1R8ptJoQTP/ChCSbEorFmvqlVM9RyTJSH97nlDpP3STHv1WR6R4rSIuMWdy
	 CLSSKRbUo0K39gr0Wk4vwgRGFSFQhonwnX7vB0AE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B190F8021C;
	Wed,  9 Sep 2020 15:49:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BE2BF80256; Wed,  9 Sep 2020 15:49:43 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 489A5F800FD
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 15:49:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 489A5F800FD
IronPort-SDR: Pl2iOje6YWJEkLp4LNlTcsLYapPbHM/HDwiovG7OgFMde4gcyKSpTb/N6zlzpRRFecKRCzqnfD
 M4DgSzDOC1PQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="158362301"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; d="scan'208";a="158362301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2020 06:49:25 -0700
IronPort-SDR: J9ZzMi6jOr8Viwindwex+txw607dpwD5Fa4XeUXIVX9U5IGEvxo4qYCMsrizptiWvTbehfXK4K
 ojFv1wNnlekQ==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; d="scan'208";a="505456860"
Received: from rsetyawa-mobl1.amr.corp.intel.com (HELO [10.212.20.145])
 ([10.212.20.145])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2020 06:49:24 -0700
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
Date: Wed, 9 Sep 2020 08:37:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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



On 9/9/20 3:27 AM, Srinivas Kandagatla wrote:
> Currently slave devices are only added either from device tree or acpi
> entries. However lets say, there is wrong or no entry of a slave device
> in DT that is enumerated, then there is no way for user to know all
> the enumerated devices on the bus.

Sorry Srinivas, I don't understand your point.

The sysfs entries will include all devices that are described in 
platform firmware (be it DT or ACPI).

If you add to sysfs entries unknown devices which happen to be present 
on the bus, then what? How would you identify them from the devices that 
are described in firmware?

Also the sysfs entries describe properties, but if you haven't bound a 
driver then how would this work?

I really feel this deserves more explanations on the problem statement 
and what you are hoping to achieve in this case.

Thanks!

> 
> To fix this add slave device by default if there is no matching dt or
> acpi entry, so that we can see this in sysfs entry.
> 
> In my case I had a wrong address entry in DT, However I had no way to
> know what devices are actually enumerated on the bus!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/bus.c      | 1 +
>   drivers/soundwire/bus.h      | 2 ++
>   drivers/soundwire/bus_type.c | 6 ++++++
>   drivers/soundwire/slave.c    | 4 ++--
>   4 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index e6e0fb9a81b4..55d9c22c4ec5 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -699,6 +699,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>   
>   		if (!found) {
>   			/* TODO: Park this device in Group 13 */
> +			sdw_slave_add(bus, &id, NULL);
>   			dev_err(bus->dev, "Slave Entry not found\n");
>   		}
>   
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 82484f741168..1517d6789dff 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -19,6 +19,8 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>   int sdw_of_find_slaves(struct sdw_bus *bus);
>   void sdw_extract_slave_id(struct sdw_bus *bus,
>   			  u64 addr, struct sdw_slave_id *id);
> +int sdw_slave_add(struct sdw_bus *bus, struct sdw_slave_id *id,
> +		  struct fwnode_handle *fwnode);
>   int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
>   			  struct fwnode_handle *fwnode);
>   int sdw_master_device_del(struct sdw_bus *bus);
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 6fba55898cf0..ac036223046f 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -84,6 +84,12 @@ static int sdw_drv_probe(struct device *dev)
>   	const struct sdw_device_id *id;
>   	int ret;
>   
> +	/*
> +	 * fw description is mandatory to bind
> +	 */
> +	if (!dev->fwnode || !dev->of_node)
> +		return -ENODEV;
> +
>   	id = sdw_get_device_id(slave, drv);
>   	if (!id)
>   		return -ENODEV;
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index 0839445ee07b..24a16ebf9ae2 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -20,8 +20,8 @@ struct device_type sdw_slave_type = {
>   	.uevent =	sdw_slave_uevent,
>   };
>   
> -static int sdw_slave_add(struct sdw_bus *bus,
> -			 struct sdw_slave_id *id, struct fwnode_handle *fwnode)
> +int sdw_slave_add(struct sdw_bus *bus,
> +		  struct sdw_slave_id *id, struct fwnode_handle *fwnode)
>   {
>   	struct sdw_slave *slave;
>   	int ret;
> 

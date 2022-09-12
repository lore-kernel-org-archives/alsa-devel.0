Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E723ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Sep 2022 12:01:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C40B516DF;
	Mon, 12 Sep 2022 14:00:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C40B516DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662984104;
	bh=X2vL0QfGvfcJedB7T4NQXZPHTO62VdP8mJAlZZ57BQQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQNc0MjrMBLq6HHCraSfRL2+ONW3mTpTcVRJKFRXMkE7xuCsJ4rN8Zjo1zul1fiP6
	 KZWRoKTvxdj+L63faO0trl8irr0DCdQC2mn+Y390F/yTOwebgLCUNnsSTx/UHykGJa
	 sxeakydl3tQcbuLTnA7YSaiW5gNU/5JAy7CD6oJc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04D85F80548;
	Mon, 12 Sep 2022 14:00:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46C42F80549; Mon, 12 Sep 2022 14:00:13 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25B88F8020D;
 Mon, 12 Sep 2022 14:00:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25B88F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="NHwnYR6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662984007; x=1694520007;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=X2vL0QfGvfcJedB7T4NQXZPHTO62VdP8mJAlZZ57BQQ=;
 b=NHwnYR6DRniZ7uIf10h7CprgsgH8POocWlUUb335DGvC6hfqo+yZk8v5
 gz9e++db72Ku6Gk3neHtVdJBMn3AwHwau2vbgkPnMD3cLzuq0ZYUAzwlZ
 NAiHgd1mHBV0CRPJpLQUAwF/Si7m/76rHXeptQLW+fhrGZEXvNQmswFm1
 8AqLpNJW/iS51NpwqLcT2D6YOwgBVuGXb3g1iEjEtRWf992iDk3ncZpUf
 Dix6cEMIYfMqVMJv6OIVs2EGNRbpA9blTarMP7Wu1gu+ORoXhpLpY5usY
 Z4yeA0lH5YYZ4PqOhLjY6BTI/ZpFe9LMiwHAYEgFUPyn0KEV6VltWmmF4 w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="295430366"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; d="scan'208";a="295430366"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2022 05:00:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; d="scan'208";a="705126409"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67])
 ([10.252.32.67])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2022 04:59:57 -0700
Message-ID: <fde38f21-bd19-0326-ffc9-6abf6a9aff3b@linux.intel.com>
Date: Mon, 12 Sep 2022 12:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] soundwire: bus: Fix premature removal of sdw_slave
 objects
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
 peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
 sanyog.r.kale@intel.com, broonie@kernel.org
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
 <20220907101402.4685-8-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220907101402.4685-8-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
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



On 9/7/22 12:14, Richard Fitzgerald wrote:
> When the bus manager is removed sdw_bus_master_delete() should not
> be deleting the struct sdw_slave objects until the bus manager has
> been stopped. The first step of removing child drivers should only
> be calling device_unregister() on the child. The counterpart to
> sdw_drv_probe() is sdw_drv_remove(), not sdw_delete_slave().
> 
> The sdw_slave objects are created by the bus manager probe() from
> ACPI/DT information. They are not created when a child driver probes
> so should not be deleted by a child driver remove.
> 
> Change-Id: I25cc145df12fdc7c126f8f594a5f76eedce25488

spurious Change-Id

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/bus.c   | 30 ++++++++++++++++++++++++++----
>  drivers/soundwire/slave.c | 21 +++++++++++++++++----
>  2 files changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 1327a312be86..5533eb589286 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -146,9 +146,8 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>  }
>  EXPORT_SYMBOL(sdw_bus_master_add);
>  
> -static int sdw_delete_slave(struct device *dev, void *data)
> +static int sdw_delete_slave(struct sdw_slave *slave)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct sdw_bus *bus = slave->bus;
>  
>  	sdw_slave_debugfs_exit(slave);
> @@ -163,7 +162,24 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  	list_del_init(&slave->node);
>  	mutex_unlock(&bus->bus_lock);
>  
> +	mutex_destroy(&slave->sdw_dev_lock);
> +	kfree(slave);
> +
> +	return 0;
> +}
> +
> +static int sdw_remove_child(struct device *dev, void *data)
> +{
> +	/*
> +	 * Do not remove the struct sdw_slave yet. This is created by
> +	 * the bus manager probe() from ACPI information and used by the
> +	 * bus manager to hold status of each peripheral. Its lifetime
> +	 * is that of the bus manager.
> +	 */
> +
> +	/* This will call sdw_drv_remove() */
>  	device_unregister(dev);
> +
>  	return 0;
>  }
>  
> @@ -171,16 +187,22 @@ static int sdw_delete_slave(struct device *dev, void *data)
>   * sdw_bus_master_delete() - delete the bus master instance
>   * @bus: bus to be deleted
>   *
> - * Remove the instance, delete the child devices.
> + * Remove the child devices, remove the master instance.
>   */
>  void sdw_bus_master_delete(struct sdw_bus *bus)
>  {
> -	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
> +	struct sdw_slave *slave, *tmp;
> +
> +	device_for_each_child(bus->dev, NULL, sdw_remove_child);
>  
>  	/* Children have been removed so it is now safe for the bus to stop */
>  	if (bus->ops->remove)
>  		bus->ops->remove(bus);
>  
> +	/* Now the bus is stopped it is safe to free things */
> +	list_for_each_entry_safe(slave, tmp, &bus->slaves, node)
> +		sdw_delete_slave(slave);
> +
>  	sdw_master_device_del(bus);
>  
>  	sdw_bus_debugfs_exit(bus);
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index c1c1a2ac293a..b6161d002b97 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -10,10 +10,23 @@
>  
>  static void sdw_slave_release(struct device *dev)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> -
> -	mutex_destroy(&slave->sdw_dev_lock);
> -	kfree(slave);
> +	/*
> +	 * The release() callback should not be empty
> +	 * (see Documentation/core-api/kobject.rst) but the ownership
> +	 * of struct sdw_slave is muddled. It is used for two separate
> +	 * purposes:
> +	 * 1) by the bus driver to track its own state information for
> +	 *    physical devices on the bus and found in ACPI/DT, whether
> +	 *    or not there is a child driver for it;
> +	 * 2) to hold the child driver object.
> +	 *
> +	 * The struct sdw_slave cannot be freed when the child driver
> +	 * is released because it is holding info used by the bus
> +	 * driver. It is freed when the bus driver is removed.
> +	 *
> +	 * Until the ownership issue is untangled this cannot free
> +	 * the struct sdw_slave object containing the child dev.
> +	 */
>  }
>  
>  struct device_type sdw_slave_type = {

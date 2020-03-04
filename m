Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E07C3F2CE
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 16:29:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D06C22522
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 16:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZjNTa7xt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yCatE1f8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D06C22522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D67EA843;
	Wed,  4 Mar 2020 17:28:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D67EA843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583339379;
	bh=5ydkZ9GI1xp5CSnH6d1x60QXKXUBFoGsFKeAO+VEw6s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZjNTa7xt1AVlIHfW7meEW6JxV1iFshuQceMikZqu1Bc9SaBCoh7hw99DZTbVc2PqB
	 OgHsj4fzQ8X2v4orHe6Za1T5hyv7wZ+UFWOz/Ob9YTq8+L7sEv6S9PevquEWKMpCTw
	 hfb44FRAFx7sSa8u5/tdkWKHLDHBF+kgNByjQPKM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CD59F801EC;
	Wed,  4 Mar 2020 17:28:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EBD5F801ED; Wed,  4 Mar 2020 17:28:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B1A8F8011C
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 17:28:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B1A8F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="yCatE1f8"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 29E6922522;
 Wed,  4 Mar 2020 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583339319;
 bh=5ydkZ9GI1xp5CSnH6d1x60QXKXUBFoGsFKeAO+VEw6s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yCatE1f8ucLJ2F2C285nv2wSRkWZxUXTxj8XLMzEWid4bqiN+ar8IYm4xkSnsjC77
 vz9iVOWr1hd6Qll+HjWet5SQoRUZ39jgplHCJRmIk7F4tQUD2F/CIct6AxVbVq6CQW
 yMWQwWd0cRLml5nCP+DJzlXu6UTzEVwCQ7fc/NeQ=
Date: Wed, 4 Mar 2020 17:28:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
Message-ID: <20200304162837.GA1763256@kroah.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-2-pierre-louis.bossart@linux.intel.com>
 <20200303054136.GP4148@vkoul-mobl>
 <8a04eda6-cbcf-582f-c229-5d6e4557344b@linux.intel.com>
 <20200304095312.GT4148@vkoul-mobl>
 <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
 Vinod Koul <vkoul@kernel.org>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
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

On Wed, Mar 04, 2020 at 09:17:07AM -0600, Pierre-Louis Bossart wrote:
> 
> 
> > Were the above lines agreed or not? Do you see driver for master devices
> > or not? Greg was okay with as well as these patches but I am not okay
> > with the driver part for master, so I would like to see that removed.
> > 
> > Different reviewers can have different reasons.. I have given bunch of
> > reasons here, BUT I have not seen a single technical reason why this
> > cannot be done.
> 
> With all due respect, I consider Greg as THE reviewer for device/driver
> questions. Your earlier proposal to use platform devices was rejected by
> Greg, and we've lost an entire month in the process, so I am somewhat
> dubious on your proposal not to use a driver.
> 
> If you want a technical objection, let me restate what I already mentioned:
> 
> If you look at the hierarchy, we have
> 
> PCI device -> PCI driver
>   soundwire_master_device0
>      soundwire_slave(s) -> codec driver
>   ...
>   soundwire_master_deviceN
>      soundwire_slave(s) -> codec driver
> 
> You have not explained how I could possibly deal with power management
> without having a driver for the master_device(s). The pm_ops need to be
> inserted in a driver structure, which means we need a driver. And if we need
> a driver, then we might as well have a real driver with .probe .remove
> support, driver_register(), etc.

To weigh in here, yes, you need such a "device" here as it isn't the PCI
device that you can use, you need your own.  Just like most other busses
have this (USB has host controller drivers as one example, that create
the "root bus" device that all other USB devices hang off of.)  This
"controller device" should hang off of the hardware device be it a
platform/PCI/i2c/spi/serial/whatever type of controller.  That's why it
is needed.

> I really don't see what's broken or unnecessary with these patches.

The "wait until something else happens" does seem a bit hacky, odds are
that's not really needed if you are using the driver model correctly,
but soundwire is "odd" in places so maybe that is necessary, I'll defer
to you two on that mess :)

thanks,

greg k-h

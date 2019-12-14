Return-Path: <SRS0=xxPz=2E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA537C43603
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 08:28:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363BD20706
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Dec 2019 08:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YjscrtUt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPfip066"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363BD20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85B2C1662;
	Sat, 14 Dec 2019 09:27:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85B2C1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576312121;
	bh=5sUT0DSG/b2JGAxc+e6rPCNquc0IB70r9qPxYybi0VE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YjscrtUtQetwiHyM+/bOTKz8wzbSKqn37OD3y/xujzA4ZCikRsk4uQvc2NaV+P5II
	 SgNt3J18afRRTCGH0T1Pr5OeteXJz/QAQUvKXIRBJa81Yh9E+xEvmKIQMYrs8krGnw
	 u35QBW4Pr3shbueJseI4eK+i3P9w1JaRVO5T/zqE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11D46F80139;
	Sat, 14 Dec 2019 09:27:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE4B3F8020C; Sat, 14 Dec 2019 09:27:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39CC9F8014F
 for <alsa-devel@alsa-project.org>; Sat, 14 Dec 2019 09:27:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39CC9F8014F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iPfip066"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 01EE720706;
 Sat, 14 Dec 2019 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576312065;
 bh=YfYMxk4JzVffoALHiMNEb7YBKeYiCaTwSAvFQyGwuW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iPfip066pDvDhwPSLDOIZHCbNb2KXELCqM5WVUR/2NvxgGdUYw8pNe0sHO3v0guao
 T9X6p+/sbf1jmfmmKNxhrRGfzN6YYI4G8q35hjC/mG7gh5UuxO3/rSpnGnodknWb0V
 E2OQzYsr6Svdkup7gNOP1V+lnefv6H6859h9ma4w=
Date: Sat, 14 Dec 2019 09:27:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20191214082742.GA3318534@kroah.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
 <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
 <20191213161046.GA2653074@kroah.com>
 <20728848-e0ae-01f6-1c45-c8eef6a6a1f4@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20728848-e0ae-01f6-1c45-c8eef6a6a1f4@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: add initial
 definitions for sdw_master_device
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Dec 13, 2019 at 05:25:23PM -0600, Pierre-Louis Bossart wrote:
> 
> > No, I mean the new MODULE_NAMESPACE() support that is in the kernel.
> > I'll move the greybus code to use it too, but when you are adding new
> > apis, it just makes sense to use it then as well.
> 
> Greg, would the patch below be what you had in mind?
> Thanks
> -Pierre
> 
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 76a5c52b12b4..5bad8422887e 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -7,9 +7,11 @@ ccflags-y += -DDEBUG
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o
> stream.o
>  obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
> +ccflags-$(CONFIG_SOUNDWIRE) += -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE
> 
>  soundwire-generic-allocation-objs := generic_bandwidth_allocation.o
>  obj-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) +=
> soundwire-generic-allocation.o
> +ccflags-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) +=
> -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE

Don't use ccflags, just use the correct MODULE_EXPORT_NS() tag instead.

And "SDW_CORE" is odd, "SOUNDWIRE" instead?

thanks,

greg k-h
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

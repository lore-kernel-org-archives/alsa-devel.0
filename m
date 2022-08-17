Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD62C25B08
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Aug 2022 06:32:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDE7E84C;
	Wed, 17 Aug 2022 08:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDE7E84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660717948;
	bh=mwtulZ4Hp+CocMD8YRBKXqWk+VW7tePvSlvVSfMPzrE=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sciPoUZGUfuWbf/CA6ZEjxy2G+cxKg+1m2VnVI1d+CZCyzevvLXydzKs8tTXgGf2X
	 rLV63LoD48wSgoQHZK7qExUfqltYuBZLGhXFScojSaK+kUi6NDS3Xw3EepSP6klu3n
	 tkqOUG+jplVIOR8o1eudfTWrQRyzQ6JWz8uEmR0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4046FF80237;
	Wed, 17 Aug 2022 08:31:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 576B1F8025C; Wed, 17 Aug 2022 08:31:36 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8373DF80082
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2022 08:31:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8373DF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Pa9aqrzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660717890; x=1692253890;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mwtulZ4Hp+CocMD8YRBKXqWk+VW7tePvSlvVSfMPzrE=;
 b=Pa9aqrzootKBQT5MZz8XtmH46SPVvOtWVZOO8HvLdj4JY88WMU4d+S3U
 LbPSXQCoBHWyHPfB03QWuLEF+N3VPKxG3GFXzklzCKeaSQyk8jO7KSSbD
 rmBudcpWx3816XmVETVKgGdSCwAYKWMCkz5OLc+u3RxAAHSfsiewu4xi0
 D4LrKBFxxybr97TjulfG2jh/vNsXE1fnW6xS3DA/F1s1l8lZpYJafrNSu
 /t1NLCpVaYoY+Gu9lMR0A+G18A6XRbd2Of8Ajj1pVuqho8vU2e4UVL6Xt
 /qYx2h70WI9GnqeySwqFJEP3+bfWsMa4ilKEL7i+aDejgkzd8OW1wl6+W Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="354159698"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; d="scan'208";a="354159698"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 23:31:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; d="scan'208";a="675518280"
Received: from rdegreef-mobl1.ger.corp.intel.com (HELO [10.252.49.182])
 ([10.252.49.182])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 23:31:23 -0700
Message-ID: <a92f5041-9630-66ee-1757-4b58bdaabe90@linux.intel.com>
Date: Wed, 17 Aug 2022 08:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 linux-next] Remove Unnecessary TODO
Content-Language: en-US
To: Khalid Masum <khalid.masum.92@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20220816175954.5259-1-khalid.masum.92@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220816175954.5259-1-khalid.masum.92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>
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



On 8/16/22 19:59, Khalid Masum wrote:
> The capabilities enabled for multi-link are required as part of the
> programming sequences, even when a stream uses a single link we still
> use the syncArm/syncGo sequences. Therefore the TODO is no longer
> necessary.
> 
> Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>

the title of your patch should be something like

soundwire: intel: remove unnecessary TODO

so that the patch scope and context is clearly identified.
> ---
> Previous discussions:
> - v1 Link: https://lore.kernel.org/lkml/20220814080416.7531-1-khalid.masum.92@gmail.com/
> 
> Changes since v1:
> - Remove the todo, leave rest of the code as is
> - Update commit message
> 
>  drivers/soundwire/bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 8d4000664fa3..18158825a6d8 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -75,7 +75,6 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>  
>  	/*
>  	 * Initialize multi_link flag
> -	 * TODO: populate this flag by reading property from FW node
>  	 */
>  	bus->multi_link = false;
>  	if (bus->ops->read_prop) {

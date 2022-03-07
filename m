Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0114C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 16:40:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FD771708;
	Mon,  7 Mar 2022 17:39:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FD771708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646671242;
	bh=EoMwT7XroUqXHHO2Z0YMy2QbMA4SIYCBYpApenFHGsM=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UYqUP6uspTwh3Mp6WxijxaazkjATo6dWtBx4rszL3NLktgKz2ygrjFYebsR1kj320
	 9hWvH6DuSHxZX4bKKLVi7oOVocoW8NTr2F4VWqgGDu3Ol1I3LjjjRO0bWclGKiNPX3
	 EzYdUuWdKM/+Q+o1U90ELn9rUoHXczI1oa5NS3Bo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31BFBF80124;
	Mon,  7 Mar 2022 17:39:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BAB1BF800E9; Mon,  7 Mar 2022 17:39:50 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D6BBF800E9
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 17:39:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D6BBF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="TF5zAoaO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646671189; x=1678207189;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EoMwT7XroUqXHHO2Z0YMy2QbMA4SIYCBYpApenFHGsM=;
 b=TF5zAoaOmYcIzJgnSdth34B9SKVHv69JeRBKgfAmlu3BKFIC/LkoGkS3
 u70PLDY7h/Y/FhtKFhkqR6Wa0+qUmZQEGBR8aHsnPzRra99neQdiOauqp
 DtYqTVRuJfVo5spQHL4gdFG0eUKx0Y9zj6GnZ4ReXOx7h9FlnTFJm+kAH
 zNGzoJoqxMRqAfvHhKEIbU6U0QPhsyMK8al+FjjjLn9EaudfyPfySMLkp
 w+eWpy00bFycLa2qFjCCpzHYdoMzXxogHnOmXXmWaTt65BD1Tis01RFH4
 y3c/Uij1mzMdTx/1UuVc5ZZzEsZQbYSySbEhS9WHJsuwG08voM3fZJ+xf Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="279144660"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; d="scan'208";a="279144660"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 08:39:18 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; d="scan'208";a="546946816"
Received: from zhaojohn-mobl1.amr.corp.intel.com ([10.254.24.100])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 08:39:17 -0800
Message-ID: <886dacf8fdffb08af26cea6e754d09d4ed7811ea.camel@linux.intel.com>
Subject: Re: [PATCH v3 07/17] ASoC: Intel: avs: Add module management requests
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Date: Mon, 07 Mar 2022 08:39:17 -0800
In-Reply-To: <e463df51-a0a5-b863-0cd6-80b1d60dc09b@intel.com>
References: <20220304145755.2844173-1-cezary.rojewski@intel.com>
 <20220304145755.2844173-8-cezary.rojewski@intel.com>
 <0e7e51e94157c6ca43957b27a13fd4cf058bfc33.camel@linux.intel.com>
 <e463df51-a0a5-b863-0cd6-80b1d60dc09b@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: upstream@semihalf.com, harshapriya.n@intel.com, rad@semihalf.com,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 cujomalainey@chromium.org, lma@semihalf.com
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

On Fri, 2022-03-04 at 18:21 +0100, Cezary Rojewski wrote:
> > Are there any rules for unbinding? For example if you have 2
> > modules
> > connected to a mixer? Can you unbind the module belonging to the
> > host
> > pipeline that is getting stopped while the mixer is still active?
> 
> 
> 
> 
> Here we have just a delegate. All the rules are defined and enforced
> by 
> 
> the firmware.
I'm not following this, Czarek. If there are rules defined by the FW,
the driver has to follow it isnt it? What I am asking is how and where
do you enforce this in the AVS driver?

...
> > > 
> > How come you dont have a loop here? What if the rec'd data size if
> > larger than the max size of IP payload?
> 
> 
> 
> 
> That's not how LARGE_CONFIG_GET message works. There is no looping 
> 
> involved or expected by the firmware and so we don't have it here.

So, are you saying that when retrieving data from the FW, the size of
the retrieved data can never exceed max IPC payload size?

Thanks,Ranjani


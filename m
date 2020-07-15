Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD85C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:50:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E6F206E9
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TAXhailY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E6F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E3FD1677;
	Wed, 15 Jul 2020 16:49:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E3FD1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594824622;
	bh=+yClnskVSFfeeGf3GDjoasrPtgoMn15H5ERXZ+tRhYE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TAXhailYD+lP/GlZY1a1AZ+uaBPaiMu6dZimlnyqT+MQqRqmFXiklodW9Ti5ALttp
	 OS+DdWxX6HcCM0EZbIFH590BIIWnjAX2Q68xSmqPjEPVWYJ7Buzd/+i92nnl/LzPAE
	 u0Mw6mqN6PhHl9NkA1P15Lbx2vS9s/xvygAa06VE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E03CF80240;
	Wed, 15 Jul 2020 16:48:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1A26F8023F; Wed, 15 Jul 2020 16:47:59 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A088F80227
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 16:47:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A088F80227
IronPort-SDR: M0YoqudEEiK8uDkqDCyppam1syx6E25WoT/ddKimgmMM7cK2uIsPVj/Ktw6duKsXD9m1bc6/lo
 WmYxFkEd+Vew==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="128724458"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; d="scan'208";a="128724458"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 07:47:51 -0700
IronPort-SDR: 2PEY05RyeCelEeM3/hoBzsX/PD/wRwIaJOupts6VsrFw5GAlPN/WPkWJe7l97a+fZ0v4q6zYmJ
 sUfLzTP/cKeA==
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; d="scan'208";a="460114380"
Received: from sjeong-mobl.amr.corp.intel.com (HELO [10.255.231.101])
 ([10.255.231.101])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 07:47:50 -0700
Subject: Re: [PATCH] soundwire: fix the kernel-doc comment
To: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org
References: <20200715095702.1519554-1-vkoul@kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7498c581-94fe-140b-c521-786f0dea7b3d@linux.intel.com>
Date: Wed, 15 Jul 2020 09:42:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715095702.1519554-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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



On 7/15/20 4:57 AM, Vinod Koul wrote:
> sdw_startup_stream() and sdw_shutdown_stream() argument has been updated
> but not the comments, so update these as well to fix warning with W=1
> 
> drivers/soundwire/stream.c:1859: warning: Function parameter or member 'sdw_substream' not described in 'sdw_startup_stream'
> drivers/soundwire/stream.c:1859: warning: Excess function parameter 'stream' description in 'sdw_startup_stream'
> drivers/soundwire/stream.c:1903: warning: Function parameter or member 'sdw_substream' not described in 'sdw_shutdown_stream'
> drivers/soundwire/stream.c:1903: warning: Excess function parameter 'stream' description in 'sdw_shutdown_stream'
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

After sending dozens of patches to fix those issues I added one by 
accident, oh well. Thanks for fixing this.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

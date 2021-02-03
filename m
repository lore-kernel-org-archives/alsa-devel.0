Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5CCC433DB
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 11:05:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFC964E42
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 11:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFC964E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47ABD16CD;
	Wed,  3 Feb 2021 12:04:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47ABD16CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612350300;
	bh=nTKbJIzMVgfvkQz2CHCRBxy6K5TLiaBik2oQ2yvXaVk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eyWsuElJSb9Dic++HBIh5mqGnNVVatDFNUQvntgXLVZzJbWnbs/dFSJlaQYqRiL0n
	 LDVSk1dPDq7uxHRpzNvM7YhAK+R3Sa2eqCU5oN9aeaMLuL3lTQw1rg9uKFbNtENjLT
	 rib4jO033jwN5L3ZrPLB1vMOlGng7bd3K6ypYGrY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB98BF80156;
	Wed,  3 Feb 2021 12:04:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4634BF8015A; Wed,  3 Feb 2021 12:04:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4BC3F80155
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2021 12:04:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4BC3F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uubw5WQj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C16E664E42;
 Wed,  3 Feb 2021 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612350242;
 bh=nTKbJIzMVgfvkQz2CHCRBxy6K5TLiaBik2oQ2yvXaVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uubw5WQjqVOHLWytf9ROZ8n2LxH4R5ANttzp/WETJ8tW/jtRyvNC47akzw7zFgImO
 ExdWweW4OmW2Nn/8WZvR7wReKC9btWwT3ZUwzmkcl+JpO40di0a1nt+tQBbAed2Idu
 k8mmuj6fOC+2Av+xku9AvEF5iN01xxWBYdmFsTQW+uDfI6BPux2AhsuFXgzBvz+eKt
 De42EuniitBDQwLLXw56+CS7Eb3lnFZe/Y2pgO9QFSIRcu4ue1nZS7Ypgq0YivQUmq
 9u4H6rl7Yx4QORnySHxK0NN5rC1Y5qxXLg/MJcGlucgLNfrimvAKSRN4v6oTyeq1Sg
 aQWvo5yTA8Swg==
Date: Wed, 3 Feb 2021 16:33:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
Message-ID: <20210203110358.GL2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
 <20210201102844.GU2771@vkoul-mobl>
 <20210201103825.GV2771@vkoul-mobl>
 <7c4e1163-a6b3-2886-1963-7e2847dc2836@linux.intel.com>
 <20210202043909.GG2771@vkoul-mobl>
 <4117cd57-1643-758f-b59c-ac507a6f5ed2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4117cd57-1643-758f-b59c-ac507a6f5ed2@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org, jank@cadence.com,
 sanyog.r.kale@intel.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On 02-02-21, 10:52, Pierre-Louis Bossart wrote:
> 
> 
> On 2/1/21 10:39 PM, Vinod Koul wrote:
> > On 01-02-21, 10:18, Pierre-Louis Bossart wrote:
> > > On 2/1/21 4:38 AM, Vinod Koul wrote:
> > > > On 01-02-21, 15:58, Vinod Koul wrote:
> > > > > On 26-01-21, 16:37, Bard Liao wrote:
> > > > 
> > > > > >    struct sdw_master_prop {
> > > > > >    	u32 revision;
> > > > > > @@ -421,8 +422,11 @@ struct sdw_master_prop {
> > > > > >    	u32 err_threshold;
> > > > > >    	u32 mclk_freq;
> > > > > >    	bool hw_disabled;
> > > > > > +	u32 quirks;
> > > > > 
> > > > > Can we do u64 here please.. I dont know where we would end up.. but
> > > > > would hate if we start running out of space ..
> > > No objection.
> > > 
> > > > Also, is the sdw_master_prop right place for a 'quirk' property. I think
> > > > we can use sdw_master_device or sdw_bus as this seems like a bus
> > > > quirk..?
> > > 
> > > It's already part of sdw_bus
> > 
> > Right, but the point is that the properties were mostly derived from
> > DiSco, so am bit skeptical about it adding it there..
> 
> Oh, I am planning to contribute such quirks as MIPI DisCo properties for the
> next revision of the document (along with a capability to disable a link).
> This was not intended to remain Linux- or Intel-specific.

Okay lets keep it in properties then

-- 
~Vinod

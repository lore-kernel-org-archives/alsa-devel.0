Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB68C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 04:40:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5882764EDC
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 04:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5882764EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 340921728;
	Tue,  2 Feb 2021 05:39:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 340921728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612240813;
	bh=sbBEYF5ak+9t4EThBkvi2dHpSTMhpT5r2z0w2boWngQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HuDCnm2JevPMvY2W/MLctpM5P6mFFp3nZK8kvdcr6AmwmCPTgoczL4SQCmMavroMs
	 BAlL1MZuE0Xp6CCBQtWxTzoK7phpPhZHOiJLdITQ3HqQgZ9mBg4uzeYG3gTxhgLcuA
	 cjc28JAyzsYIlbHGlOL2PRg/8kqA64ilEArRcg1I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8A79F80152;
	Tue,  2 Feb 2021 05:39:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9E67F80171; Tue,  2 Feb 2021 05:39:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD529F80109
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 05:39:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD529F80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ETBNY+MY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 155F864EC3;
 Tue,  2 Feb 2021 04:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612240754;
 bh=sbBEYF5ak+9t4EThBkvi2dHpSTMhpT5r2z0w2boWngQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ETBNY+MYJ2XizOuGlgif0xzxPKPaOg9H/bnwROlonHLs+2CTaPNgTagT4sXKw24N9
 Wp3yA41mQ4eBT1rft+aoD9MvwRLL6Krlu3QZgI3y6QvhFKo48B4T7EGgYuqq2gg6im
 3fcxcr1bjkSo9KsqIlBuwKfVl5dYBbYdi2jO+0UFI/mUQrW4ZyT4fWwWzyF8EA180a
 NxGrQMDYN6QlLPEqDrdHw7Bb7hsmwZx7cVbTKllMp/iBkJBNnrCrFjKM9A1gHNd601
 DlFnmskLocdaRT4DKEIf8+mbSidcw2expg57iPdERENxr5QzScWKJfi1uXEgn8m032
 gogXVOGKFzQAA==
Date: Tue, 2 Feb 2021 10:09:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
Message-ID: <20210202043909.GG2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
 <20210201102844.GU2771@vkoul-mobl>
 <20210201103825.GV2771@vkoul-mobl>
 <7c4e1163-a6b3-2886-1963-7e2847dc2836@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4e1163-a6b3-2886-1963-7e2847dc2836@linux.intel.com>
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

On 01-02-21, 10:18, Pierre-Louis Bossart wrote:
> On 2/1/21 4:38 AM, Vinod Koul wrote:
> > On 01-02-21, 15:58, Vinod Koul wrote:
> > > On 26-01-21, 16:37, Bard Liao wrote:
> > 
> > > >   struct sdw_master_prop {
> > > >   	u32 revision;
> > > > @@ -421,8 +422,11 @@ struct sdw_master_prop {
> > > >   	u32 err_threshold;
> > > >   	u32 mclk_freq;
> > > >   	bool hw_disabled;
> > > > +	u32 quirks;
> > > 
> > > Can we do u64 here please.. I dont know where we would end up.. but
> > > would hate if we start running out of space ..
> No objection.
> 
> > Also, is the sdw_master_prop right place for a 'quirk' property. I think
> > we can use sdw_master_device or sdw_bus as this seems like a bus
> > quirk..?
> 
> It's already part of sdw_bus

Right, but the point is that the properties were mostly derived from
DiSco, so am bit skeptical about it adding it there..

> struct sdw_bus {
> 	struct device *dev;
> 	struct sdw_master_device *md;
> 	unsigned int link_id;
> 	int id;
> 	struct list_head slaves;
> 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
> 	struct mutex bus_lock;
> 	struct mutex msg_lock;
> 	int (*compute_params)(struct sdw_bus *bus);
> 	const struct sdw_master_ops *ops;
> 	const struct sdw_master_port_ops *port_ops;
> 	struct sdw_bus_params params;
> 	struct sdw_master_prop prop;
> 
> The quirks could be set by a firmware property, and it seems logical to add
> them at the same place where we already have properties defined in firmware,
> no? That way all the standard, vendor-specific and quirks are read or added
> in the same place.

Or they could be set by driver as well based on device id, compatible
and so on.. It maybe fw property as well, so limiting to property may not
be best idea IMO.

> the sdw_master_device isn't a good place for quirks IMHO, it's a very
> shallow software-only layer without any existing ties to the hardware
> definition.

This one I would agree.

-- 
~Vinod

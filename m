Return-Path: <SRS0=f902=47=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED52BC0044D
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:51:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7E720753
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ge4/SNF1";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir4zF9+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7E720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7A94185F;
	Sat, 14 Mar 2020 10:50:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7A94185F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584179484;
	bh=PG8ONfwbNIWRFQWv4oK7dPOCnqVwMfGzzAEvdN+LO3U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ge4/SNF1RxWASkEc99yOA1TxMLdGc38Hlq08R1zg3s6p3BpekU37X5y+9nIspa1pu
	 fmY34FhbWkUgP3C+h0Wr03qM97fBBxgJZxLNml/Vrt8qr84XzKYrFm/Ga16qldx3ok
	 HYIcRXZh04TmgO7E9yhg3z7EWcn2uUhTziwx0PSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47B9FF8013E;
	Sat, 14 Mar 2020 10:50:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99644F8021C; Sat, 14 Mar 2020 10:50:32 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E1A4F8013E
 for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2020 10:50:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E1A4F8013E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ir4zF9+p"
Received: from localhost (unknown [122.167.115.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53C9420752;
 Sat, 14 Mar 2020 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584179428;
 bh=PG8ONfwbNIWRFQWv4oK7dPOCnqVwMfGzzAEvdN+LO3U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ir4zF9+pvZAZ/J+1AxyFqo1b036riCM3vscJfbL/WizEfB8/vYi+ZB3U9rL2Fur2Z
 DmH+xQmT9F4WQImtm4/e5aO3kf0mVXaipMohN0g9iOujAVug2SGdGPrZhsxYx6Y04q
 sKbbsmezewvgvZIIseJi5ZP/2RxX1A61TzVrIkV0=
Date: Sat, 14 Mar 2020 15:20:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 03/16] soundwire: cadence: add interface to check clock
 status
Message-ID: <20200314095019.GQ4885@vkoul-mobl>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-4-pierre-louis.bossart@linux.intel.com>
 <20200313120607.GE4885@vkoul-mobl>
 <816cc363-5b49-9b04-54a4-be4f53001cc5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <816cc363-5b49-9b04-54a4-be4f53001cc5@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>, Rander Wang <rander.wang@intel.com>,
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

On 13-03-20, 11:31, Pierre-Louis Bossart wrote:
> 
> 
> > > +/**
> > > + * sdw_cdns_is_clock_stop: Check clock status
> > > + *
> > > + * @cdns: Cadence instance
> > > + */
> > > +bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns)
> > > +{
> > > +	u32 status;
> > > +
> > > +	status = cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP;
> > > +	if (status) {
> > > +		dev_dbg(cdns->dev, "Clock is stopped\n");
> > > +		return true;
> > > +	}
> > 
> > This can be further optimized to:
> > 
> >          return !!(cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP);
> 
> The logs are very useful for debug.

You have this log also in caller function.

-- 
~Vinod

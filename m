Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB60C00140
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Aug 2022 14:05:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BBDF1F7;
	Wed, 24 Aug 2022 16:05:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BBDF1F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661349950;
	bh=jzY+J49GD3rOUmr1IT0CbRZZacULTEfe/pHHgT4Thyw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Py9DWRzDH+HdyxWxaDYITHs07LmTpcUxCOfNg1U3oaTyxXZdB7PCvVWKYv42W3ACL
	 t1bRN34VMGgiT2T5krW60zPbNMkSkqMIfCbd638JEIL2Ou1eEZ/nlewOqRRZc4YH5y
	 yATwH9J0A8p/INm4fcVnqRU3PWjPhSnWkSaFgRDg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8D0CF8014E;
	Wed, 24 Aug 2022 16:04:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE07FF804BD; Wed, 24 Aug 2022 16:04:58 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1F95F800A7
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2022 16:04:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1F95F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="sL2TsN36"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9F178B823B5;
 Wed, 24 Aug 2022 14:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBED6C433D6;
 Wed, 24 Aug 2022 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1661349894;
 bh=jzY+J49GD3rOUmr1IT0CbRZZacULTEfe/pHHgT4Thyw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sL2TsN36+wFT8OjFHzMZ/R5tnpVNb7+T1J7BZT4rBKODV90gbm1oYBB6MUM2z8s65
 1BAp3WZoocV2VrG+43EGP+JoYOKjDOjbpGRSJz8HULOkhQ9drp9JBz/uplcLFQHb8V
 C0koAI4k5LfIvstJMOl7ITas9Pa4yB9GqAu52h3c=
Date: Wed, 24 Aug 2022 16:04:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/5] soundwire: sysfs: move sdw_slave_dev_attr_group into
 the existing list of groups
Message-ID: <YwYwA5vnE/0bRYvF@kroah.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <YwT5gqOihDYK73aF@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwT5gqOihDYK73aF@matsya>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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

On Tue, Aug 23, 2022 at 09:30:02PM +0530, Vinod Koul wrote:
> On 29-07-22, 15:50, Greg Kroah-Hartman wrote:
> > The sysfs logic already creates a list of groups for the device, so add
> > the sdw_slave_dev_attr_group group to that list instead of having to do
> > a two-step process of adding a group list and then an individual group.
> > 
> > This is a step on the way to moving all of the sysfs attribute handling
> > into the default driver core attribute group logic so that the soundwire
> > core does not have to do any of it manually.
> 
> Hey Greg,
> 
> DO you have a v2 for this, or if you are too busy I can update the
> patchset...

v2 is now here:
	https://lore.kernel.org/r/20220824135951.3604059-1-gregkh@linuxfoundation.org

Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF6C48BD1
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 13:30:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33974613FA
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 13:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33974613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2C3C193D;
	Fri, 11 Jun 2021 15:30:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2C3C193D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623418255;
	bh=5syIn+RCk4Eumnt8SPMfARRletWX4c3GwaWbmkOsZ0U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TmVN/p1ki8449e2h8VK+/jpqmVD1VEYC095O0hycfhMLUMQjiGkqLAeSCXPbmNqox
	 jXW6C3ILAocAheAb2LtVzRCqk8ixqtaIz0JfKDhECNhK7UPEV6olIqhNeDBMAkS5yX
	 PaqdR+96YsRgaO4Ad1bUzV3sphJ+w2VrZ4Ki8MIo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D1FBF800FB;
	Fri, 11 Jun 2021 15:30:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BA70F8026C; Fri, 11 Jun 2021 15:29:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 755EAF800FB
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 15:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 755EAF800FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="ww7KB1r+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68D97613FA;
 Fri, 11 Jun 2021 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623418167;
 bh=5syIn+RCk4Eumnt8SPMfARRletWX4c3GwaWbmkOsZ0U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ww7KB1r+D6dLROk8dlMYpi8iAR+fwNDQlEDSaCPbj5ILCyBZIVmxoxZuhCrKnpvKj
 8IDtkwQZd5W6UKgQfJmVQrV21q17wF8pVvEaTtvilYc+1BUFqEt3ecnEdzHqeQS4TL
 e4fCFA5MiVakh10bIUuEx1haWK3nCHSjqgUsbvn4=
Date: Fri, 11 Jun 2021 15:29:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
Message-ID: <YMNlND32rR9aKWeW@kroah.com>
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
 <YMBHj6PBzeHexXJb@vkoul-mobl>
 <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
 <20210609151022.GF1002214@nvidia.com> <YMNIfHPRcgKLXJ0v@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMNIfHPRcgKLXJ0v@vkoul-mobl>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, hui.wang@canonical.com,
 Jason Gunthorpe <jgg@nvidia.com>, Dave Ertman <david.m.ertman@intel.com>,
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

On Fri, Jun 11, 2021 at 04:56:52PM +0530, Vinod Koul wrote:
> On 09-06-21, 12:10, Jason Gunthorpe wrote:
> > On Wed, Jun 09, 2021 at 09:44:08AM -0500, Pierre-Louis Bossart wrote:
> > 
> > > The consensus for the auxiliary_device model was hard to reach, and the
> > > agreement was to align on a minimal model. If you disagree with the
> > > directions, you will have to convince Nvidia/Mellanox and Intel networking
> > > folks who contributed the solution to do something different.
> > 
> > The purpose of the aux devices was primarily to bind a *software*
> > interface between two parts of the kernel.
> 
> Then I dont think this example is valid... This example has a PCI device,
> which represents a DSP, HDA controller, DMICs, Soundwire
> links... So at least here it is hardware.

Yes, and that's fine, and exactly what aux devices were created for.

You divide up a single logically addressable device into differently
handled portions.

Not all hardware specs were as "smart" as USB was in allowing multiple
drivers to bind to the same physical USB device and talk to it at the
same time :)

Luckily the USB spec authors learned from the mistakes of PCI...

thanks,

greg k-h

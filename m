Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F2C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:38:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4152070E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UXNOe18x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1GzAflTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4152070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB7DF1682;
	Mon, 22 Jun 2020 13:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB7DF1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592825928;
	bh=lTqhDw3Cd5G+/fDtevGJJEA+nU1N8tNEJV1wtaYsQMc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXNOe18xgcrtfO/Mmab0ztZahM5WGw4bBcxf82FvirmLSWXCWEfv3vhys6kp68v3Z
	 TWANsK8bv+ETgQO+UC1GIJzBRSL0ttKezXFAnZ/5LCI/bIlvtbGL1FPiMn4xtxQlHM
	 ZPNoeLQS3qCktgGFedvjbXZE0OXfw2LOvvJr6wRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A4D5F8010E;
	Mon, 22 Jun 2020 13:37:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7041F8015B; Mon, 22 Jun 2020 13:37:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43193F80157
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 13:37:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43193F80157
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1GzAflTo"
Received: from localhost (unknown [171.61.66.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 33E9F2070E;
 Mon, 22 Jun 2020 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592825872;
 bh=lTqhDw3Cd5G+/fDtevGJJEA+nU1N8tNEJV1wtaYsQMc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1GzAflToXP3J6cUJt2uRC77c4kvkEndBxv8QJDh5qmMjyEXG/2uyr8znnNdGwf2qp
 v5Mx1DM0+tuNJqnvgWaWRQQdcZ7Lud1tP9oywQeEOD6ONYr8GQGAf9SYLOSsg39+Np
 RSWtnc1MFfp56BzZEAr2hsODeX4/UUIT9xIJPeKM=
Date: Mon, 22 Jun 2020 17:07:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: bus: clock_stop: don't deal with UNATTACHED
 Slave devices
Message-ID: <20200622113747.GI2324254@vkoul-mobl>
References: <20200531151806.25951-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531151806.25951-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
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

On 31-05-20, 23:18, Bard Liao wrote:
> We don't need to do anything for the slave if it is unattached during
> clock stop prepare and exit sequences.

Applied, thanks

-- 
~Vinod

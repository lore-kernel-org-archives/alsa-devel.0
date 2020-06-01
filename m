Return-Path: <SRS0=kaWB=7O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EA5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 05:39:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF3E20734
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 05:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RkDpSjrv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="krFlqurW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF3E20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FED716E3;
	Mon,  1 Jun 2020 07:38:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FED716E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590989956;
	bh=Sk+3FDa4eyUAb7Uu+3xSsOKJ9/rrBhWYlqzvji4jsXo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RkDpSjrvV0UaZmRcHy5oIRNOD6xSs2FECcqhSiipziFEyeS9JMCQQ/gDiwqtOyKLn
	 pR7wLlJn+amAuaz7DBvMt2pMuvgSn8ae51ns9CufB0/vN6XDq2yw3Ud00h+0bZaXOq
	 ApnR9y+ApAuP3k3qE+N8JDDURin39Vm8GPegTWMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE534F801EC;
	Mon,  1 Jun 2020 07:38:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31141F801ED; Mon,  1 Jun 2020 07:38:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF5BAF8013D
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2020 07:38:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF5BAF8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="krFlqurW"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 82FDF20734;
 Mon,  1 Jun 2020 05:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590989893;
 bh=Sk+3FDa4eyUAb7Uu+3xSsOKJ9/rrBhWYlqzvji4jsXo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=krFlqurWHamzAuou74k9Q1caFDcOU2Tp99+qhvroOLva0bOLrtgurEv4RDVDX3XbU
 BcTR3q82CjAHixhwyYO1MMnZ4I4WGc3Rpcnz/ZfyIUEiAGVMoAHw9U5he4n5mev4VB
 FrZ+HJhYsjhY7opQm4fsciRg+eGXRSWAeoMhsbHQ=
Date: Mon, 1 Jun 2020 07:38:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: clarify SPDX use of GPL-2.0
Message-ID: <20200601053809.GA1420218@kroah.com>
References: <20200531172807.27042-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531172807.27042-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 vinod.koul@linaro.org, tiwai@suse.de, mengdong.lin@intel.com,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On Mon, Jun 01, 2020 at 01:28:07AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Change SPDX from GPL-2.0 to GPL-2.0-only for Intel-contributed
> code. This was explicit before the transition to SPDX and lost in
> translation.

It is also explicit in the "GPL-2.0" lines as well, did you read the
LICENSES/preferred/GPL-2.0 file for the allowed tags to be used for this
license?

So this doesn't change anything, and we are trying to cut down on this
type of churn until, maybe, after the whole kernel has proper SPDX
lines.

thanks,

greg k-h

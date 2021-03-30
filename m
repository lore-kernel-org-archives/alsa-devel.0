Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C779FC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 09:07:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8406195C
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 09:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8406195C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30F8E1673;
	Tue, 30 Mar 2021 11:06:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30F8E1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617095254;
	bh=xKYdQCZ7/B2bej8hL7VrKLm+d3H8hUAchReKhoOxgBE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kmUOSMtMLf+jkI1VlRV7dZsFmS+YTSz94aMDbmDEUXG8O8YoELYGDlHT6qGyabMEx
	 SNwAQxRqUwZbBGiNFtpZvOLuy6mFPHH+JwGpn7Esmm92RgDgy6f3eRP5rQyB1X1Vx6
	 wIv93AF9XDSrSHx6hDqnxVEp2DgzMVaMXNdGmmpo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9811F8023E;
	Tue, 30 Mar 2021 11:06:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA3E9F8023E; Tue, 30 Mar 2021 11:06:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EB7DF800B9
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 11:06:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EB7DF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kcYIbULc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF88161929;
 Tue, 30 Mar 2021 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617095188;
 bh=xKYdQCZ7/B2bej8hL7VrKLm+d3H8hUAchReKhoOxgBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kcYIbULcJShX8+WUNtkLCosfz0mNLAc/USK/KYW3RKwD+YTZB+Q7JDWh6jrrTomiY
 5FZ5W/xbehRBDKYZKc5uedMoHbK8Er2ylkvX2GZVwe86pjLAEweBnhOz2KLm/Aom1H
 0/HLw4kq9ylKcO8YuRCNYP/GnZN6pInHXLTMBXs1Iq7miY3aynmehYnegZMPiNJQkn
 OIZlvptqIZS8Ad28NQgChRNjHVSYbzvcQ4KdGycWWefQGHye9x+cRRCTFu67S56Ee8
 B2AFcL/3mmdcwc4D9kzOF35GkNiHFt2H+RS6lZlNqHvDEFyL0OjJH3MvKTdSiwoRDO
 ZR/q8zGjxrQ2w==
Date: Tue, 30 Mar 2021 14:36:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: cadence: only prepare attached devices on
 clock stop
Message-ID: <YGLqEEVTf9a8UUbi@vkoul-mobl.Dlink>
References: <20210323013707.21455-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323013707.21455-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

On 23-03-21, 09:37, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We sometimes see COMMAND_IGNORED responses during the clock stop
> sequence. It turns out we already have information if devices are
> present on a link, so we should only prepare those when they
> are attached.
> 
> In addition, even when COMMAND_IGNORED are received, we should still
> proceed with the clock stop. The device will not be prepared but
> that's not a problem.
> 
> The only case where the clock stop will fail is if the Cadence IP
> reports an error (including a timeout), or if the devices throw a
> COMMAND_FAILED response.

Applied, thanks

-- 
~Vinod

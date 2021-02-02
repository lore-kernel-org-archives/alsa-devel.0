Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A377C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 04:47:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B7A64DD9
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 04:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B7A64DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81FF61703;
	Tue,  2 Feb 2021 05:46:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81FF61703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612241234;
	bh=UW1qYPGwhsrczGp+QodpcDp1sn17mWrlWhPimNr/dJo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bumU4qRHkIl4VaQQJDmQkbqIe9W744uCbe9VC52QU2mhjfjaFBhmOBPwPxBu4DxdK
	 XKb1NV55yXEmdBTVTlCxv+Q6Ye97vsuAMWby2ekOHWd7cHR5IUz9pDKmINsM8hqX+W
	 BN0tRIHtlAcKU3jeZvRV4X5t1TZE0uVuGvbq5DkY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14843F80109;
	Tue,  2 Feb 2021 05:46:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE5CEF80171; Tue,  2 Feb 2021 05:46:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84768F80109
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 05:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84768F80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ToqwdBeP"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6A0B64EDA;
 Tue,  2 Feb 2021 04:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612241171;
 bh=UW1qYPGwhsrczGp+QodpcDp1sn17mWrlWhPimNr/dJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ToqwdBePyZjZTmFxaueUVOtPVDDB+lTx0pDEinu/5fOGPdG1o/Xy77HW6QKrB+TcU
 25EOoqsi9laIoQ6F7CJXRF2s1eF3sEa0mVCb5Kl1aQfodSuUEQ8//zgJWmrsmDDbrQ
 mrlQrUJq/VbOoPFwqK/Br5/fDlEo/799QBNXgtLX1B5Lv6Lh12yZPN63rbt1NKkNTK
 E8kOup4zxSlXGg6kBfNteMFAQVdt8rc7BgV0vBB37YUSWfnolXPHi7KGbDdpXwbAuH
 +ghniSsFnDqMTYM2CEn3HfOaUOfEPAqWxR0VEefPySPa5OF4D0kCCWDmYYAGANCSVb
 pFbZQZ19EOCeg==
Date: Tue, 2 Feb 2021 10:16:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/6] soundwire: qcom: set continue execution flag for
 ignored commands
Message-ID: <20210202044607.GJ2771@vkoul-mobl>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
 <20210201141642.GB2771@vkoul-mobl>
 <1fef14fe-b254-9282-c213-d23e3b7d5f61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fef14fe-b254-9282-c213-d23e3b7d5f61@linaro.org>
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
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

On 01-02-21, 15:50, Srinivas Kandagatla wrote:
> 
> 
> On 01/02/2021 14:16, Vinod Koul wrote:
> > >   	/* Configure number of retries of a read/write cmd */
> > > -	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, SWRM_RD_WR_CMD_RETRIES);
> > > +	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
> > > +	    ctrl->version_step >= 1) {
> > why not use raw version value?
> > 
> >          if (ctrl->raw > 0x10501 )
> > 
> We can do that way as well, but Major Minor seems much clear to readers!

yes but comparison with numbers is always easiest and better :) We can
always add comment that check version 1.5.1 which will make it clear

-- 
~Vinod

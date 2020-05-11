Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC07C47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 06:16:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E8420708
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 06:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u7fsbfnd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTb3jHj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E8420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A01286F;
	Mon, 11 May 2020 08:16:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A01286F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589177811;
	bh=YmpQqO+voOin9Eh8PZUZNka6aTn/VjZ8uHlXHkUb+QU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u7fsbfndWpyoKR9OkI6NgmR2XKMnSo/666JzVywvK219k0a3AlXLj+bolpD2IlqHy
	 A5JQssGlraLozEeOojy/AdG3g6MQwITOePFwOuIx3318TwNGyp6mQ/EJaYVs8ueLao
	 mxgL6dSmpV9kVgB6t2kSaKKiBb2PN9CZTXFBNmtU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4414F80107;
	Mon, 11 May 2020 08:16:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 168ACF8014C; Mon, 11 May 2020 08:15:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D3B9F800E3
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 08:15:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D3B9F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KTb3jHj7"
Received: from localhost (unknown [122.167.117.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7122B20708;
 Mon, 11 May 2020 06:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589177752;
 bh=YmpQqO+voOin9Eh8PZUZNka6aTn/VjZ8uHlXHkUb+QU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KTb3jHj7c+P9BCBcaBUICxIuo2mSN1YH2hwV2iRlIlo13WQbJ2Vhe0uLpiuVOQnpm
 mXAJvVrP6oBmeg4OcXEqo4N9/qECck8o+t+LDGAFZPwI8x0AxXQ2kcsQCn5sr+eqFs
 2nTKox51G6EWKiHRs33ENWPWggZ6pPLWfEAvK6+g=
Date: Mon, 11 May 2020 11:45:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Samuel Zou <zou_wei@huawei.com>
Subject: Re: [PATCH -next] soundwire: qcom: Use IRQF_ONESHOT
Message-ID: <20200511061546.GQ1375924@vkoul-mobl>
References: <1588735553-34219-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588735553-34219-1-git-send-email-zou_wei@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, bjorn.andersson@linaro.org,
 agross@kernel.org, sanyog.r.kale@intel.com, linux-kernel@vger.kernel.org
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

On 06-05-20, 11:25, Samuel Zou wrote:
> Fixes coccicheck error:
> 
> drivers/soundwire/qcom.c:815:7-32: ERROR: Threaded IRQ with
> no primary handler requested without IRQF_ONESHOT

Applied, thanks

-- 
~Vinod

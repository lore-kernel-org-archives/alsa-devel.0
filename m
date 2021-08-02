Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E7BC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 05:40:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBF761050
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 05:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EBF761050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFD9117AF;
	Mon,  2 Aug 2021 07:39:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFD9117AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627882841;
	bh=PUPqiGY1Lqs3wceq2cbTWPaFQYK7+AacH8oW093jjTc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ispiOs97AkXTe1pBjJrZ+jE8wphWpMx1YuGiPfyP/FbySv+h5uBg/OaMcl0gAfJv4
	 /Sq5o4MA4pZU2pw663RuTkOSy22D9hIxWXl3WzQKuB7dIFPotsNMPq4fbfuyBvOrbw
	 LFZj8RTicBp1IUTA0T66tCcuCCdIp63Lo3Jw+cOU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90D0BF8026A;
	Mon,  2 Aug 2021 07:39:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EC6BF80271; Mon,  2 Aug 2021 07:39:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2D6BF800BF
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 07:39:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2D6BF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HokkQCmn"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D61561029;
 Mon,  2 Aug 2021 05:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627882760;
 bh=PUPqiGY1Lqs3wceq2cbTWPaFQYK7+AacH8oW093jjTc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HokkQCmnsDlrMTzwbz9oR8wymqUwjm8+08bU9fyRSBmadtgrKc4fBMe+jKa4FFmG7
 wJPTl6m5lIJc7CBy1YyvdSd0VjnWCvIIPy42ax44SXGg3qzUOoa0xJPoLsa5wlDYCL
 WeXbqXDRVzpAaTfO0wiSKxA/45hfOsShy/qzC/C/yNqfl2JulQpsfJYrz9/zZZhyJv
 La1UL4girGVTgq/vuD5jXW2d5ivid4mC/ledo1U7IbWsmc8/47zcfF0PaLD/Czelco
 izc6tAn8P07YPn4ILECDxK5GtFXtdblXlGpvSYE5crTdRGSOxCLEJ31duhLV8oWrhi
 iZHumL7DOaC2w==
Date: Mon, 2 Aug 2021 11:09:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 00/10] soundwire/ASoC: add mockup codec support
Message-ID: <YQeFA9/+OfLEftB2@matsya>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

On 14-07-21, 11:21, Bard Liao wrote:
> Adding mockup SoundWire codec is useful to debug driver/topology changes
> without having any actual device connected.

Applied sdw patches to sdw-next, thanks

-- 
~Vinod

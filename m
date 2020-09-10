Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA4BC433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:52:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9B120829
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ELvekFzC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6aZqukn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9B120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED13D1658;
	Thu, 10 Sep 2020 07:51:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED13D1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599717157;
	bh=JtaFlJSviOb7OWFjFxocygPpOA+gRQz5TGSHiD2R484=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ELvekFzC29SVLwL0GaEYO6V/wY3vfcsbDEGBhnhISuMeC8hQQaSm+KRauPC/I5Scc
	 MfAWmEh75eZd0p8QkueLC/Z8NvteGMGcW8ecSa4QiQIG6wumR4/6Qje6Z1N+scwmDo
	 Yn9/qvG75b9r1N3Ag0KSclwn3S8HXw22DAbQVlSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72DCCF801F2;
	Thu, 10 Sep 2020 07:51:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4D8EF80264; Thu, 10 Sep 2020 07:51:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80324F800D0
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 07:51:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80324F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="n6aZqukn"
Received: from localhost (unknown [122.179.50.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBA6A2075B;
 Thu, 10 Sep 2020 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599717090;
 bh=JtaFlJSviOb7OWFjFxocygPpOA+gRQz5TGSHiD2R484=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n6aZquknwoSsKlYrQLwioTINY6mxQoOZBhPmB/Ip3oYRy3o2QmaBXjnHnYBK+mvIw
 LvsrH2yk5CYPZiUu7h/XLMnFvIbDGBXzfniKoqKj8xSkrxSIl0ZVXpHwvr1EOK7Quz
 gqL+31FTXo4flsvjyNOb+kuhptRsddNJRSn+UrJ4=
Date: Thu, 10 Sep 2020 11:21:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 0/7] ASoC/soundwire: filter out invalid PARITY errors
Message-ID: <20200910055122.GO77521@vkoul-mobl>
References: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
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

On 08-09-20, 21:45, Bard Liao wrote:
> Some codecs may report fake PARITY errors in the initial state. This
> series will filter them out.

Applied, thanks

-- 
~Vinod

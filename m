Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216E7C43465
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:01:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A67C2311A
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eM1g2Nml";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxaUP3bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A67C2311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C985815E5;
	Fri, 18 Sep 2020 14:00:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C985815E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600430499;
	bh=EWVOPeAE3w06YdnOUsiNsI6p2M/jMN2L8S5LmGhKJ1Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eM1g2Nml1uF0KlDcAi64Zbgt+8T5/NtZYobTWHrnrLynEhjVeRpFh0Avs09Ymm0i4
	 7O+2BokQWAq9KXlqPywk9G/uewi1PP227rsstRWTjFnioWKfFV7qTEC9HzC+Bm/UcS
	 /FnQrblk8sdLB2QzXREveyqMIkB3rq5mL5121Ddw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52E3AF8013A;
	Fri, 18 Sep 2020 14:00:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67E3CF8015A; Fri, 18 Sep 2020 14:00:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FE5CF8013A
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 14:00:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FE5CF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rxaUP3bx"
Received: from localhost (unknown [136.185.124.244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E0D32100A;
 Fri, 18 Sep 2020 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600430437;
 bh=EWVOPeAE3w06YdnOUsiNsI6p2M/jMN2L8S5LmGhKJ1Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rxaUP3bxi6YazO+nKhUVEDqcmNGmSMmf0FYq8u6M2kOgMBfKNlY20s3BivxBXagk1
 7kv3wMTIy/xsKf8AI1YR/yuja9tzR0KllrUsTOYSgPIuRS1LeB7PrxeUrKKsabflUF
 qKPfTfImwsxCh7ECh7p5ddnN/qvzKUhOZOWVHO70=
Date: Fri, 18 Sep 2020 17:30:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: Add generic bandwidth allocation algorithm
Message-ID: <20200918120034.GP2968@vkoul-mobl>
References: <20200908131520.5712-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908131520.5712-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
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

On 08-09-20, 21:15, Bard Liao wrote:
> This algorithm computes bus parameters like clock frequency, frame
> shape and port transport parameters based on active stream(s) running
> on the bus.
> 
> Developers can also implement their own .compute_params() callback for
> specific resource management algorithm, and set if before calling
> sdw_add_bus_master()
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. All hard-coded
> values were removed from the initial contribution to use BIOS
> information instead.

Applied, thanks

-- 
~Vinod

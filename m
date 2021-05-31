Return-Path: <SRS0=0Rat=K2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C4C47080
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 10:05:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59E66124B
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 10:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59E66124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C49E1846;
	Mon, 31 May 2021 12:04:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C49E1846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622455523;
	bh=ZCo+s3aTIIc6/cUBCjW0Tqs592gHMaAwNUZ3OdQwAiA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwfva0g5ZwH+qIOny9Q+fqvqZnIJe+06Uyqsjaf/gLLLBRRKxSmaw1ug2zi5Op+MC
	 KNEQo8fYLKvLFw2XUYwcFPl4B4sXvT5VoLaXUpL31QjllJCcWeUvUUwvN3lyBx0ZgT
	 W7aBzVlu0k7wamoFd1IOB32sqztpgHqRfAxXvziQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47D21F80161;
	Mon, 31 May 2021 12:04:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D204F802E2; Mon, 31 May 2021 12:04:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F389F80253
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 12:04:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F389F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XoiS6AKi"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E43EE610E7;
 Mon, 31 May 2021 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622455461;
 bh=ZCo+s3aTIIc6/cUBCjW0Tqs592gHMaAwNUZ3OdQwAiA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XoiS6AKit4yIGzet+D90TgYZs8av1Ou53vwSbj+PZCf8NxFdn6G1c1MmbZxyLzem9
 6iDJmUVYADpSlZF6uGIFjX/WcQR2iphO7WTxSY+7Tty/XlLGYXS7+7rz5SlBPoV1Z/
 aUvBkQKVeI08G7k/XtRlaOyP5WtwNc+RVZLvkJrru6FI+4kGfWMtU1pqgMqUQMRmTB
 OoZda0CAbVDL2yYOqeuXSG0evP4FbT+vnTqZNx3OtoqPGcFd1jOMW0pNWKfL1bPr3x
 a3GlLS4iV1fkHJlyQZFu+RXOXheVx3KEv8VZj2El7gP6l6OU3451fBNNm+cNGA4+G/
 +tD17caWLclpA==
Date: Mon, 31 May 2021 15:34:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH] soundwire: cadence: remove the repeated declaration
Message-ID: <YLS0oUdnjI8sYm6o@vkoul-mobl.Dlink>
References: <1622114698-7943-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622114698-7943-1-git-send-email-zhangshaokun@hisilicon.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On 27-05-21, 19:24, Shaokun Zhang wrote:
> Function 'cdns_reset_page_addr' is declared twice, so remove the
> repeated declaration.

Applied, thanks

-- 
~Vinod

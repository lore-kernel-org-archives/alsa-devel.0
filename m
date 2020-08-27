Return-Path: <SRS0=PqWm=CF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05971C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:19:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6763722B47
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Av5QIrxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6763722B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF9D017B0;
	Thu, 27 Aug 2020 11:18:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF9D017B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598519944;
	bh=5CSOYiTDnWhgk6b8udFSA9YQh3AgxjyxOtINZ6oasks=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Av5QIrxYif40Me1oNl0/8a24iEgVZupMPrj9AoX3Umy248voy1ELhOdJWbo+p9miL
	 jaF6O1AxXI9nz/NUW7TLDxhhDbxq6jInWztGavK2bgPi23Rn1Bz5wOpjCDmyL87DPU
	 jLkCpGDkVdPVNTOO2n8aoNlsclbdKJZV2XZsu+24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3839AF80143;
	Thu, 27 Aug 2020 11:18:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 158CDF8016F; Thu, 27 Aug 2020 11:18:13 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8C67F80085
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2020 11:18:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8C67F80085
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mfe@pengutronix.de>)
 id 1kBE2Y-0004qN-Hf; Thu, 27 Aug 2020 11:17:50 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1kBE2U-0007L7-JH; Thu, 27 Aug 2020 11:17:46 +0200
Date: Thu, 27 Aug 2020 11:17:46 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: imx-es8328: add missing put_device() call
 in imx_es8328_probe()
Message-ID: <20200827091746.xcbggzqqufndyuk7@pengutronix.de>
References: <20200825120531.1479304-1-yukuai3@huawei.com>
 <20200825120531.1479304-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825120531.1479304-3-yukuai3@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:08:08 up 286 days, 26 min, 272 users, load average: 0.04, 0.12, 
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 yi.zhang@huawei.com, festevam@gmail.com, s.hauer@pengutronix.de,
 tiwai@suse.com, lgirdwood@gmail.com, nicoleotsuka@gmail.com,
 broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 yukuai@huawei.com, shawnguo@kernel.org, xobs@kosagi.com,
 shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org
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

On 20-08-25 20:05, Yu Kuai wrote:
> if of_find_device_by_node() succeed, imx_es8328_probe() doesn't have
> a corresponding put_device().

Why do we need the ssi_pdev reference here at all?

Regards,
  Marco

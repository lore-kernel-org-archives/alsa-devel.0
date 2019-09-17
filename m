Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A5C4CEC9
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 07:42:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C7020678
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 07:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BghmLCD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C7020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thundersoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3D3D1669;
	Tue, 17 Sep 2019 09:41:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3D3D1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568706122;
	bh=Y/ezt66/pnurMGeFbA6mw++hZCKX+8fy6BywZ+MHv+E=;
	h=Date:From:To:References:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=BghmLCD/VqYu829/XXunlmTV14UV2ba4yStloCtUzSCzrBrThvPwY/kd0Nc1lcasZ
	 CqRgJdLLeiamdCSobWcb7XhmZpRLh/rgtBcrzyb7tAEoVuauAmg7P9g5EC07L/Pr4h
	 j9feazPzBGkvSbcBZbKZ/HNvf5QXtMsiD6tPH4G8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 474BCF80307;
	Tue, 17 Sep 2019 09:41:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C50D7F80361; Tue, 17 Sep 2019 09:41:10 +0200 (CEST)
Received: from mail2.thundersoft.com (unknown [114.242.213.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEA1DF802BD
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 09:41:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEA1DF802BD
Received: from shifu (unknown [124.89.2.42])
 by mail2.thundersoft.com (Postfix) with ESMTPSA id 0D0A7152074F;
 Tue, 17 Sep 2019 15:41:00 +0800 (CST)
Date: Tue, 17 Sep 2019 15:40:59 +0800
From: "shifu0704@thundersoft.com" <shifu0704@thundersoft.com>
To: shifu <shifu0704@thundersoft.com>, lgirdwood <lgirdwood@gmail.com>, 
 broonie <broonie@kernel.org>, perex <perex@perex.cz>, 
 tiwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
 alsa-devel <alsa-devel@alsa-project.org>, robh+dt <robh+dt@kernel.org>
References: <1568705889-6224-1-git-send-email-shifu0704@thundersoft.com>, 
 <1568705889-6224-2-git-send-email-shifu0704@thundersoft.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.9.116[cn]
Mime-Version: 1.0
Message-ID: <201909171540576235182@thundersoft.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: =?us-ascii?B?RGFuP011cnBoeQ==?= <dmurphy@ti.com>,
 =?us-ascii?B?TmF2YWRhIEthbnlhbmEsIE11a3VuZA==?= <navada@ti.com>
Subject: Re: [alsa-devel] [PATCH v5] tas2770: add tas2770 smart PA kernel
	driver
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



> +reload:
> + /* hardware reset and reload */
> + tas2770_load_config(tas2770);

Sometimes devices need to be reset to return to normal, and this setting is necessary.

> +end:
> + return IRQ_HANDLED;
> +}

I see that the other drivers, the return values in irq_handler are IRQ_HANDLED.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

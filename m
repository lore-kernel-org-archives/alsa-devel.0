Return-Path: <SRS0=JMHt=2M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D4CC2D0C8
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Dec 2019 23:22:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E991E20684
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Dec 2019 23:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mlZyWkZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E991E20684
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA50E166B;
	Mon, 23 Dec 2019 00:21:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA50E166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577056951;
	bh=3QX+/p9kbjh3Mj+lgdmyVHu92RGxuA7BG4ixcZvxogk=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mlZyWkZwWzJ/mgR0S1cMXWURAvO5wSm4/0r79+WhoeXeL08RTd5sSaz4kTInYy7I8
	 UBL6gJbz/yCeOmSfsyEppTQwtEuUU0e47Se9mexebLwt65B6U+7unYLVtfxeegrG/Y
	 OG6YA4Lp/9ysoMS4bkggfo0lk1TSrP/8R2mmGDzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7065BF8011C;
	Mon, 23 Dec 2019 00:21:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2286F80136; Mon, 23 Dec 2019 00:21:38 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BD632F800AD
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2019 00:21:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD632F800AD
MIME-Version: 1.0
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1577056894736834049-webhooks-bot@alsa-project.org>
References: <1577056894736834049-webhooks-bot@alsa-project.org>
Message-Id: <20191222232138.A2286F80136@alsa1.perex.cz>
Date: Mon, 23 Dec 2019 00:21:38 +0100 (CET)
Subject: [alsa-devel] How to install on debian buster?
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

alsa-project/alsa-ucm-conf issue #8 was opened from kopax:

I use kernel 5.3 on debian buster and I am following thos offical Lenovo tutorial to install the microphone on my x1c7:

https://forums.lenovo.com/lnv/attachments/lnv/lx02_en/3199/1/Enabling%20audio%20on%20the%20X1C7.pdf

It says:

![image](https://user-images.githubusercontent.com/1866564/71328607-1a5e8180-251a-11ea-8621-1655d7746c60.png)

Now the [link](https://github.com/alsa-project/alsa-ucm-conf/tree/master/ucm/sof-skl_hda_card) is 404, what do I need to get now ?

Thanks in advance and merry xmas!

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/8
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

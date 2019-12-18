Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA39C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:10:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CB224650
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AE27Jt0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CB224650
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F279985D;
	Wed, 18 Dec 2019 11:09:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F279985D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576663801;
	bh=mDlXZcfoGJNaNIGgBZ+9X3YtcPtKir8AZPVAwtbX1bc=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AE27Jt0VtHIM2NVJleU2AursYBnEHtN1yrvk5WLk5Wq1/zhx4d95z/xT4N7mx5It7
	 BekO6J6l3DaIUbMU0hZ0SFxnxw0lVBgIsvOhxVVGJ9b1sqXmrxn0Z2ybzY37u0y8xB
	 eP4AKEJPvFE68XNBYDh9n5ctT3YaOJRAUyn/0Tp8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36371F80059;
	Wed, 18 Dec 2019 11:09:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CBC5F8022C; Wed, 18 Dec 2019 11:09:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D845BF80059
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 11:09:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D845BF80059
MIME-Version: 1.0
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1576663745816961050-webhooks-bot@alsa-project.org>
References: <1576663745816961050-webhooks-bot@alsa-project.org>
Message-Id: <20191218100909.6CBC5F8022C@alsa1.perex.cz>
Date: Wed, 18 Dec 2019 11:09:09 +0100 (CET)
Subject: [alsa-devel] Undecalared Variable "p" when compile alsa-lib with
	TPLG_DEBUG defined
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

alsa-project/alsa-lib issue #18 was opened from aiChaoSONG:

Undecalared Variable "p" when compile alsa-lib with TPLG_DEBUG defined, the pointer 'p'  in line 152 of src/topology/data.c seem not declared. see code below.
```
static void dump_priv_data(struct tplg_elem *elem)
{
	struct snd_soc_tplg_private *priv = elem->data;
	unsigned int i, j = 0;

	tplg_dbg(" elem size = %d, priv data size = %d\n",
		elem->size, priv->size);

	for (i = 0; i < priv->size; i++) {
		if (j++ % 8 == 0)
			tplg_dbg("\n");

		*******tplg_dbg(" 0x%x", *p++);*******
	}

	tplg_dbg("\n\n");
}
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/18
Repository URL: https://github.com/alsa-project/alsa-lib
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

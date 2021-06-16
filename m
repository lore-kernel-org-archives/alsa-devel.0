Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540F2C48BE6
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 13:34:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A803F6128B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 13:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A803F6128B
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36965166B;
	Wed, 16 Jun 2021 15:33:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36965166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623850441;
	bh=Dl295asvhE29R+ANz7+7hb1hqZXQRHdApJ8zs8A7dqE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dwp9z2uKS7rva1lc50fODuNJXK8nDsGMTfqKB1h/kpfFghs4zfOBXqG9lBHVyPffz
	 wMo/ZVesgzKbMBHPNyXVwuGvp3fP3uoyR7i0DMaABLLtL1kfIwxge4OQPLDYMQRa5Y
	 ZbWJYgSkY2QVLqvn4WDWaSabI23CLpgdZamMnflw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BEFCDF802E8;
	Wed, 16 Jun 2021 15:33:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9D98F80423; Wed, 16 Jun 2021 15:33:09 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 066EEF80165
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 15:33:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 066EEF80165
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623850382824232101-webhooks-bot@alsa-project.org>
References: <1623850382824232101-webhooks-bot@alsa-project.org>
Subject: alsa-lib errors on boot
Message-Id: <20210616133309.A9D98F80423@alsa1.perex.cz>
Date: Wed, 16 Jun 2021 15:33:09 +0200 (CEST)
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

alsa-project/alsa-lib issue #159 was opened from miquecg:

```
alsactl[769]: alsa-lib parser.c:242:(error_node) UCM is not supported for this HDA model (HD-Audio Generic at 0xfd3c8000 irq 108)
alsactl[769]: alsa-lib main.c:1405:(snd_use_case_mgr_open) error: failed to import hw:0 use case configuration -6
alsactl[769]: alsa-lib parser.c:242:(error_node) UCM is not supported for this HDA model (HD-Audio Generic at 0xfd3c0000 irq 109)
alsactl[769]: alsa-lib main.c:1405:(snd_use_case_mgr_open) error: failed to import hw:1 use case configuration -6
```

This is happening on a ThinkPad T14 AMD running Arch Linux and `alsa-lib` 1.2.5.1. Previous version also had this issue.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/159
Repository URL: https://github.com/alsa-project/alsa-lib

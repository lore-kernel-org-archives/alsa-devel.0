Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680BAC48BE5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 14:20:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB6A6115A
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 14:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB6A6115A
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6F54847;
	Mon, 21 Jun 2021 16:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6F54847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624285242;
	bh=MGik1kdn89njY4hoyQQBQ1V7Dlu9mX52fHJ40QwM/oU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RR/rItMpbdap8nmQhhSbExoBzaALEQQ6dznjjf8PAN+eJvkuHoft3PtHMykwqB8cb
	 TmNx1K3jGeBkGBpgIOXnzPTr3aGUy7Rq8xFm3nIKtgBVXxZHOseXtFKCUwPBJDN3Ko
	 0aLapD4EH69QCx5m2jjvAeu8MqXuj2L/ohHuJ4ao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44656F8016A;
	Mon, 21 Jun 2021 16:19:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81400F8016B; Mon, 21 Jun 2021 16:19:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CF189F80163
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 16:19:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF189F80163
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1624285185330276012-webhooks-bot@alsa-project.org>
References: <1624285185330276012-webhooks-bot@alsa-project.org>
Subject: A52 documentation in need of updates.
Message-Id: <20210621141950.81400F8016B@alsa1.perex.cz>
Date: Mon, 21 Jun 2021 16:19:50 +0200 (CEST)
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

alsa-project/alsa-plugins issue #29 was opened from quequotion:

[a52.txt](https://github.com/alsa-project/alsa-plugins/blob/4219f4b3fded74d7b07a54c3ba8661d7a18c3b6c/doc/a52.txt) hasn't been changed in fifteen years.

In that time, [a preconfiguration has been supplied that ends up getting merged into a dysfunctional mess if users add a manual configuration to their asound.conf without prepending an exclamation point to override it](https://github.com/alsa-project/alsa-lib/issues/154#issuecomment-859799234), and more recently [more sample formats have been added](https://github.com/alsa-project/alsa-plugins/commit/f11e7a8994111f971bc881d4069f768472452f4f).

This file needs some attention.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/29
Repository URL: https://github.com/alsa-project/alsa-plugins

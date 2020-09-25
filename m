Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24289C4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A3B21D7A
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HN8XfNzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A3B21D7A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A49B18A1;
	Fri, 25 Sep 2020 14:32:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A49B18A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601037201;
	bh=uebeObe2qR/7xevZSGXo9bBmc4DeZpDG/k5zj7k1RKE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HN8XfNzC82/mgT7CayfpqhzjBRwx8trjz7i7xSz7207YcoRqpHvPHXtmFYgY+7oxc
	 pk9vF22LZY+ZMoi3FC8X/fJPRG/8S0SQGC7ZAhPy3FbcPOQ4f34VJxNjopWi9WVn9n
	 mMA1vKun0Ojg5HixRXrHPgJwJ3yTFL2/0eB3Id+M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A976AF80171;
	Fri, 25 Sep 2020 14:32:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE02CF801EB; Fri, 25 Sep 2020 14:32:28 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 53900F800F6
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 14:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53900F800F6
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1601037137265247107-webhooks-bot@alsa-project.org>
References: <1601037137265247107-webhooks-bot@alsa-project.org>
Subject: alsaloop: Fix the silence generation in xrun_sync
Message-Id: <20200925123228.BE02CF801EB@alsa1.perex.cz>
Date: Fri, 25 Sep 2020 14:32:28 +0200 (CEST)
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

alsa-project/alsa-utils pull request #58 was opened from dragosht:

The silence frames generation in xrun_sync() seems to be currently
a bit off as snd_pcm_format_set_silence() uses a wrong buffer address
and size for zero-ing out the data. Consequently instead of clearing
out the last frame(s), snd_pcm_format_set_silence() ends up silencing
samples somewhere else in the buffer. This is partilarly more obvious
for higher frame size (e.g. when using more than 2 channels).

This patch fixes this issue by correcting the parameters passed to
snd_pcm_format_set_silence().

Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/58
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/58.patch
Repository URL: https://github.com/alsa-project/alsa-utils

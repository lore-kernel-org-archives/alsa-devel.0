Return-Path: <SRS0=oKMh=DZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D597C433E7
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 11:06:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA5B20897
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 11:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aLhuR7FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA5B20897
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18ED817BA;
	Sun, 18 Oct 2020 13:05:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18ED817BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603019156;
	bh=/j8ue4PSpD55y1evuWVvvv0xTmWLdUMy1GR1UDZWpe4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aLhuR7FRbNCHcjj7/i2A0tlwjeLI+nC3X4F3WErMZcqzOYeeE+Lpg51mfOIcP2dpx
	 nw0yA/stzkZm8vHrov3hw3AuG3G5Bqu5V/3PbtTfB9ffie70eRipKf60s+CpQVgb1+
	 LlHHgdgN1i3bTjrlI+Ow4Vb4P9pAxZxn946AsEFg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1034F8014D;
	Sun, 18 Oct 2020 13:05:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F4B5F801F2; Sun, 18 Oct 2020 13:05:04 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 27A50F80111
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2020 13:05:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27A50F80111
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603019100244839907-webhooks-bot@alsa-project.org>
References: <1603019100244839907-webhooks-bot@alsa-project.org>
Subject: Add amixer --view, to filter playback, capture or all
Message-Id: <20201018110504.6F4B5F801F2@alsa1.perex.cz>
Date: Sun, 18 Oct 2020 13:05:04 +0200 (CEST)
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

alsa-project/alsa-utils issue #67 was opened from jidanni:

alsamixer has
```
       -V, --view <mode>
              Select the starting view mode, either playback, capture or all.
```

Perhaps amixer could also have something similar,'
e.g., so that
```
$ amixer --view capture
```
would only dump the capture related settings.
Currently one could say that
```
$ amixer --view all
```
is the default.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/67
Repository URL: https://github.com/alsa-project/alsa-utils

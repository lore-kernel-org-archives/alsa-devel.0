Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE63C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:32:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160B520936
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OwWWF75m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160B520936
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8BD515F9;
	Thu, 17 Sep 2020 05:31:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8BD515F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600313540;
	bh=SnzmcvK2XGiaPPfM4fft1MPoub3yoSDTjRUgu2honAc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OwWWF75m1oA5cM74pKADTTLRgYq/kGwJVIloLrsGenMA4gBQ9YQlxMlu9ol94juvg
	 1D7z5f88DAO6z0WIHuwETzZSU1ms9Eccqj5i8yVt7ORjGt+EGVJ+5aFl5P3TkA3TAa
	 +InKtxBXpS5dqy7XSnNi4SzKlQsQkp5f9yXIvHEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51E07F801EC;
	Thu, 17 Sep 2020 05:31:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C864AF80212; Thu, 17 Sep 2020 05:31:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BDE70F800E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 05:31:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDE70F800E8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1600313482498797894-webhooks-bot@alsa-project.org>
References: <1600313482498797894-webhooks-bot@alsa-project.org>
Subject: "aplay -D oss -l" still reads sound cards through ALSA, not OSS
Message-Id: <20200917033127.C864AF80212@alsa1.perex.cz>
Date: Thu, 17 Sep 2020 05:31:27 +0200 (CEST)
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

alsa-project/alsa-utils issue #56 was opened from yurivict:

I don't have any ALSA devices, only OSS devices.

When the OSS PCM is selected ```aplay``` still tries to read ALSA devices:
```
$ /usr/bin/aplay -D oss -l
aplay: device_list:272: no soundcards found...
```

```
$ /usr/bin/aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
oss
    Open Sound System
```

alsa-lib-1.1.8
alsa-plugins-oss-1.1.6
alsa-utils-1.1.8

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/56
Repository URL: https://github.com/alsa-project/alsa-utils

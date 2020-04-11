Return-Path: <SRS0=q721=53=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871E0C2BA19
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2020 23:55:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CC620787
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2020 23:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tHeNzU90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CC620787
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B92416AF;
	Sun, 12 Apr 2020 01:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B92416AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586649356;
	bh=1n+ItEYqtgO06mlhNpUSk/fglDuXpggIxONUDzNsigc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tHeNzU90kY2gN6a+jQVuenslClZNY2sGtmxxJdVhJARN5Mduy82LMJxpGOklEIbtK
	 tfd9Vcl0IGMiqBb5fqn7lkVZJoPOSkfilULojP7o6ruZiE9AnbkjtdXlGiDYgHbE4E
	 +1rvt+ZFhfiW9KqxLufO9j74fqiJPg88mQWQr33o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D923DF801D8;
	Sun, 12 Apr 2020 01:55:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCB28F801DA; Sun, 12 Apr 2020 01:55:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BBE84F8007E
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2020 01:55:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBE84F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1586649300028500080-webhooks-bot@alsa-project.org>
References: <1586649300028500080-webhooks-bot@alsa-project.org>
Subject: snd_pcm_drain() infinite loop
Message-Id: <20200411235503.CCB28F801DA@alsa1.perex.cz>
Date: Sun, 12 Apr 2020 01:55:03 +0200 (CEST)
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

alsa-project/alsa-lib issue #41 was edited from sylware:

In a non-blocking dmix-ed plugin pipeline (see below), playing audio from a 44100Hz source to a running 48000Hz hardware pcm, will go into an -EAGAIN infinite loop in snd_pcm_drain().
I did a bit of tracing and it seems snd_pcm_drain() will always return -EAGAIN because in pcm_dmix.c:snd_pcm_dmix_sync_ptr0, avail  is never >= pcm->stop_threshold

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/41
Repository URL: https://github.com/alsa-project/alsa-lib

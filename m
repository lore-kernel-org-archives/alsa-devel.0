Return-Path: <SRS0=nf9P=NT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA79C432BE
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Aug 2021 12:05:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFF160EDF
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Aug 2021 12:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAFF160EDF
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFE891705;
	Sat, 28 Aug 2021 14:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFE891705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630152347;
	bh=lFpKWj3IGF9HnjlmTQo5cDTQYHmHFRzGT3TXK7ZzJqw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B9Jg1CR5mhPnrLnmErFYsoGLH9wM960j5LoYGcWhXT8cXFtKI51xKzJNoh5q7D+2S
	 6bRtM8pUbuoBW4VRirRP7GmCpnZ+p3uZbzFl2NLtI55rMkiP4/+Ko1hj3bA9bQF3QO
	 biTDpxNvEZ+naDqgpf+HslB5qYdJhRZby/7Z0nms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 520C1F80169;
	Sat, 28 Aug 2021 14:04:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FE1AF80240; Sat, 28 Aug 2021 14:04:55 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1FE6CF80169
 for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2021 14:04:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FE6CF80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1630152286395862103-webhooks-bot@alsa-project.org>
References: <1630152286395862103-webhooks-bot@alsa-project.org>
Subject: Static build generates broken symlinks
Message-Id: <20210828120455.5FE1AF80240@alsa1.perex.cz>
Date: Sat, 28 Aug 2021 14:04:55 +0200 (CEST)
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

alsa-project/alsa-plugins issue #34 was opened from daravi:

Hello,

This snippet seems to generate some symlinks:
```
install-exec-hook:
	rm -f $(DESTDIR)@ALSA_PLUGIN_DIR@/libasound_module_rate_speexrate_*.so
	$(LN_S) libasound_module_rate_speexrate.so $(DESTDIR)@ALSA_PLUGIN_DIR@/libasound_module_rate_speexrate_best.so
	$(LN_S) libasound_module_rate_speexrate.so $(DESTDIR)@ALSA_PLUGIN_DIR@/libasound_module_rate_speexrate_medium.so
```

But it assumes we are doing a shared build. Which results in broken symlinks in a static build.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/34
Repository URL: https://github.com/alsa-project/alsa-plugins

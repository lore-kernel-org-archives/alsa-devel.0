Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E6CCA9EB9
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 04:14:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23C921835
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 04:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zl85Xwmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23C921835
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D899219E;
	Tue, 29 Oct 2019 05:13:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D899219E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572322471;
	bh=0Ynam4wvpEMqHCpTGvmjkRVMGZt3s9pxUhJn2YnPryo=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zl85Xwmj92hpTHcIQMgEIgl2tngqIK7bY+UeMi9mEJ6uddBvP/zhqBotQBxeiIJ1E
	 Qi7DkoEg1Dv34CQ1Npt/OwjUPg8S46Z1oCyoscvEo6UuqSUgIDwj4Gfa375ApDr/Ep
	 qhryjSN4RQg6Ddm0h2XiBIo897n7i2VQsDau9qzU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13AFEF8036C;
	Tue, 29 Oct 2019 05:13:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A364DF80392; Tue, 29 Oct 2019 05:13:38 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2DA7BF80269
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 05:13:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DA7BF80269
MIME-Version: 1.0
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1572322414179287910-webhooks-bot@alsa-project.org>
References: <1572322414179287910-webhooks-bot@alsa-project.org>
Message-Id: <20191029041338.A364DF80392@alsa1.perex.cz>
Date: Tue, 29 Oct 2019 05:13:38 +0100 (CET)
Subject: [alsa-devel] axfer: call of polling system call never return when
 driver fails to queue any events due to the lack of hw IRQ context
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

alsa-project/alsa-utils issue #30 was opened from takaswie:

Axfer calls polling system call(i.e. poll(2), epoll(7), select(7)) without explicit timeout when running for IRQ-based scheduling model. In a case that driver achieves to control sound hardware for periodical hardware IRQ, the call can return due to any event queued by the driver in hardware IRQ context. However, in a case that driver fails to control it, the call cannot return.

Especially, this situation easily occurs when developers work to support hardware newly. It's better to care for the situation.

How to reproduce:
1. prepare sound hardware which driver fail to control for periodical hardware IRQ.
2. execute axfer for the driver/hardware with options to:
  * use IRQ-based scheduling model: `--sched-model=irq`
  * use polling system call: without `--test-nowait`
3. the running process blocks as a call of polling system call (defaultly poll(2) by snd_pcm_wait())

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/30
Repository URL: https://github.com/alsa-project/alsa-utils
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

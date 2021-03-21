Return-Path: <SRS0=B97g=IT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3DC433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Mar 2021 11:05:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985546193A
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Mar 2021 11:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985546193A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4996774C;
	Sun, 21 Mar 2021 12:04:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4996774C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616324731;
	bh=JYpXzfRFFOSFjoswLYgBRvb0pyMJEzD6JgXJnIgc/gY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RZBlCr/s1sAi+f+03fq4UFt+7RxCdR/Xhu6qytEgOLyvvJAXAi8p5i9oHmvVR2nyH
	 WY/ycvTStE+NsrgPNT37maRm7pm/POQcZyT4LkYq1tNAhyzD/DHznu3IsiAUwW9u1R
	 1khWISneuiQ9PeWcwR02vfia1RzUb6kSKxssdiB4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2A91F80118;
	Sun, 21 Mar 2021 12:04:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE9BBF80254; Sun, 21 Mar 2021 12:04:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9A053F80118
 for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2021 12:04:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A053F80118
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1616324672609323978-webhooks-bot@alsa-project.org>
References: <1616324672609323978-webhooks-bot@alsa-project.org>
Subject: pcm: dshare - fix shared memory pointer check
Message-Id: <20210321110439.EE9BBF80254@alsa1.perex.cz>
Date: Sun, 21 Mar 2021 12:04:39 +0100 (CET)
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

alsa-project/alsa-lib pull request #128 was opened from VanithaChannaiah:

Currently shared memory pointer is initialized to 0 and set to -1
in some, but not in all error paths.
In cleanup path of open the shm pointer is only compared to be non-NULL
before dereferencing it which leads to SEGFAULT in case it was set to -1.

This patch initializes pointer to -1 to have a unique identification
for invalid pointer and also checks for pointer being not -1 on
access in cleanup path.

Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/128
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/128.patch
Repository URL: https://github.com/alsa-project/alsa-lib

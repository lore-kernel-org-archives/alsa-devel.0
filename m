Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA8C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 15:59:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B8120715
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ct9QGxUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B8120715
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E171C1695;
	Tue, 24 Nov 2020 16:58:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E171C1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606233587;
	bh=dbeQNlFU+Xp7K4xbK/8dFJNDmhF0UIMHHUBlALXXThI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ct9QGxUDr9Xy7BfNKj+AuhuOPjybTWHCRSTw8yWBB0Y+ZyDuYYzz5Zdx1Ep9OKYOK
	 G3ux+K1s0/B3H6us5s05jnF8GD1g7jvQh9BAeOLYg4YHduhG9xsj42c/nbcyHvu68N
	 ooVPgvIw5zI5xdupN2Uc3VjhG0wYTuzPR9t/9ZGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 608A5F80161;
	Tue, 24 Nov 2020 16:58:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2230F80165; Tue, 24 Nov 2020 16:58:55 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B2F27F800C1
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 16:58:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2F27F800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1606233518106209040-webhooks-bot@alsa-project.org>
References: <1606233518106209040-webhooks-bot@alsa-project.org>
Subject: jack: add option to allow non-jack-aligned period size
Message-Id: <20201124155855.D2230F80165@alsa1.perex.cz>
Date: Tue, 24 Nov 2020 16:58:55 +0100 (CET)
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

alsa-project/alsa-plugins pull request #14 was opened from aditpape:

Commit 72337f1dcb2df6a2b7fdae93e88d7dd3a7e97ab4 forces ALSA period size
to be exact multiple of the JACK daemon period size.
There are good reasons to align the period size, but completely disallowing non aligned periods is too restrictive.
This patch adds an option "align_psize" which allows to optionally revert to original behavior.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/14
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/14.patch
Repository URL: https://github.com/alsa-project/alsa-plugins

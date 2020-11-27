Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACFCC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 11:24:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F381821534
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 11:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kQuA0e74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F381821534
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 658C3183B;
	Fri, 27 Nov 2020 12:24:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 658C3183B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606476290;
	bh=WKFRcVd9QTRp/UhRJVJFQRMniBHxqZeBtIzbSwgDmhY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQuA0e74Ho+u3y0jtHKaOpu+YhCZ9G4cp5z4RhY93nd0wNAV9z1UGEL9v7N5vYzbM
	 jkDMI9NfF9KBXeV3LVjrdhbS8aJv20DsZke1PDzBuNKFqq8L3A6NxRPr1023kUrXcS
	 6V7hjWr0ffIToDdF4xhpzIn4pTAejgOgi/m05u6o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F17ABF800EA;
	Fri, 27 Nov 2020 12:23:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00F66F8019D; Fri, 27 Nov 2020 12:23:57 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 28127F800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 12:23:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28127F800EA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1606476231002583981-webhooks-bot@alsa-project.org>
References: <1606476231002583981-webhooks-bot@alsa-project.org>
Subject: pcm: ioplug: Limit transfer size to buffer boundary
Message-Id: <20201127112358.00F66F8019D@alsa1.perex.cz>
Date: Fri, 27 Nov 2020 12:23:57 +0100 (CET)
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

alsa-project/alsa-lib pull request #103 was opened from aditpape:

Commit 1714332719fc91507ca24dd3567e50d7094b3001 introduced 2nd transfer()
call to transfer all remaining available frames.
If the prior calculated avail value exceeds the buffer size a too large size value
is passed to the underlaying plugin and results in memory corruption if not blocked by plugin internally.
Avail values > buffer size can happen if e.g. xrun detection is disabled,
as avail is calculated by pure difference between hw and app position.
This patch limits 2nd transfer call to remaining rest of a buffer size.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/103
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/103.patch
Repository URL: https://github.com/alsa-project/alsa-lib

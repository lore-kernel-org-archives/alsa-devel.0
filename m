Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A7C388F9
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 00:01:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DBA2463F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 00:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zb6fgmtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DBA2463F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 253381766;
	Tue, 17 Nov 2020 01:00:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 253381766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605571260;
	bh=vE81QjdGFNwhJ46t/5pVqR9bVux2v4ygIt9GU5AicOI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zb6fgmtIpRbO3VmedtwSn3FWa1iVPvTVKuGuG0GyDVP/XoWM8YLLN2TX3ozD1cvFB
	 vwwwcyxj2Fk9nWQd7lONQfqWlpoAEdzsstg3rrXUL3DJ/7+QQJ7tnxUd62U7Nj2ZA4
	 Lk5gHZBLVDthl+Wwf4NkqePmJzT/TkxLZFXVPkRg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1052F80167;
	Tue, 17 Nov 2020 01:00:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E2ABF80168; Tue, 17 Nov 2020 01:00:07 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D0821F8010A
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 01:00:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0821F8010A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605571203191261053-webhooks-bot@alsa-project.org>
References: <1605571203191261053-webhooks-bot@alsa-project.org>
Subject: [PATCH] alsa-gobject: ctl: change prototype of function relevant to
 TLV
Message-Id: <20201117000007.8E2ABF80168@alsa1.perex.cz>
Date: Tue, 17 Nov 2020 01:00:07 +0100 (CET)
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

alsa-project/alsa-gobject pull request #55 was opened from takaswie:

In ALSA control interface, the data of TLV (Type-Length-Value) style is
defined as array with unsigned int type of element. However, current
implementation of ALSACtl.Card handles them as signed int type.

This commit fixes the bug. This loses backward compatibility to v0.1.0
in a point of type of function argument.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/55
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/55.patch
Repository URL: https://github.com/alsa-project/alsa-gobject

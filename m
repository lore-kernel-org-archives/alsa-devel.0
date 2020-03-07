Return-Path: <SRS0=bYd2=4Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAC6C10F00
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 14:47:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A8C20675
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 14:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rLuPu53E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A8C20675
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B2B99F6;
	Sat,  7 Mar 2020 15:46:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B2B99F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583592430;
	bh=+aqEg7Z9KKFSgLYfX7mh1hud/ihD+KrKbAi5E8b2Jjc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rLuPu53E5Km3jRFsDiR5lCZS1YYwuo7jghi2nmU1PaWmqaV6IrNkppF+3d7kHgsQs
	 igxTOsw4CPmpQSgbkORlI2ftvL+u9x2OsmIbYh4EAqopB3kHJ6NowOL53w0KHy+6pj
	 Q7fZROEDzvLVB4VtNh2MxplanuUxZBtS/ISxk9p0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0580EF80266;
	Sat,  7 Mar 2020 15:46:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0775F8026A; Sat,  7 Mar 2020 15:46:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0FC16F80130
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2020 15:46:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FC16F80130
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1583592375782937050-webhooks-bot@alsa-project.org>
References: <1583592375782937050-webhooks-bot@alsa-project.org>
Subject: How to make ALSA relocatable in the filesystem?
Message-Id: <20200307144618.E0775F8026A@alsa1.perex.cz>
Date: Sat,  7 Mar 2020 15:46:18 +0100 (CET)
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

alsa-project/alsa-lib issue #34 was edited from probonopd:

We want to bundle a private copy of ALSA with our application, so that the ALSA from the Linux distribution is not used at all. Yet it seems ALSA is relying on some absolute paths compiled in with no clear way to pass in a different location for ALSA at runtime. 

How to do this?

Use case:
As an application developer, I want to ship my application together with all dependencies. This bundle is using musl libc, ships its own musl libc and runtime, and it is intended to also run on glibc-based systems.

Reference:
https://github.com/mumble-voip/mumble/issues/3959#issuecomment-596095335

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/34
Repository URL: https://github.com/alsa-project/alsa-lib

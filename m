Return-Path: <SRS0=ak/3=73=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B46C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Jun 2020 12:59:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362D220714
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Jun 2020 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LJSNXBqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362D220714
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A947915E2;
	Sun, 14 Jun 2020 14:58:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A947915E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592139545;
	bh=tNkUgiKAxRZSrFaT8DmXefY0Lsk/A6YYdcV9SWM1+Z8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LJSNXBqB8lNUkvPQtOag9Rq4mBvhinsi364dPG4vMctnSvmeUyaGHW4YlbuhxR2Fv
	 jb98IZznXvSpfcoxAtoAmWh9c0OW0ZM0+y/djTtEmtc2r8foq3GRVGwZg26cs3w4j9
	 qPecaKfC4UfUlhZ06zQEPHp9NXZcivFFM7gIQyGw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34347F80217;
	Sun, 14 Jun 2020 14:58:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1853F8022B; Sun, 14 Jun 2020 14:58:13 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6F5BBF8011E
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2020 14:58:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F5BBF8011E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592139488676203012-webhooks-bot@alsa-project.org>
References: <1592139488676203012-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: seq: fix port creation API
Message-Id: <20200614125813.D1853F8022B@alsa1.perex.cz>
Date: Sun, 14 Jun 2020 14:58:13 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #36 was opened from takaswie:

ALSASeq.UserClient.create_port() has nullable argument for the numerical ID of port to use SNDRV_SEQ_PORT_FLG_GIVEN_PORT flag properly. However, the nullable is not inconvenient for PyGObject and causes SIGSEGV.

This patchset adds an alternative API, ALSASeq.UserClient.create_port_at() for the flag, then ALSASeq.UserClient.create_port() hs no argument for explicit port ID.

Additionally, this patchset includes some fixes for the other parts.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/36
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/36.patch
Repository URL: https://github.com/alsa-project/alsa-gobject

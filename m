Return-Path: <SRS0=JcyS=4S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B29C3F2D1
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Mar 2020 19:00:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7966E205ED
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Mar 2020 19:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nkjTEttT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7966E205ED
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDC7D168F;
	Sun,  1 Mar 2020 19:59:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDC7D168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583089242;
	bh=8aU6PMQfmfSBb+4ZuP7k7v6IDtEiDthWj2Ut0d9RXPk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nkjTEttTPtxiE8UkNJbY/WGZ1eJeVoJG/O4vxrzFyb4QR8MuL4BCuCmR93s9rjNv/
	 QGJ5lRI28zzC71MC1rIdkUYzw49qfVP39dR5vK1KewlI6EVyxD1dDSylbtSbvxVUSD
	 Ueb7RLp+SNb7vX8rcD5d62pfa3c8p+68XLsuquLs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C71BF80245;
	Sun,  1 Mar 2020 19:59:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 406F8F8025F; Sun,  1 Mar 2020 19:59:50 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 50BBDF80131
 for <alsa-devel@alsa-project.org>; Sun,  1 Mar 2020 19:59:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50BBDF80131
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1583089186608217955-webhooks-bot@alsa-project.org>
References: <1583089186608217955-webhooks-bot@alsa-project.org>
Subject: conf: namehint - add noargs to the hint section
Message-Id: <20200301185950.406F8F8025F@alsa1.perex.cz>
Date: Sun,  1 Mar 2020 19:59:50 +0100 (CET)
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

alsa-project/alsa-lib pull request #31 was opened from perexg:

Do not list simple surround devices in the namehint section by default.

Fixes: https://github.com/alsa-project/alsa-lib/issues/27

Request URL   : https://github.com/alsa-project/alsa-lib/pull/31
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/31.patch
Repository URL: https://github.com/alsa-project/alsa-lib

Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CA7C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:20:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986852070A
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZceSTKia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986852070A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19D9D83B;
	Mon, 20 Jul 2020 20:19:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19D9D83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595269231;
	bh=WC7/iyRLAT/g1zlr1jhJn3MfOtbTgzrcimsw7CRAUrQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZceSTKiayNQAwQrVjLhtu/nZAR00KhGlKbZQfpuDnTyuzcIlxPAXjbZbxBQNMrTjg
	 eBZD4M3Wrv8IhKko7oMKvK9MJfpMUEbUlQIFm49S7qJS+ANiMoue1MvHGLtHcV9Vqy
	 811jiEc3uF5okxhorRDm6w+XF0inWg6WwLmhrQG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94CA6F800C1;
	Mon, 20 Jul 2020 20:19:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B09BBF800F5; Mon, 20 Jul 2020 20:19:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 52A4BF800C1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 20:19:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52A4BF800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1595269155833822012-webhooks-bot@alsa-project.org>
References: <1595269155833822012-webhooks-bot@alsa-project.org>
Subject: Compile with debugging symbols
Message-Id: <20200720181933.B09BBF800F5@alsa1.perex.cz>
Date: Mon, 20 Jul 2020 20:19:33 +0200 (CEST)
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

alsa-project/alsa-lib issue #71 was opened from project-owner:

Hi, how can I compile the alsa-lib with debugging symbols enabled? Thank you!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/71
Repository URL: https://github.com/alsa-project/alsa-lib

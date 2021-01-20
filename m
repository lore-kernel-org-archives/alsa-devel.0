Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED96C43381
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 11:21:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC9422AAA
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 11:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC9422AAA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3ECF17A9;
	Wed, 20 Jan 2021 12:20:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3ECF17A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611141672;
	bh=Y6ltMCGQ7VLx9Ulj+0vr4nT7icHsPfDkSe5doyH1fwE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ptaz8dmOziF5EuqjZKgWiuEuE9Gsg3mf5DhtxZ/Sr9D7GqbhVXyXjG1OZj34364qO
	 oNsrUqMTPcEBGj2Bmr1rrFXvVMH6l9xIgRgVzVDwANzruA2pXhjuI68XN5Pj53Zh3D
	 moR4h+nAyeMwtIUp7qpD2L0z7mACwfDEy85If3gM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 321BAF80166;
	Wed, 20 Jan 2021 12:20:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E8F0F8016E; Wed, 20 Jan 2021 12:20:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CEAA3F80164
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 12:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEAA3F80164
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1611141610455234051-webhooks-bot@alsa-project.org>
References: <1611141610455234051-webhooks-bot@alsa-project.org>
Subject: Add jack2 as test
Message-Id: <20210120112021.0E8F0F8016E@alsa1.perex.cz>
Date: Wed, 20 Jan 2021 12:20:21 +0100 (CET)
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

alsa-project/alsa-utils pull request #74 was opened from bengan:

Jack2 been around for a long time. It should be included in the test.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/74
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/74.patch
Repository URL: https://github.com/alsa-project/alsa-utils

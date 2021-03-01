Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EED8C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 05:57:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34E164E38
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 05:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34E164E38
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88E0E1676;
	Mon,  1 Mar 2021 06:56:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88E0E1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614578267;
	bh=3UmKPT8kn62B1toOuoVA8CGfx08hNPwMx0GcY/nCh54=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wypqo3HpFI7dLUef02C2d+Mo6+SM23HFcy6V8pFk3xVsf4huEqWoDamcctmkJWs2+
	 VIWd+PSlNZKbQRvp5OO1lz6o7ibCMYjU3J596Rz5EgbpIaDJwgxVzmuDtytgjcXpZ/
	 rqE9PgyNaBrsnsKbgmWjdDPA1HynnIzNVkwgprO8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E715CF80257;
	Mon,  1 Mar 2021 06:56:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8FA4F80257; Mon,  1 Mar 2021 06:56:54 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A9B93F800E0
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 06:56:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9B93F800E0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1614578202265048981-webhooks-bot@alsa-project.org>
References: <1614578202265048981-webhooks-bot@alsa-project.org>
Subject: conf: USB - add "Cmedia Audio" to USB-Audio.pcm.iec958_device
Message-Id: <20210301055654.E8FA4F80257@alsa1.perex.cz>
Date: Mon,  1 Mar 2021 06:56:54 +0100 (CET)
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

alsa-project/alsa-lib pull request #122 was opened from jason77-wang:

Otherwise, there will be a "Digital Output(S/PDIF)-Cmedia Audio" from
Gnome UI, but there is no this physical interface on the card.

Signed-off-by: Hui Wang <hui.wang@canonical.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/122
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/122.patch
Repository URL: https://github.com/alsa-project/alsa-lib

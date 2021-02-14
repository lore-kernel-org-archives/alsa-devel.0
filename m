Return-Path: <SRS0=fPON=HQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B5EC433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Feb 2021 16:56:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F8164D99
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Feb 2021 16:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F8164D99
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A39B1681;
	Sun, 14 Feb 2021 17:55:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A39B1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613321809;
	bh=L3pV3nyEz76No4Letd5EySjIVXgk/0VHmtVWtgd6Hq4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=miBWWNpBzGjqa8W3Q+9x+qrAf28193CXTrUuGEEneM/dh1eouSLTr5kZsKt+/58ud
	 02GfZnMAsSYquMCeMTpdfn21BShlKmlawJ+QWusqIW/iffS5qbVDK9+Dcknq9HxpS0
	 2x1e+JtI82HDlwOZSzJNQplWDlHUKdDqLvOq6OR8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8955CF80127;
	Sun, 14 Feb 2021 17:55:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97C3EF80155; Sun, 14 Feb 2021 17:55:56 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C888EF800B2
 for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2021 17:55:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C888EF800B2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1613321745186568022-webhooks-bot@alsa-project.org>
References: <1613321745186568022-webhooks-bot@alsa-project.org>
Subject: amixer: Expand on channel docs in man page
Message-Id: <20210214165556.97C3EF80155@alsa1.perex.cz>
Date: Sun, 14 Feb 2021 17:55:56 +0100 (CET)
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

alsa-project/alsa-utils pull request #78 was opened from mcampbellizo:

Add missing channel params to the amixer man page. Also call out that
the channel param must come before the value to take effect.

signed-off-by: Matthew Campbell <mcampbell@izotope.com>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/78
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/78.patch
Repository URL: https://github.com/alsa-project/alsa-utils

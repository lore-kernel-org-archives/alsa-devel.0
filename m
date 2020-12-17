Return-Path: <SRS0=tU6Y=FV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16E0C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 11:13:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ECE2389B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 11:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ECE2389B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D9FF1861;
	Thu, 17 Dec 2020 12:12:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D9FF1861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608203584;
	bh=vYPYhYSfwkdbSNgKQdyuWBhNzfV8dLv4+VzvzwJ0l7w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ScPv3VHCWIyikQOF+fUtlVE5+2MqLwx8lBWKMGcBiFkZkg2Jua6GLPEmKh5dVN89M
	 p+7I5tetfc81L8UnuQUdPaEYXpwOv3OXvbEZXWGPv3EDMzNrPhou+gNRmS2zhkKrfM
	 D9OlFOtl69MMEWoNzF/J969ghyptJSEvsHuuSDAU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 146BBF80259;
	Thu, 17 Dec 2020 12:12:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 827FFF80260; Thu, 17 Dec 2020 12:12:12 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5DD14F80148
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 12:12:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DD14F80148
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1608203526273194075-webhooks-bot@alsa-project.org>
References: <1608203526273194075-webhooks-bot@alsa-project.org>
Subject: utils/alsa.m4: update for newer autoconf.
Message-Id: <20201217111212.827FFF80260@alsa1.perex.cz>
Date: Thu, 17 Dec 2020 12:12:12 +0100 (CET)
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

alsa-project/alsa-lib pull request #106 was opened from sezero:

fixes autoconf-2.70 warnings. should be compatible down to autoconf-2.59.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/106
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/106.patch
Repository URL: https://github.com/alsa-project/alsa-lib

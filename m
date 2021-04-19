Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CFCC433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 07:09:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5FD6102A
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 07:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5FD6102A
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EE0916BD;
	Mon, 19 Apr 2021 09:08:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EE0916BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618816166;
	bh=CimjLUgwW9e0kxiJldRS/KJey9vbcMYc6NhqDR8vM3o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=loqx02s2ATOqkk6ln3PX2MsduF1s/QxKpeQbw+qVufUk/KJiAnVTr8ngRuPsjL5ms
	 eErtVo78Db7/hIqnV8Oka8RUbrUGWZe4737euuSkTHqWswrWq9wc0m8vRNo/mAQBhI
	 i0p7E2q1mXuRbLyfrn96R+Feex0LkbCbazOyfo+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31770F80227;
	Mon, 19 Apr 2021 09:08:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDA97F80274; Mon, 19 Apr 2021 09:08:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 41960F80164
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 09:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41960F80164
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1618816095057609081-webhooks-bot@alsa-project.org>
References: <1618816095057609081-webhooks-bot@alsa-project.org>
Subject: [RFC] ucm2: rt711-sdca: remove 'rt711 FU0F Capture Switch' setting
Message-Id: <20210419070822.EDA97F80274@alsa1.perex.cz>
Date: Mon, 19 Apr 2021 09:08:22 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #89 was edited from libinyang:

The rt711-sdca codec driver removes the 'rt711 FU0F Capture Switch'
kcontrol. So we need to remove the setting of 'rt711 FU0F Capture Switch'
correspondingly.

Signed-off-by: Libin Yang <libin.yang@intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/89
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/89.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

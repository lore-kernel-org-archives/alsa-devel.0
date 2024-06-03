Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CC2C27C52
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:16:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 815DE83E;
	Mon,  3 Jun 2024 16:16:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 815DE83E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717424207;
	bh=0YrQzwBbORPrc6c8Gbvw1/9lSITV9qBRZRcdcEfxGqA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SwYvzxI2/mNjXDdfJE6XNWT87CQcle8uS5tcG3WaAEwfYH26kO5qmVQKQBrN7nDRJ
	 GigIydV0KnCsqSlPjwAPBvdwi5yPOJMpR3CEpP+3xG3UpYA2/d9SrcmK9AQfC/nuSY
	 GrFz6Ze9Esp/sWTMmry7k8DL4EWrKdu9F/pv2+Ec=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03EABF8051F; Mon,  3 Jun 2024 16:16:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D270F80587;
	Mon,  3 Jun 2024 16:16:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93AB8F8025A; Mon,  3 Jun 2024 16:16:11 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 420FFF800FA
	for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2024 16:16:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 420FFF800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1717424167495882511-webhooks-bot@alsa-project.org>
References: <1717424167495882511-webhooks-bot@alsa-project.org>
Subject: hcontrol,mixer: improve callback GIL state handling
Message-Id: <20240603141611.93AB8F8025A@alsa1.perex.cz>
Date: Mon,  3 Jun 2024 16:16:11 +0200 (CEST)
Message-ID-Hash: GIUK4N7YXZLMFKBGR7VEOFKBIM4PTWGT
X-Message-ID-Hash: GIUK4N7YXZLMFKBGR7VEOFKBIM4PTWGT
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GIUK4N7YXZLMFKBGR7VEOFKBIM4PTWGT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-python pull request #12 was opened from perexg:

It's an attempt to fix warning seen in #11 .

Request URL   : https://github.com/alsa-project/alsa-python/pull/12
Patch URL     : https://github.com/alsa-project/alsa-python/pull/12.patch
Repository URL: https://github.com/alsa-project/alsa-python

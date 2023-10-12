Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740DCCDB46E
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Oct 2023 09:06:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D38821FE;
	Thu, 12 Oct 2023 11:05:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D38821FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697101598;
	bh=YVr6CFar0jE0NiGZRvMnSiyGRPARNEefMrAMAFxNOF4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qNV/1wTy0HykQDFiTD9oQQAlIwBmY8jqaw0FCGIMLX+miikplpGQ3JLUIebKxKOMc
	 H84vpmGaye77qhgou7wAuN1Up+zr+GfXtcX2MtbWhp/mOFCQhAt8X3GkcC88hKeSbT
	 ZrgLC9G0OO0vMB3gN0mtnqYxSUcEKkwBJMfWRBYk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4AD52F80130; Thu, 12 Oct 2023 11:05:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2132EF802BE;
	Thu, 12 Oct 2023 11:05:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A7DDF802BE; Thu, 12 Oct 2023 11:05:43 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 305CCF80130
	for <alsa-devel@alsa-project.org>; Thu, 12 Oct 2023 11:05:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 305CCF80130
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1697101536196679592-webhooks-bot@alsa-project.org>
References: <1697101536196679592-webhooks-bot@alsa-project.org>
Subject: Make (extern) declarations and definition of macro_depth consistent
Message-Id: <20231012090543.7A7DDF802BE@alsa1.perex.cz>
Date: Thu, 12 Oct 2023 11:05:43 +0200 (CEST)
Message-ID-Hash: RUUNE55GZGHXK3XDOWWS2PEDXAMCBI5J
X-Message-ID-Hash: RUUNE55GZGHXK3XDOWWS2PEDXAMCBI5J
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RUUNE55GZGHXK3XDOWWS2PEDXAMCBI5J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools pull request #19 was opened from tautschnig:

All `extern` declarations refer to it as `unsigned int`, but the actual definition is a signed integer.

Reported by CBMC's goto-cc compiler, which performs type-aware linking.

Request URL   : https://github.com/alsa-project/alsa-tools/pull/19
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/19.patch
Repository URL: https://github.com/alsa-project/alsa-tools

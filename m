Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26527E99053
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:20:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94BEF60204;
	Fri, 10 Apr 2026 10:20:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94BEF60204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775809225;
	bh=M2DoYYHh0k9D5y3fJ/lTaq/bFnJ4aa/mONyvlKXwHgQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dk2dCFqIibO1L9jcXNx27/HxiyDXCV9x5OHwATJU4Rl2iyHT5BHDbXLFUoDs4N01E
	 r5SITj9rLnnFmVSIEcyIwQ4+yzYWzhb/LOvRaN9d8gxElL1MO8qn0AfPducHrbwWgI
	 lElNvwmuNulSTX6tDSKLLV2vHZyzhSYe8T4Y+n24=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A3A5F805B6; Fri, 10 Apr 2026 10:19:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C811F805ED;
	Fri, 10 Apr 2026 10:19:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 207DCF8052D; Fri, 10 Apr 2026 10:19:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 777E9F8021D
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2026 10:19:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 777E9F8021D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a4f10a2920f800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/744@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/744@alsa-project.org>
Subject: sof-soundwire: add companion amp config with rt721 and rt1320
Date: Fri, 10 Apr 2026 10:19:41 +0200 (CEST)
Message-ID-Hash: OJRTJ4BYCC55FP4IUHDTYUMZWSMSNZFS
X-Message-ID-Hash: OJRTJ4BYCC55FP4IUHDTYUMZWSMSNZFS
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OJRTJ4BYCC55FP4IUHDTYUMZWSMSNZFS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #744 was opened from oortcomet:

Support the machines with companion amps with rt721 and rt1320.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/744
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/744.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

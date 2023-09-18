Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E304CD37B0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 09:07:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F4B11FC;
	Mon, 18 Sep 2023 11:06:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F4B11FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695028049;
	bh=1jSrtDsI/ztD1oIKyJYAA9EitYy68n6oA9zojXbTgso=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=roiFOgiO05huJ/R0NgU0Bd/P1nAHrNdv9U27Zu1XsI8uo+bOHqzcBSrIGNtQUhKn7
	 jtzLwM2PpIo5GwVtNC65Bx6rA/2oUu3y3eILsMEonvAe8O2uf3rPcs3SztDMc51Wr6
	 mx5ZOTFO4MGhUWjWcvS2ay/eVLd75VYLxD2RYc3o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D19DF80552; Mon, 18 Sep 2023 11:06:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 36C4AF801F5;
	Mon, 18 Sep 2023 11:06:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0682BF801F5; Mon, 18 Sep 2023 11:06:07 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 5770DF80125
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 11:06:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5770DF80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1695027964347604990-webhooks-bot@alsa-project.org>
References: <1695027964347604990-webhooks-bot@alsa-project.org>
Subject: bat: really skip analysis of the first period and update related
 comment
Message-Id: <20230918090607.0682BF801F5@alsa1.perex.cz>
Date: Mon, 18 Sep 2023 11:06:07 +0200 (CEST)
Message-ID-Hash: 3L67BOOLXLVFT55KCHZ4W7B66HRW33W3
X-Message-ID-Hash: 3L67BOOLXLVFT55KCHZ4W7B66HRW33W3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3L67BOOLXLVFT55KCHZ4W7B66HRW33W3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #237 was edited from dbrignoli:

Prior to this change bat/analyze.c would skip the last period of the recording, contrary to the comment in the code which stated the first period was meant to be skipped.

The comment has been updated to state that both the first and last period are skipped and the code has been updated to match.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/237
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/237.patch
Repository URL: https://github.com/alsa-project/alsa-utils

Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220B6D3ABF5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2024 20:45:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB1669F6;
	Mon, 11 Nov 2024 21:45:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB1669F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1731357957;
	bh=Ve40Idatcd/13sdTW+HSe7SduRJB1RfxWkyW5s49wCQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=J02I00lDJQaso9A3O93lFULH0eU5jpZB00iJYMbtoaMjFFcIx4tCWZ1S2fqKFauIg
	 qsDMUwVrLi0rc6V0UjKSCSNvCaQm7stTmZPYA6JWQb78EGObVMA/6PcfZ0BhcQfcCC
	 aOuHHuO5S0qrJs64jHsY+f1tV5DjFciOmFUg/Njw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 549C7F805BB; Mon, 11 Nov 2024 21:45:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 526CDF805B4;
	Mon, 11 Nov 2024 21:45:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC384F80199; Mon, 11 Nov 2024 21:45:17 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 8155EF800C9
	for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2024 21:45:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8155EF800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1731357913745631218-webhooks-bot@alsa-project.org>
References: <1731357913745631218-webhooks-bot@alsa-project.org>
Subject: Change 26ce:0a08 to list multiple motherboards
Message-Id: <20241111204517.DC384F80199@alsa1.perex.cz>
Date: Mon, 11 Nov 2024 21:45:17 +0100 (CET)
Message-ID-Hash: FVVZDGTMNHLJMJFPR2BCAZT5AD3Q2WTR
X-Message-ID-Hash: FVVZDGTMNHLJMJFPR2BCAZT5AD3Q2WTR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FVVZDGTMNHLJMJFPR2BCAZT5AD3Q2WTR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #461 was opened from cybik:

The hardware id `26ce:0a08` seems to be re-used by multiple motherboards at ASRock. Identify them within `[brackets]` to point out the specific boards in question.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/461
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/461.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

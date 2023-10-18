Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F67CDB47E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Oct 2023 23:02:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3E8E850;
	Thu, 19 Oct 2023 01:01:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3E8E850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697670159;
	bh=vubtu3FBNwxkiUgW8lKRHs5BHAAA6l/1m689RXU+dJ8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=X1CDwL9aVjEWqOR4twgsb9Nf+68Qvezo1CAdnsVDRQaQ6rFEER6GhdNZdu1f/ynPO
	 WMak2JbDJs99pEWtT11N1BJMMJ6IPVOi5LnwgWiYtLRW8ZmBOj10GXTW4BSSegyjQq
	 SC349j5eUVqQPM1vgQW4LZgatE/pgGkhWbBBy+PQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56C4CF80553; Thu, 19 Oct 2023 01:01:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8579F8025F;
	Thu, 19 Oct 2023 01:01:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B844F8025F; Thu, 19 Oct 2023 01:01:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 730BAF80166
	for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2023 01:01:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 730BAF80166
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1697670062091358185-webhooks-bot@alsa-project.org>
References: <1697670062091358185-webhooks-bot@alsa-project.org>
Subject: ucm2: add acpd7219m98357
Message-Id: <20231018230114.7B844F8025F@alsa1.perex.cz>
Date: Thu, 19 Oct 2023 01:01:14 +0200 (CEST)
Message-ID-Hash: ZXICWFTQNSSBGOS46WQ5VLI3KWKYWJD6
X-Message-ID-Hash: ZXICWFTQNSSBGOS46WQ5VLI3KWKYWJD6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZXICWFTQNSSBGOS46WQ5VLI3KWKYWJD6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #361 was opened from WeirdTreeThing:

For "grunt" chromebooks

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/361
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/361.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

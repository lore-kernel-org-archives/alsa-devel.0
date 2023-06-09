Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A550C7EE2E
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jun 2023 09:56:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC575204;
	Fri,  9 Jun 2023 11:55:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC575204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686304594;
	bh=cLuB5TlziDKtghzpk8GzLzrWpneI9TQJCyBnRGxA4wc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BDUDh45wIcTQH3RIbJth7Fl52zFWRVZB5AMfhLTpa5dMnpCssmzrPQ+RKbXgsF6ab
	 5lCOzMchuIrnwEReUv5KBxxXARL+bTo0r5y+xExuAdxoauWxbCyJZXtnMmgUixDtQX
	 rSaoEZgVyIWDpE0Jk7ISqjlFbFq+f4Rc/MkO8M8g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF7C4F80254; Fri,  9 Jun 2023 11:55:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8509DF80199;
	Fri,  9 Jun 2023 11:55:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A362F80199; Fri,  9 Jun 2023 11:55:17 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FB41F800C8
	for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2023 11:55:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FB41F800C8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1686304515512615442-webhooks-bot@alsa-project.org>
References: <1686304515512615442-webhooks-bot@alsa-project.org>
Subject: ucm2: MediaTek: mt8395-evk: Add alsa-ucm support
Message-Id: <20230609095517.0A362F80199@alsa1.perex.cz>
Date: Fri,  9 Jun 2023 11:55:17 +0200 (CEST)
Message-ID-Hash: KN56M5WNGCWUECARUJWRB5AXKGBEQ4QK
X-Message-ID-Hash: KN56M5WNGCWUECARUJWRB5AXKGBEQ4QK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KN56M5WNGCWUECARUJWRB5AXKGBEQ4QK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #322 was opened from zoran055:

Add alsa-ucm support for the MediaTek mt8395-evk platform.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/322
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/322.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

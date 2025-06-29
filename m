Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E32FC7EE39
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Jun 2025 17:24:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6ED1A6020F;
	Sun, 29 Jun 2025 19:23:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6ED1A6020F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1751217839;
	bh=wzdW8SLLrvV7bIwbHqjJn2n9t9oQoewMn+uDlznuR7o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WK7Y8L1L0+oI5xqLOYSEMPtmgUYUQBM8Eic2lv6OYyDHtrEsCSHokjdneCFULzDz9
	 MEhMBHboYuyaZn4r7zxpPxjMZlwGkTe7ZpkHeenehD9EHBaVojOnm3BYS+nvEUAgG3
	 H+yrfI+WzMC9c3HZS2MbMg/0RJxvm/Kjv7duqaME=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2865FF805E5; Sun, 29 Jun 2025 19:23:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E5AAF805E5;
	Sun, 29 Jun 2025 19:23:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 916EFF80537; Sun, 29 Jun 2025 19:23:28 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EA4E1F80124
	for <alsa-devel@alsa-project.org>; Sun, 29 Jun 2025 19:23:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA4E1F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184d93512ae15e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/589@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/589@alsa-project.org>
Subject: ucm2: Qualcomm: Add Dell Latitude 7455 / Inspiron 14 Plus 7441
 support
Date: Sun, 29 Jun 2025 19:23:28 +0200 (CEST)
Message-ID-Hash: ID6CAKY7JHUCJIY4EZQCBNYIVQ2NJOHZ
X-Message-ID-Hash: ID6CAKY7JHUCJIY4EZQCBNYIVQ2NJOHZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ID6CAKY7JHUCJIY4EZQCBNYIVQ2NJOHZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #589 was edited from valpackett:

(Both SKUs are identical, the codename is Thena)

This configuration is:

- 4 speakers
- 2 DMICs
- headset with mic
- DisplayPort (not yet)

---

audioreach: https://github.com/linux-msm/audioreach-topology/pull/25

cc @0xB0D @alexVinarskis

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/589
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/589.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

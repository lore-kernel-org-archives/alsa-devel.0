Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536ECC48260
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jan 2024 10:54:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD1A183B;
	Fri, 26 Jan 2024 11:54:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD1A183B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706266458;
	bh=0N+qLDdgrT4FO1xm6oWW6shb9FyGY1PdOA0NcYqZuMc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Ubs2TSLV3j4C8twCFowuxQe+gRkpw6KkSzrEX6lDFseHSyKBYTIqNy1JgTljxtL/C
	 TEUI43l4y6RMNxPhApVvv+ORYuLKeVIWx9hWv6EXt1PA+nT2GfMygMURsU38ZufuQY
	 BbGnSCX7jjwWaA3JYCubAErEMk1tVZ4MiSLQu38Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B32B2F805A8; Fri, 26 Jan 2024 11:53:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5174AF80579;
	Fri, 26 Jan 2024 11:53:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04772F8028D; Fri, 26 Jan 2024 11:52:35 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 16952F8022B
	for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2024 11:52:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16952F8022B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1706266351951248884-webhooks-bot@alsa-project.org>
References: <1706266351951248884-webhooks-bot@alsa-project.org>
Subject: Add UCM2 Configs for Qualcomm sm8650 platforms
Message-Id: <20240126105235.04772F8028D@alsa1.perex.cz>
Date: Fri, 26 Jan 2024 11:52:35 +0100 (CET)
Message-ID-Hash: UBLSORXPR4MLVVVAXEYBPXWP6QWUSX5Y
X-Message-ID-Hash: UBLSORXPR4MLVVVAXEYBPXWP6QWUSX5Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UBLSORXPR4MLVVVAXEYBPXWP6QWUSX5Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #390 was opened from superna9999:

This adds the UCM2 Configs for Qualcomm SM8650 MTP & QRD platforms.

Tested with PulseAudio 16.1.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/390
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/390.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

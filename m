Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1617DEB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 02:47:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CBAB6C1;
	Wed, 21 Jun 2023 04:46:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CBAB6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687315654;
	bh=NiUVRRZcvOnc7TSwRvKVnyOCy4QgZex9DBeBNtR/SpA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mwp0lNwAuO2mxcu693ULJR9VK/sKMsMQ5SI5LQ/dhQg5QmLaa80Q9jaJxf/d0276g
	 rWUFe5QvhZs5d1ipziokERHyGnt1WjvHedME45QOkOiqrG2MyAZzYuv6YRfKpJ5bY8
	 UXD/kKrTejzYuNjVrPXIqIiBa1Nn2M5YGNvGiqSc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D66BBF80535; Wed, 21 Jun 2023 04:46:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EAFEDF80141;
	Wed, 21 Jun 2023 04:46:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1504DF80141; Wed, 21 Jun 2023 04:46:08 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 95012F80093
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 04:46:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95012F80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687315559875258446-webhooks-bot@alsa-project.org>
References: <1687315559875258446-webhooks-bot@alsa-project.org>
Subject: use-case: Add new LatencyOffsetMs field
Message-Id: <20230621024608.1504DF80141@alsa1.perex.cz>
Date: Wed, 21 Jun 2023 04:46:08 +0200 (CEST)
Message-ID-Hash: QHACD4JBMOVKKVJQTHGCHX4OEFNGTMSE
X-Message-ID-Hash: QHACD4JBMOVKKVJQTHGCHX4OEFNGTMSE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QHACD4JBMOVKKVJQTHGCHX4OEFNGTMSE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #332 was opened from afq984:

Some drivers do not report accurate latencies. Add a LatencyOffsetMs UCM Value allow adding a static offset to the reported latency.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/332
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/332.patch
Repository URL: https://github.com/alsa-project/alsa-lib

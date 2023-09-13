Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85C1EE020D
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Sep 2023 21:18:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E53E8A4C;
	Wed, 13 Sep 2023 23:17:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E53E8A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694639904;
	bh=Ux1wyoOuxnb0DR57U2rXBI93mQ61yPLN0ox5OTXhgdc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Q/neuYHdiEsaj7ttuObMQr7YZfUT3XE+kItNZHKH+BIO4kctNo4yfsuTLTAiFacHQ
	 m93WwjCCv7RfuDKryYLf2t3X/E4ikglCfmTthnQAYxp+lxNdByiXlxR/vcpWiKxzHC
	 AlXbQWtxyRwFdKQ02FLbk0/UddhpsR+UMw0wx/K4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1653F801F5; Wed, 13 Sep 2023 23:17:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73785F801F5;
	Wed, 13 Sep 2023 23:17:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07A77F80425; Wed, 13 Sep 2023 23:17:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E096F801F5
	for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2023 23:17:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E096F801F5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1694639828339812279-webhooks-bot@alsa-project.org>
References: <1694639828339812279-webhooks-bot@alsa-project.org>
Subject: Roland Bridgecast - add missing intermediate config file
Message-Id: <20230913211710.07A77F80425@alsa1.perex.cz>
Date: Wed, 13 Sep 2023 23:17:10 +0200 (CEST)
Message-ID-Hash: VGCAHL4KGF2MQSGOQLJ5ESCQSM2M27RC
X-Message-ID-Hash: VGCAHL4KGF2MQSGOQLJ5ESCQSM2M27RC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VGCAHL4KGF2MQSGOQLJ5ESCQSM2M27RC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #354 was opened from smangels:

- closes #353
- tested on ArchLinux running UCM version 1.2.10

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/354
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/354.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

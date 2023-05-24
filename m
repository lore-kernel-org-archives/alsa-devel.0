Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D459CC77B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 24 May 2023 07:31:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2D7A206;
	Wed, 24 May 2023 09:30:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2D7A206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684913465;
	bh=EFonjWLZe4T9ALKbn/e7Pa3SoYcl5LPMz9pzDTmCeig=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gWw/kIJyftd+TNPYiljX+HeeP71LyVVrEZCkOSnQ2wDNBBROITD9TCQYm5kEaMITs
	 5I2vpLiCzGDuMwtODaHNCBlzVqVcOF4RGeAwJlMt9jxFhj0DguOv6eDce/u9BsNRrL
	 Luw6qLWNf2pJCgU0Uvu7vEiL8WrM99XUe6PmRTLM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB8E0F8024E; Wed, 24 May 2023 09:29:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81C77F8024E;
	Wed, 24 May 2023 09:29:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD2D1F8024E; Wed, 24 May 2023 09:29:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 720CAF80086
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2023 09:29:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 720CAF80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1684913378855393648-webhooks-bot@alsa-project.org>
References: <1684913378855393648-webhooks-bot@alsa-project.org>
Subject: ucm2: Rockchip: Add UCM support for ES8316 on Rock 5B
Message-Id: <20230524072941.DD2D1F8024E@alsa1.perex.cz>
Date: Wed, 24 May 2023 09:29:41 +0200 (CEST)
Message-ID-Hash: 4OMW7F3YQZM3SQT4UZDASDKTSQ35DWXX
X-Message-ID-Hash: 4OMW7F3YQZM3SQT4UZDASDKTSQ35DWXX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4OMW7F3YQZM3SQT4UZDASDKTSQ35DWXX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #316 was opened from cristicc:

Add UCM configuration for the RK3588 SoC based Rock 5B board to enable the analog audio support provided by the Everest Semi ES8316 codec.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/316
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/316.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

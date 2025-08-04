Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B1CC87FD3
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Aug 2025 06:14:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 707F760257;
	Mon,  4 Aug 2025 08:14:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 707F760257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754288059;
	bh=KJM8i5kC+apt1M4ClhgJKh1KK5ayGOEzU/4lv9rRT7Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=o1UZ5S3bslWF0l9VfUpFlo1bbUGh34ByLOa0QabCJVg5ExR80seXG1PlmyVBPARWX
	 kwC8MFex3c3ranqKRP0xqx3BTtPtqlIC7dzVW/uyjaA2/ehvnZrT0GMhsuZUlgl144
	 5T08BbQR7Ky/WAfGhrEwXVmih1MyWJ9SsoSbXTWQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90D38F805D6; Mon,  4 Aug 2025 08:13:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2B3AF805C9;
	Mon,  4 Aug 2025 08:13:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73D5EF804CF; Mon,  4 Aug 2025 08:13:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 036F0F8003C
	for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2025 08:13:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 036F0F8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18587ba097f67b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/597@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/597@alsa-project.org>
Subject: Qualcomm: Add QCS8275-IQ8-EVK HiFi config
Date: Mon,  4 Aug 2025 08:13:15 +0200 (CEST)
Message-ID-Hash: ZSVX4MARSOZJD2QJGMA4TGO77TT5PZ67
X-Message-ID-Hash: ZSVX4MARSOZJD2QJGMA4TGO77TT5PZ67
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZSVX4MARSOZJD2QJGMA4TGO77TT5PZ67/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #597 was opened from mohsRafi:

Add UCM2 configs for the Qualcomm QCS9075-IQ8-EVK Board to handle:
	- I2S Speaker Amplifier
	- I2S Mic

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/597
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/597.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

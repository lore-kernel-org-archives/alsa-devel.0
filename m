Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB00C25B7C
	for <alsa-devel@archiver.kernel.org>; Mon, 27 May 2024 11:30:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14990950;
	Mon, 27 May 2024 13:30:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14990950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716809410;
	bh=w1qhaq0A6qA7yKSmSdUlqn2ENOxp24vkX6wOYiTLcJg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=iE1II2DQE7AtgBqkTktCa2e6PSL64O+O0LL4d1lVG1RI2z6rWWGjVoNUScKbloQak
	 T59YjJxF70881FuPL9ZJsuzR6G5QAIsQawNXpRes1AoyjiFewmWVyO7EmwrveYj2XD
	 FGv1jbP5Z5d0t9O9vQi2Wbqp4QbITVGMbXIGJcH0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C4A4F80671; Mon, 27 May 2024 13:28:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1BE7F8067C;
	Mon, 27 May 2024 13:28:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F217AF8026D; Mon, 27 May 2024 13:24:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id CF4BCF80051
	for <alsa-devel@alsa-project.org>; Mon, 27 May 2024 13:24:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF4BCF80051
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1716809048469963789-webhooks-bot@alsa-project.org>
References: <1716809048469963789-webhooks-bot@alsa-project.org>
Subject: Alsa lib is not able to find the UCM .conf files
Message-Id: <20240527112414.F217AF8026D@alsa1.perex.cz>
Date: Mon, 27 May 2024 13:24:14 +0200 (CEST)
Message-ID-Hash: 66PU2QL4G34WVLEHQGURJIZ6QAAW7HC7
X-Message-ID-Hash: 66PU2QL4G34WVLEHQGURJIZ6QAAW7HC7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/66PU2QL4G34WVLEHQGURJIZ6QAAW7HC7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #420 was opened from 3bitbrain:

Note : the sound card is a Xonar DX ( AV200 )
The alsa UCM files are installed at PATH=/usr/share/alsa
When I try to start alsasound, I get this error ==
`
alsa-lib-1.2.11/src/umc/main.c:1554: (snd_use_case_mgr_open) error : failed to import hw:1 use case configuration -2
`
The CMD alsaucm listcards gets this response : list is empty.

[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/15455180/alsa-info.txt)
[aplay-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/15455183/aplay-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/420
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

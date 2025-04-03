Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEFBC3600C
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Apr 2025 08:22:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AA226020E;
	Thu,  3 Apr 2025 10:22:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AA226020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743668576;
	bh=xtQvsYA1IXHHHO3BYsvy+TSBImXVF2i6pycXorIcwjg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QqTr4tQmIVVxktW46RZ5xY0aw0lVcID/hceLhfQBjMpK0o8Uy2/jB13N2lyoFhTAi
	 wvC/UQWvWsM2hstugSZwHa4iTeXnvjCKxFqauPOsAWArc5QU/M4C8Q+CYjonv7Q8ep
	 nMJl3F7AJeZ5AiW/xc5jKlcAQkVgEd/IForT3qTQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3DCEF805BE; Thu,  3 Apr 2025 10:22:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AEFC7F805BB;
	Thu,  3 Apr 2025 10:22:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7008DF800BF; Thu,  3 Apr 2025 10:22:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B822BF800BF
	for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2025 10:22:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B822BF800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1832c14bd7ed0500-webhooks-bot@alsa-project.org>
In-Reply-To: <1832c14bd7c7d100-webhooks-bot@alsa-project.org>
References: <1832c14bd7c7d100-webhooks-bot@alsa-project.org>
Subject: Alsa lib is not able to find the UCM .conf files
Date: Thu,  3 Apr 2025 10:22:19 +0200 (CEST)
Message-ID-Hash: WQU6SB4QHSU2SXYAH4PH6B4ELUHLU33U
X-Message-ID-Hash: WQU6SB4QHSU2SXYAH4PH6B4ELUHLU33U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WQU6SB4QHSU2SXYAH4PH6B4ELUHLU33U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #449 was opened from 3bitbrain:

Note : the sound card is a Xonar DX ( AV200 )
The alsa UCM files are installed at PATH=/usr/share/alsa
When I try to start alsasound, I get this error ==
`
alsa-lib-1.2.11/src/umc/main.c:1554: (snd_use_case_mgr_open) error : failed to import hw:1 use case configuration -2
`
The CMD alsaucm listcards gets this response : list is empty.

[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/15455180/alsa-info.txt)
[aplay-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/15455183/aplay-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/449
Repository URL: https://github.com/alsa-project/alsa-lib

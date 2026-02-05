Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4797DECD998
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Feb 2026 19:18:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1008601EF;
	Thu,  5 Feb 2026 20:18:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1008601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770319127;
	bh=SdeJsJ64qEtImlo/LajP4EZcZkCFjmZ22EeeERkTQOg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Ka/wu9zexcfbdf/6UYmIxwGi8Yllj4BVq7bhecipwIOC4YVoonq0XAlNmohOhvBHj
	 gore7Zyaveo+O9/EvXcJxvFDrXgrRaog1uZUIOJdLV7gz3UOkA86XSwVzlTrnmkNSw
	 o7Z58e5eM4ynmn7cUL2lhf+pJiOwHgFmnu6TV9dg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E36BF805F3; Thu,  5 Feb 2026 20:18:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AC2CF805E9;
	Thu,  5 Feb 2026 20:18:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 183A5F8051E; Thu,  5 Feb 2026 20:17:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 54A93F8010B
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2026 20:16:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54A93F8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18916fc357b46f00-webhooks-bot@alsa-project.org>
In-Reply-To: <18916fc35551b900-webhooks-bot@alsa-project.org>
References: <18916fc35551b900-webhooks-bot@alsa-project.org>
Subject: MOTU M6 reports [ALSA UCM error] but seems to be working fine.
Date: Thu,  5 Feb 2026 20:17:21 +0100 (CET)
Message-ID-Hash: HRKNQA5HTTAYMEAUEFZFOD3IWCGFGQRS
X-Message-ID-Hash: HRKNQA5HTTAYMEAUEFZFOD3IWCGFGQRS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HRKNQA5HTTAYMEAUEFZFOD3IWCGFGQRS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #700 was opened from damex:

hi,
  i did fresh fedora 43 install and noticed that my MOTU m6 reports ALSA UCM error on all inputs and outputs but those inputs and outputs work just fine.

<img width="659" height="381" alt="Image" src="https://github.com/user-attachments/assets/cdce7782-7581-4c05-b501-2e22d5920446" />

<img width="819" height="206" alt="Image" src="https://github.com/user-attachments/assets/2290dd4b-f0af-4f75-a58b-6b5a056ee933" />

  in some software it is difficult to choose correct input due to presence of this error in device name.
  i did find https://github.com/alsa-project/alsa-ucm-conf/issues/552 this report to be similar to mine. attaching full alsa info output here (it was requested in that report)

  
[alsa-info.txt](https://github.com/user-attachments/files/25109878/alsa-info.txt)

please let me know if i you need any more information from me.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/700
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

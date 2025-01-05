Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B043AE77197
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2025 22:34:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 923CE601DE;
	Sun,  5 Jan 2025 23:33:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 923CE601DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1736116437;
	bh=rYwZXEuoQHZ3PeRBBGUdrRVfeeCywFXtILWfep3hKVA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RDL1iGhIO2ywBF0ErYE/vm2YK253J23zTiUf4JExrdMdEBtno79Il5oeLzdH9DvVX
	 hZQZbtPiGq0HGgRlV/hmS10wRYSv33H3br6E1NqWmhiyGZcmAqQX/wQlTmwd0dnwch
	 K9LoX5haI1rETIJETUeaBDVwjqAUBln0G99tUmBU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25089F805BB; Sun,  5 Jan 2025 23:33:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E24A0F805BF;
	Sun,  5 Jan 2025 23:33:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28D15F8051D; Sun,  5 Jan 2025 23:33:15 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B0D38F804B0
	for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2025 23:33:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0D38F804B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1736116391219666719-webhooks-bot@alsa-project.org>
References: <1736116391219666719-webhooks-bot@alsa-project.org>
Subject: bug in the asla driver asla-sink-viritio-snd
Message-Id: <20250105223315.28D15F8051D@alsa1.perex.cz>
Date: Sun,  5 Jan 2025 23:33:15 +0100 (CET)
Message-ID-Hash: FRDWVRWAC6DYFWJV7ENQTWSNU7M32ET7
X-Message-ID-Hash: FRDWVRWAC6DYFWJV7ENQTWSNU7M32ET7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FRDWVRWAC6DYFWJV7ENQTWSNU7M32ET7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #434 was opened from LoreFiore:

<img width="1440" alt="Screenshot 2025-01-05 alle 23 31 08" src="https://github.com/user-attachments/assets/34b279a0-b256-4e7b-82ec-a9df46f9f627" />

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/434
Repository URL: https://github.com/alsa-project/alsa-lib

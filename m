Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244CBCCFA13
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:37:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66365601FF;
	Thu,  6 Nov 2025 12:36:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66365601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762429019;
	bh=0U3agU+QxCAl6AcUwnMEpoHScnnGiGMMdQAg4PGGJRs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FiBueFBjuB/2DAGvvgtG8BITqFECEIY4FElzUgkeCuTsL0CzVJLDD8ZkJZK0K2B7e
	 Omryct5AKMeNUKrIFlHiudYwaO4XWFY13bow9MML36GmHHGKgU5FXvQ3zkXmbLyMHN
	 yWlfUpVKRWjsVTkeR65aF8R1O9p5aEFJIKYX6sl0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FBB8F805CA; Thu,  6 Nov 2025 12:36:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 13B73F805D2;
	Thu,  6 Nov 2025 12:36:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BC8DF80272; Thu,  6 Nov 2025 12:36:15 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A5D8CF800FA
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2025 12:36:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5D8CF800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187567cf34365200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/637@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/637@alsa-project.org>
Subject: ucm2: Add setting LED Mode in SetLED macro
Date: Thu,  6 Nov 2025 12:36:15 +0100 (CET)
Message-ID-Hash: LVIDNH7JV2MP4J5OQWFTWXK5UGHYZEPE
X-Message-ID-Hash: LVIDNH7JV2MP4J5OQWFTWXK5UGHYZEPE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LVIDNH7JV2MP4J5OQWFTWXK5UGHYZEPE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #637 was opened from mstrozek:

Add 'Mode' argument to SetLED macro in order to allow setting a different LED mode. This will allow mute switches with inverted values to control the LEDs with 'follow-route' option instead of default 'follow-mute'.

Update all calls to SetLED with appropriate Mode argument.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/637
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/637.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

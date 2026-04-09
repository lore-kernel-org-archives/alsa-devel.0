Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EBAF364B6
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:03:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA02F60203;
	Thu,  9 Apr 2026 23:03:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA02F60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775768594;
	bh=VvbbXoJSB1SoATQaGUNEpcK0JVs1UXPT/JRKevct6cg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QLBZ0R4CswxUMtYcU22ZrSI8tR79YiXKBb0qAyYtwgqO1C5tt6LNr4SDmjljnx2NI
	 fyU1bxU5ylGS58S6r7TfyNJGVS9NSOzVv3K/n8ePK52VGTn8zTHT1+hGTB816eKTMB
	 cknWRvwfiazuhVAXJoATtIwUM7uWardyxPyqpbfc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22ED5F805EE; Thu,  9 Apr 2026 23:02:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ADE53F805F2;
	Thu,  9 Apr 2026 23:02:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 775ECF8052D; Thu,  9 Apr 2026 23:02:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C88F0F800BA
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 23:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C88F0F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a4cc14af81e500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/742@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/742@alsa-project.org>
Subject: USB-Audio: Add RODECaster Duo
Date: Thu,  9 Apr 2026 23:02:31 +0200 (CEST)
Message-ID-Hash: JWFIHXCR33H6VRXD4LUFJ4CIVR772YL6
X-Message-ID-Hash: JWFIHXCR33H6VRXD4LUFJ4CIVR772YL6
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JWFIHXCR33H6VRXD4LUFJ4CIVR772YL6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #742 was opened from quonic:

The RODECaster Duo is very similar to the RODECaster Pro II, other than the physical/virtual faders from the USB side of things.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/742
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/742.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

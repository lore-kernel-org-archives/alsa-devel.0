Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6F5F9936C
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:51:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACBFD601FA;
	Thu, 23 Apr 2026 12:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACBFD601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776941462;
	bh=FkMc/GrZKiynteim3yJPRbfkQHqJj6KmYxq5vQxsVCo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aCBKR3igLEe9/NaSmm8ubZfLUI04fL4lTB3dP/KL9NdZhviu/34IE9S8S6ApN/hqA
	 pcNmDWmodrf0QvEsGdWEaxAt7m90QLaJSZF6hJDEX/CGMs3TV0t9IvtajmCcs8XaBh
	 2qF0NSu1EirS3Vem/UiOuPOBB4iV6tTd0123CNrE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F6ACF805F2; Thu, 23 Apr 2026 12:50:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BD4AF805F4;
	Thu, 23 Apr 2026 12:50:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87184F80526; Thu, 23 Apr 2026 12:50:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3ADA3F80171
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2026 12:50:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ADA3F80171
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a8f6cdf3f0e600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/753@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/753@alsa-project.org>
Subject: ucm2: rt722: add speaker mute LED and PlaybackSwitch for FU06
Date: Thu, 23 Apr 2026 12:50:20 +0200 (CEST)
Message-ID-Hash: 4YGX2QNV2EW7KUAVT4JJ43W6R7FTDZVY
X-Message-ID-Hash: 4YGX2QNV2EW7KUAVT4JJ43W6R7FTDZVY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4YGX2QNV2EW7KUAVT4JJ43W6R7FTDZVY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #753 was opened from pma1:

Attach rt722 FU06 Playback Switch to the speaker mute LED via SetLED in init.conf, and declare PlaybackSwitch in the Speaker device so PipeWire can toggle hardware mute.

Link: https://lore.kernel.org/linux-sound/20260423101338.1040131-1-aaron.ma@canonical.com/

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/753
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/753.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

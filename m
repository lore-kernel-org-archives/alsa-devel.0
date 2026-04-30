Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FAECCFA13
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:28:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A4B8601C9;
	Thu, 30 Apr 2026 13:28:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A4B8601C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777548510;
	bh=7iLqFaRt9PJeW1VMyUOBJKlZZm0g1BWXdeqj+NNxbEU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bSlm/JqWqVvuT3MmxJGSowGLH5lTIfZT1d11o5TH7JbmlFF/EUJ+xGmb8OJlpdfDI
	 RFFLbH3hdtZt7F0UngPP0EwawO+RF0DK0s/qXIZl0U143JOYiXVU1aWUC+EiWfH+w4
	 L7AGRgJd/GFn8AzytpWdXtS3166UUKUYBUpV+wuw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57F19F8016D; Thu, 30 Apr 2026 13:27:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C9F3F8016D;
	Thu, 30 Apr 2026 13:27:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 395CAF802BE; Thu, 30 Apr 2026 13:27:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C06DF8016D
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2026 13:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C06DF8016D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ab1ee9d3bc0700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/756@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/756@alsa-project.org>
Subject: Jg/blackrock audio
Date: Thu, 30 Apr 2026 13:27:50 +0200 (CEST)
Message-ID-Hash: IFLJCWD4DSQLSK2A3WAVYWJMC7D5AUXL
X-Message-ID-Hash: IFLJCWD4DSQLSK2A3WAVYWJMC7D5AUXL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IFLJCWD4DSQLSK2A3WAVYWJMC7D5AUXL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #756 was opened from jglathe:

Introduce a device profile for the Microsoft Windows Dev Kit 2023. It has a miniDP out and 2 Type-C connectors capable of DP Altmode, and no other (easily) accessible othe audion input/outputs. To use it you also need the corresponding topology, will be a [PR in audioreach-topology](https://github.com/jglathe/audioreach-topology/tree/jg/blackrock).
I also tried to integrate it with the existing Lenovo Thinkpad X13s profile to get automatic detection (works here).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/756
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/756.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

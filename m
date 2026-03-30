Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5E81061B0F
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:56:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B963601F5;
	Mon, 30 Mar 2026 17:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B963601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774886190;
	bh=Ngvnrs7gmk6WYur9mv1T3kP/i4lcKUjXg4s4j4tj0D4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DdTm/ofz74AXIdcxm9VbvaSccOVIj4rpZMlETvpEckZ+EsVxYDVzE4JAnb/JfpLVU
	 b+vFXa3DHkqeXoPcSrKITHtf5c03hibSga9A0qCCoYOqh2zp9/8/H6/SKx83V+5vav
	 7vXeQDb49CCC6D2ESK81sWlkdCs5Ye4iMzxDd7u4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F1EEF805E9; Mon, 30 Mar 2026 17:55:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E9071F805EC;
	Mon, 30 Mar 2026 17:55:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F318F8052D; Mon, 30 Mar 2026 17:55:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F01EF8027B
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 17:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F01EF8027B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a1a98ab7052f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/716@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/716@alsa-project.org>
Subject: sof-hda-dsp: add workaround for speaker LED on MSI laptops
Date: Mon, 30 Mar 2026 17:55:44 +0200 (CEST)
Message-ID-Hash: W6QJ3VUL4GBHDFG2LQ7JM7IIKIFUQO6D
X-Message-ID-Hash: W6QJ3VUL4GBHDFG2LQ7JM7IIKIFUQO6D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W6QJ3VUL4GBHDFG2LQ7JM7IIKIFUQO6D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #716 was reopened from Fede2782:

Make speaker LED work out of the box once LEDs are made discoverable via msi-ec module

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/716
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/716.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

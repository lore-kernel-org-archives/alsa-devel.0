Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFC0103E166
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:48:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CB90601A5;
	Wed, 18 Mar 2026 12:47:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CB90601A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773834487;
	bh=kw4o0TTAI3sk+qfGTOjurmG25nMS2R3wVrjgTh0bDIY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SDKklJvb/poxzbxmAqC6e8sqSTbBWBg1BTHalatqhaHSVYIpeLxeMvH6TJxBioqis
	 KlL1KWXdsmwmTRZjg6Zz1TfNWF7xZlpbb8fbfkYKwfIrysJmxyB7dkFWwFW70N19Zx
	 Yzb3XYbxQQc4H5OkiZxu9BIOJU3khMQZs9KF/6SM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D165F805F7; Wed, 18 Mar 2026 12:47:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F4DDF805F4;
	Wed, 18 Mar 2026 12:47:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6D42F80553; Wed, 18 Mar 2026 12:47:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5338EF8001F
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2026 12:47:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5338EF8001F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189ded07414dbc00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/499@alsa-project.org>
References: <alsa-project/alsa-lib/pr/499@alsa-project.org>
Subject: ucm: fix optional include
Date: Wed, 18 Mar 2026 12:47:26 +0100 (CET)
Message-ID-Hash: NP23MJ2C7F476ZC5XK4HI53HFKJN4IVO
X-Message-ID-Hash: NP23MJ2C7F476ZC5XK4HI53HFKJN4IVO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NP23MJ2C7F476ZC5XK4HI53HFKJN4IVO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #499 was opened from hyx0329:

The path is not an absolute path and can't be used with `access()`. Let's call `uc_mgr_config_load_file()` directly and mask acceptable error numbers. "conf.d in USB-Audio" needs this fix.

A small issue with current solution is verbose error message while it's okay. Example:
```
ALSA lib utils.c:XXX:(uc_mgr_config_load_into) [error.ucm] could not open configuration file /usr/share/alsa/ucm2/USB-Audio/conf.d/abcd-1234.conf
ALSA lib parser.c:XXX:(uc_mgr_config_load_file) [error.ucm] failed to open file /usr/share/alsa/ucm2/USB-Audio/conf.d/abcd-1234.conf: -2
```

Request URL   : https://github.com/alsa-project/alsa-lib/pull/499
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/499.patch
Repository URL: https://github.com/alsa-project/alsa-lib

Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16433E7717D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:30:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA73B398;
	Thu, 12 Dec 2024 00:30:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 162DBF805C1; Thu, 12 Dec 2024 00:30:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2EEAF805C1;
	Thu, 12 Dec 2024 00:30:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BC53F8025A; Thu, 12 Dec 2024 00:30:16 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BFB3EF80246
	for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2024 00:30:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFB3EF80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1733959804207919598-webhooks-bot@alsa-project.org>
References: <1733959804207919598-webhooks-bot@alsa-project.org>
Subject: git clone failure
Message-Id: <20241211233016.6BC53F8025A@alsa1.perex.cz>
Date: Thu, 12 Dec 2024 00:30:16 +0100 (CET)
Message-ID-Hash: 472QBS6ROAYWYO2OX2UATRIMOM7TGUT2
X-Message-ID-Hash: 472QBS6ROAYWYO2OX2UATRIMOM7TGUT2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/472QBS6ROAYWYO2OX2UATRIMOM7TGUT2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress issue #27 was opened from antonio-fr:

Working on embedded project, there's a recipe for a system that uses tinycompress, and points to the alsa-project git server. Unfortunately, tinycompress can't be downloaded, leading the building system unable to make the system image.

```
$ git clone git://git.alsa-project.org/tinycompress.git
Cloning into 'tinycompress'...
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

It worked yesterday, And I can see the project [there in the web interface](https://git.alsa-project.org/?p=tinycompress.git;a=tree). But right now, no luck.

Issue URL     : https://github.com/alsa-project/tinycompress/issues/27
Repository URL: https://github.com/alsa-project/tinycompress

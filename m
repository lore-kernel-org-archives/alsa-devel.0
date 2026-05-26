Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C229ECD6E40
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 21:54:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 080866024F;
	Tue, 26 May 2026 23:53:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 080866024F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779832446;
	bh=7cFQrleQaQjxv0yMerBegE26uuIjV3Bw2CgH6NVlWew=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tX9Ik1/QPElvFqHgyj3bhSYUcC1kzUxtQT9Sob0qIkMkhuxn9icspedhuG8H+w87H
	 f903/xLU5NtVvD2s3l6BzfJlXkG8Pxa+cKbKeAEVUCYTpvLGoQh9bN9ML9q4RGlhLD
	 ByFMwmgR1j6rL+edTkAAukNSlZLI4ZMQlOZQoxUc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 091DEF805E4; Tue, 26 May 2026 23:53:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D0B5F805F4;
	Tue, 26 May 2026 23:53:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24F7DF80217; Tue, 26 May 2026 23:53:26 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E2E03F800D0
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2026 23:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2E03F800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b33c240f23ae00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b33c240f02b000-webhooks-bot@alsa-project.org>
References: <18b33c240f02b000-webhooks-bot@alsa-project.org>
Subject: feature request: do not make hdajackretask hard depend on systemd or
 provide the functionality for openrc/other init systems
Date: Tue, 26 May 2026 23:53:26 +0200 (CEST)
Message-ID-Hash: URQHIX6T7XLS2GDVZ5L4YXTOP5F22TZD
X-Message-ID-Hash: URQHIX6T7XLS2GDVZ5L4YXTOP5F22TZD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/URQHIX6T7XLS2GDVZ5L4YXTOP5F22TZD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools issue #46 was opened from ingenarel:

currently, at the time of writing this, hdajackretask calls systemctl directly
https://github.com/alsa-project/alsa-tools/blob/d444519df40d52de3903513a14085a0619f688db/hdajackretask/apply-changes.c#L137

which makes it not work on non systemd systems, for example openrc, which i'm currently using

with systemd's recent controversies with age verification and everything, more and more users are trying out alternative init systems and using non systemd systems in a day to day basis, but hdajackretask does not work on that

for the fix, i have an idea:
hdajackretask could try to detect what init system is running, and it could then run the appropriate commands, if it's unable to detect the init system, or fail to run the commands, it could then open a prompt saying:

```
unable to (detect the init system OR run command OR basically wtv happend)
please run these commands or their equivalent manually
systemctl systemctlstuff
```

if hdajackretask needs to do more stuff afterwards, the prompt can just wait after the user clicks "done" or something, and then it could continue doing the rest of the stuff

if upstream decides to do this functionality, then they could also add the logic for openrc/other init systems or anything whenever they want, without breaking the rest of the stuff

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/46
Repository URL: https://github.com/alsa-project/alsa-tools

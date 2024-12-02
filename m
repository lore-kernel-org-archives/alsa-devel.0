Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F3BD7830C
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:19:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D705216B7;
	Mon,  2 Dec 2024 12:18:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D705216B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733138340;
	bh=tOP/FhlFrI39DLHqiRTei6E3UPOXkLsOvH/yBUHggT4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Aa5106eR1i408gI8zD/4uyVgKRqpO4fbqYvoUx5hFtMCWVaMRBkQUA8JUgvUkzHE4
	 FAt8ACqlUWkyKG9xcMgg02f/W6qLK2MG+t60EffvQkRlpJvOanVUYMkLHR5RkNluyf
	 sL/pOguarl4FCK5lzeTq5cewc19aGx6tge2jgIws=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 754D5F805BD; Mon,  2 Dec 2024 12:18:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 32AF0F805C0;
	Mon,  2 Dec 2024 12:18:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87297F80272; Mon,  2 Dec 2024 12:18:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id D323AF8003C
	for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2024 12:18:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D323AF8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1733138294057207108-webhooks-bot@alsa-project.org>
References: <1733138294057207108-webhooks-bot@alsa-project.org>
Subject: No microphone USB audio Behringer UMC204HD ALSA update
Message-Id: <20241202111818.87297F80272@alsa1.perex.cz>
Date: Mon,  2 Dec 2024 12:18:18 +0100 (CET)
Message-ID-Hash: NRAG2VOER6Y3W4FIFFVWDURYIVLRH6QW
X-Message-ID-Hash: NRAG2VOER6Y3W4FIFFVWDURYIVLRH6QW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NRAG2VOER6Y3W4FIFFVWDURYIVLRH6QW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #479 was opened from emiltoacs:

No input on my Behringer UMC204HD because of an update in the following packages on Arch Linux alsa-card-profiles,alsa-lib,alsa-ucm-conf,alsa-utils,lib32-alsa-lib

alsa-card-profiles 1:1.2.6-1 -> 1:1.2.7-1
alsa-lib 1.2.12-1 -> 1.2.13-1
alsa-ucm-conf 1.2.12-1 -> 1.2.13-2
alsa-utils 1.2.12-1 -> 1.2.13-2
lib32-alsa-lib 1.2.12-1 -> 1.2.13-1

The error messages related by pipewire :

pw.node: (alsa_output.pci-0000_00_1f.3.stereo-fallback-57) graph xrun not-triggered (0 suppressed)
pw.node: (alsa_output.pci-0000_00_1f.3.stereo-fallback-57) xrun state:0x7ba2cfaed008 pending:6/6 s:0 a:0 f:0 waiting:0 process:0 status:triggered
pw.node: (alsa_output.pci-0000_00_1f.3.stereo-fallback-57) graph xrun not-triggered (4 suppressed)
pw.node: (alsa_output.pci-0000_00_1f.3.stereo-fallback-57) xrun state:0x7ba2cfaed008 pending:1/1 s:2663559587040 a:2663559606728 f:2663559630434 waiting:19688 process:23706 status:triggered
pw.node: (alsa_output.pci-0000_00_1f.3.stereo-fallback-57) graph xrun not-triggered (0 suppressed)
pw.node: (alsa_output.pci-0000_00_1f.3.stereo-fallback-57) xrun state:0x7ba2cfaed008 pending:1/1 s:5553029600968 a:5553029610813 f:5553029623757 waiting:9845 process:12944 status:triggered

If I revert package the package to these version it works again :

alsa-card-profiles-1:1.2.6-1-x86_64.pkg.tar.zst alsa-lib-1.2.12-1-x86_64.pkg.tar.zst lib32-alsa-lib-1.2.12-1-x86_64.pkg.tar.zst alsa-utils-1.2.12-1-x86_64.pkg.tar.zst alsa-ucm-conf-1.2.12-1-any.pkg.tar.zst 

In the meantime I add
: --ignore alsa-card-profiles,alsa-lib,alsa-ucm-conf,alsa-utils,lib32-alsa-lib
to my pacman update.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/479
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

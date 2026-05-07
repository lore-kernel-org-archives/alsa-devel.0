Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44DBCD3427
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2026 09:25:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6E63601D0;
	Thu,  7 May 2026 11:24:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6E63601D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778145893;
	bh=+KN5sNzr6REyPaLlmYZrH8167Wjf74+90yqJlZkuRWE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=U0EGAAhdov5gGMpV5QV3e8SYDUoFeBNKZ6g+p4cVGxwbFzxkg1r+jm+bFxxc17Ub2
	 SMWUjZ5karYYiANSqkJNTMpF3GIpkgY2dsnitCREX7eUQV6Ry9MpHbEKO85gMH+7G2
	 yXI8T9z6zOPFaTX9d+8ox3UF9BiaVBU0Un2foCNU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89AA2F805EB; Thu,  7 May 2026 11:24:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AAD23F8007E;
	Thu,  7 May 2026 11:24:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4520BF80518; Thu,  7 May 2026 11:24:11 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6486CF800FE
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 11:24:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6486CF800FE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ad3e3a859ed600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/757@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/757@alsa-project.org>
Subject: Add support for ASUS Pro ET900N G3 front panel audio
Date: Thu,  7 May 2026 11:24:11 +0200 (CEST)
Message-ID-Hash: 3SKTYWLCVISX66UMR7T4AGRHTXOHLAQA
X-Message-ID-Hash: 3SKTYWLCVISX66UMR7T4AGRHTXOHLAQA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3SKTYWLCVISX66UMR7T4AGRHTXOHLAQA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #757 was opened from Kenny4-Lin:

This PR adds UCM configuration support for ASUS Pro ET900N G3 - Station GB300 :
- Front panel line out
- Front panel mic in
- Rear line in
[diff.txt.zip](https://github.com/user-attachments/files/27473431/diff.txt.zip)


Tested on local DGX system, all inputs/outputs working correctly.

Signed-off-by: Kenny4 <Kenny4_Lin@asus.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/757
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/757.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

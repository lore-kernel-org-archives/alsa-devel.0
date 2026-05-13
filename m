Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE3FCD343F
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 01:34:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E545E601D4;
	Wed, 13 May 2026 03:33:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E545E601D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778636050;
	bh=SWcYI+McbxAfQgPMR+2fxomhOJWQJIsj62gWJShvw6k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DDXJGzWw49H0dGLP/aFlMi9YXWyUxJ53JgTjJfrnDISsazCviiySc/sfR9ylXg6qE
	 ygEhhIYFNJTessRznLefpY6/7pH/ynLsq7HacrzpE6RMz3KW89/NYnbYZT8qJaszZf
	 Y/VCXGe/GduZaJLSRDCdhI50oWukWmo3Xzz22Xz8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3A49F805EE; Wed, 13 May 2026 03:33:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 85B43F805EC;
	Wed, 13 May 2026 03:33:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A05DF8049C; Wed, 13 May 2026 03:33:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5ED8FF8001F
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2026 03:33:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5ED8FF8001F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18aefc0687ed1800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/757@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/757@alsa-project.org>
Subject: Add support for ASUS Pro ET900N G3 front panel audio
Date: Wed, 13 May 2026 03:33:30 +0200 (CEST)
Message-ID-Hash: BBJQR5S3PMJQ77ZTGZBJR3ZLJMMT23B3
X-Message-ID-Hash: BBJQR5S3PMJQ77ZTGZBJR3ZLJMMT23B3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BBJQR5S3PMJQ77ZTGZBJR3ZLJMMT23B3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #757 was edited from Kenny4-Lin:

This PR adds UCM configuration support for ASUS Pro ET900N G3 - Station GB300 :
- Front panel line out
- Front panel mic in
- Rear line in


Tested on local DGX system, all inputs/outputs working correctly.

Signed-off-by: Kenny4 <Kenny4_Lin@asus.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/757
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/757.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

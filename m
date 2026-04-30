Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68D7FF8875
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:37:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2685A601F9;
	Thu, 30 Apr 2026 13:37:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2685A601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777549031;
	bh=LOQhUEF5eMHSFmhCzbYmRpLZkBUdy1787ddKKbfb6Ds=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=m0HRnF7Dg3c01FarY5vAXR2kLkWxdPhrrHqEb6m0uXTuGnG1VwC+P6funsP1j+U4o
	 eKO68d99Bwtj4MlLQXd61maffd+mv+C/k+gqRiBNz++VAuyIAgYidwOmzTVsFOyMJp
	 rKTZG+tGD5LkHinlAoh+CkZPsTXpN36SY0yLw8kk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C0C4F805F4; Thu, 30 Apr 2026 13:36:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D6D34F805F4;
	Thu, 30 Apr 2026 13:36:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7EAEF802BE; Thu, 30 Apr 2026 13:36:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 72F1CF800B5
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2026 13:36:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72F1CF800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ab1f62874aaa00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/756@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/756@alsa-project.org>
Subject: Sound over Display support for Microsoft Windows Dev Kit 2023
 (Blackrock)
Date: Thu, 30 Apr 2026 13:36:27 +0200 (CEST)
Message-ID-Hash: FU5KNRSLLPLE2NHZ26ZAQPI4VJGC756R
X-Message-ID-Hash: FU5KNRSLLPLE2NHZ26ZAQPI4VJGC756R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FU5KNRSLLPLE2NHZ26ZAQPI4VJGC756R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #756 was edited from jglathe:

Introduce a device profile for the Microsoft Windows Dev Kit 2023. It has a miniDP out and 2 Type-C connectors capable of DP Altmode, and no other (easily) accessible othe audion input/outputs. To use it you also need the corresponding topology, will be a [PR in audioreach-topology](https://github.com/jglathe/audioreach-topology/tree/jg/blackrock).
I also tried to integrate it with the existing Lenovo Thinkpad X13s profile to get automatic detection (works here).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/756
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/756.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

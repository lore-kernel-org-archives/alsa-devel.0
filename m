Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAB2C83F1A
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jul 2025 16:05:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10A7F601F4;
	Sun, 20 Jul 2025 18:05:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10A7F601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1753027529;
	bh=qQLDhwjNH2hGrFWnIM6NDC2uVisVCLXPFoqOAbY6Ld8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bIDZDeLZ8AoKxMbU4dOStwmR9b8rEz7vs+plG+Texoe/jfdjjYEmHdt+QoOky5IYY
	 gkyq5XXq3Z07uGyFTDTN/pH3dRD/SAruV4X0rRe3EacfLZrhHAk36ds6ETdWfOvceX
	 C5BDJ3YApnMT2dBF3FcdcQ9+FaalFRd2TA0MBx1k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98CC7F805D7; Sun, 20 Jul 2025 18:04:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73196F805C8;
	Sun, 20 Jul 2025 18:04:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD006F80185; Sun, 20 Jul 2025 18:04:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 15650F80087
	for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2025 18:04:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15650F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18540135198af000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/596@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/596@alsa-project.org>
Subject: Rename qcs6490-rb3gen2 and qcs9075-iq-evk ucm2 conf
Date: Sun, 20 Jul 2025 18:04:44 +0200 (CEST)
Message-ID-Hash: MGRUC5LGUYGZWI3N5AJLQOJKIO7ZSVPQ
X-Message-ID-Hash: MGRUC5LGUYGZWI3N5AJLQOJKIO7ZSVPQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MGRUC5LGUYGZWI3N5AJLQOJKIO7ZSVPQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #596 was opened from mohsRafi:

Rename the ucm2 conf for Qualcomm qcs6490-rb3gen2 and qcs9075-iq-evk

qcs6490-rb3gen2-snd-card.conf -> QCS6490-RB3Gen2.conf
qcs9075-iq-evk-snd-card.conf -> QCS9075-IQ-EVK.conf

Removed snd-card tags from conf files

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/596
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/596.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

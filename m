Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BCCD1D89F
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:51:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 233C360201;
	Thu,  4 Dec 2025 10:50:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 233C360201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764841859;
	bh=OkIKM80QkQiR9Kiomb4jbV8lLGJpWdkc66yGfOG9DDk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cGdaWSq3C1mbOULOtpjCLqiSPQMfhu7xuf2pA9RL2W6au2EuVCF5nF1Fi5G2H8yZg
	 SlF94LygnDOn4uXE384ofhcHFDkt8yBJLjvM4h/JA5pMtM9BMYBLUKnsh/aykt4ywl
	 xjRAzsTwd36YdGuZnatz26QT1MgYC2SHs7inGdyY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B823AF80269; Thu,  4 Dec 2025 10:50:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65DCCF805D4;
	Thu,  4 Dec 2025 10:50:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2632F80542; Thu,  4 Dec 2025 10:50:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 43F7AF8007E
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2025 10:50:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43F7AF8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187dfa48a87e6900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/644@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/644@alsa-project.org>
Subject: ucm2: sof-soundwire: Update cs42l45 configurations
Date: Thu,  4 Dec 2025 10:50:20 +0100 (CET)
Message-ID-Hash: 5PF4AJLNZDD7AF6SAILSDP66FESSK4W4
X-Message-ID-Hash: 5PF4AJLNZDD7AF6SAILSDP66FESSK4W4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5PF4AJLNZDD7AF6SAILSDP66FESSK4W4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #644 was edited from mstrozek:

Update JackControls to follow machine driver changes [1]

[1] https://github.com/thesofproject/linux/pull/5590

Keeping this PR as a draft until the SOF PR is finalized and merged

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/644
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/644.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

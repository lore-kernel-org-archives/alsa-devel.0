Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DA1C5B549
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:29:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 509A7601F5;
	Thu,  5 Jun 2025 00:28:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 509A7601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749076140;
	bh=nwR3SY420CSFWxytJqxHhIY+CmjmAk8dCBg0Wmdb0FA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=paTmPioZs+Ifglpl40RQ0BqvWLj2GSUYQpmZYzC21uSHKpeTatLVYqn+T2lb8jmz7
	 BGl/AhkHwmmFsKriYK5sxBfLX2W+WoyjbSsMtXlaNdmYHwEGRLlBgN8fr9QMiJFRNU
	 BiW21H5wL60rnwJUEv9Evu+YdpO5sr8Rc0+qKxmE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FF51F805C6; Thu,  5 Jun 2025 00:28:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 80541F800C1;
	Thu,  5 Jun 2025 00:28:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 165DDF80154; Thu,  5 Jun 2025 00:28:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 52F14F8011B
	for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2025 00:28:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52F14F8011B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1845f771475c7e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/572@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/572@alsa-project.org>
Subject: Changed 'Stream Mix' channel names to match the latest Window release
Date: Thu,  5 Jun 2025 00:28:19 +0200 (CEST)
Message-ID-Hash: SDU6HCU7TJNSAO3XO24Z2KRJREVODLCA
X-Message-ID-Hash: SDU6HCU7TJNSAO3XO24Z2KRJREVODLCA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SDU6HCU7TJNSAO3XO24Z2KRJREVODLCA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #572 was opened from FrostyCoolSlug:

This change is to match the Broadcast Mix channel names to the latest release of the GoXLR App on Windows.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/572
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/572.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

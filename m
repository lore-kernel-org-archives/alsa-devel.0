Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912DBC369B2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:03:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97DD06F91D;
	Thu, 17 Apr 2025 11:03:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97DD06F91D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1744880607;
	bh=kx5FELDxViBv8VkGoBA9AebZFuHs+YuL9VN+YnYM7Xo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=MPczUpH03T4aZQ3lAViMdR2TtthPPLOu9WVFqxlXSvGuwx/19Umv+75bInUVHRSlt
	 f0in0Tb6uVZiB7WU2CYF20wSoishHeXoGhgXdTKby0Phj3xFH6IplhCV0DaiiprCuO
	 12vbubw1L3F08OxTa6Es0Y+VB25D1JZnDoTRDXiY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF03AF805CA; Thu, 17 Apr 2025 11:02:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D525EF805C6;
	Thu, 17 Apr 2025 11:02:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26EB6F8052D; Thu, 17 Apr 2025 11:02:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C33EF80073
	for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2025 11:02:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C33EF80073
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18370f9ca6181000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/549@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/549@alsa-project.org>
Subject: ucm2: MediaTek: mt8395-evk: Add support for SOF
Date: Thu, 17 Apr 2025 11:02:39 +0200 (CEST)
Message-ID-Hash: 4ZTVHZXRXSPJWNLZRIZCN4I56EIYQC3V
X-Message-ID-Hash: 4ZTVHZXRXSPJWNLZRIZCN4I56EIYQC3V
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4ZTVHZXRXSPJWNLZRIZCN4I56EIYQC3V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #549 was opened from julien-massot:

Similar to #513, add support for MT8395 with SOF enabled.

We use different playback and capture PCM. Also, split the mixers that are not yet available upstream.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/549
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/549.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

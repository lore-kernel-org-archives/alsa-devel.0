Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26175C87FCA
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:46:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CBD560258;
	Fri, 25 Jul 2025 13:46:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CBD560258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1753443994;
	bh=OzBBt68aYz1kIdlvcERuMb/PPJkcnjkir9+WHjZMuNw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CLx7kujOTBXSe1HAj1IIvZFY9HMn6LKZISei2eY3QG2morjGZXjBRqbHNWtrNn1k/
	 sv8vsc8w52/MGZD+7nL5oMfA/tgo/OzEHSYZNvHzcsypWG3zVi5Dvg7ZLTySTcakGL
	 7TSCEv0vyg55DrWsdfeATia473ImGezqGOyq6lE8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1E48F805C7; Fri, 25 Jul 2025 13:46:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1366DF805C8;
	Fri, 25 Jul 2025 13:46:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E19C8F804FB; Fri, 25 Jul 2025 13:45:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 383CEF8047D
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2025 13:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 383CEF8047D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18557bf40ddb0300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/29@alsa-project.org>
References: <alsa-project/tinycompress/pr/29@alsa-project.org>
Subject: tinycompress: add support for new SNDRV_COMPRESS_TSTAMP64 and
 _AVAIL64
Date: Fri, 25 Jul 2025 13:45:22 +0200 (CEST)
Message-ID-Hash: CHJR3YXDVJNONCPTXH5KKL335YERI3A3
X-Message-ID-Hash: CHJR3YXDVJNONCPTXH5KKL335YERI3A3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CHJR3YXDVJNONCPTXH5KKL335YERI3A3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #29 was opened from jorisverhaegen:

These 2 ioctl are under review to be added to kernel. See https://lore.kernel.org/linux-sound/20250725114249.2086974-1-verhaegen@google.com/T/#t

This pull request should be merged after this kernel is available.

Request URL   : https://github.com/alsa-project/tinycompress/pull/29
Patch URL     : https://github.com/alsa-project/tinycompress/pull/29.patch
Repository URL: https://github.com/alsa-project/tinycompress

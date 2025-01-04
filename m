Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F979E77188
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:58:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9DFB602F1;
	Sat,  4 Jan 2025 09:58:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9DFB602F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1735981105;
	bh=oS6pFT8+mVQjjcPw49cMmhB3vWQPXt68F/hGQfsr0Gs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UbzHVFhY/6HJIWDTMCg2tiN6pLwWw9tKVGEzjJwxIEKiYhhAlrqAQr+q54yCOpJpz
	 kGi0ghdmKLnSa3DuTJRHUg6eeTY+7yxcskHT4rFjg4OkZBKC4gGlnG2IdfDMy8fEnT
	 yV46Uthc+yykoue1xu8JJTpfZ1vhCL9nROoCUhpI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C07EFF80537; Sat,  4 Jan 2025 09:57:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FD53F805BB;
	Sat,  4 Jan 2025 09:57:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88FB2F80269; Sat,  4 Jan 2025 09:57:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 59E97F800EE
	for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2025 09:57:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59E97F800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1735981060487240791-webhooks-bot@alsa-project.org>
References: <1735981060487240791-webhooks-bot@alsa-project.org>
Subject: ucm2: USB-Audio: add Presonus Revelator IO 44 (USB194f:0424)
Message-Id: <20250104085743.88FB2F80269@alsa1.perex.cz>
Date: Sat,  4 Jan 2025 09:57:43 +0100 (CET)
Message-ID-Hash: F6U7PTMRUSSAAB3EDIJLZTDBRUKV2KOC
X-Message-ID-Hash: F6U7PTMRUSSAAB3EDIJLZTDBRUKV2KOC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F6U7PTMRUSSAAB3EDIJLZTDBRUKV2KOC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #495 was edited from markulovi:

[alsa-info.txt](https://github.com/user-attachments/files/18306150/alsa-info.txt)

This adds support for [Presonus Revelator io44](https://eu.presonus.com/products/revelator-io44). This device has 3 virtual stereo channels out and 4 virtual stereo channels in as follows:

![out](https://github.com/user-attachments/assets/f4cacf14-e75e-4d33-ad64-cca4ca7ee18e)
![in](https://github.com/user-attachments/assets/60515091-51a5-4299-97c7-a12d3c091b8a)

Microphone inputs have been separated into two mono channels for convenience.

As far as I can tell, the [Universal Control](https://www.presonus.com/pages/support-documents-downloads?product=revelator-io44) software is required to configure levels and effects of these channels, but the settings can be saved to the device and operation without the software is possible outside Windows.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/495
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/495.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

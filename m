Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257A9FF8860
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:19:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E402D601F6;
	Mon, 27 Apr 2026 17:19:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E402D601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777303162;
	bh=lOFhE/BI82WFXio57aYbGZKJ5/AGfX8bWn+KZ+KvR6g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KoPF+2IHusWhiMQF1SxEV4HvpZXmE3WRmpRv58TSBtvi8CKbt5goXkLS6lVvcokEG
	 /nQ8SQRhRb77sUJwn+Uu++RGTkifKCLr7i+uDS1AsmnNTPFIsQti9nilzZXSa/WGzX
	 qcmNJ2M42G0hMgTLEQKlqH/OsySyKJn6lNsjE7wI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FD25F805F4; Mon, 27 Apr 2026 17:18:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A1F4F805F2;
	Mon, 27 Apr 2026 17:18:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59DA7F80518; Mon, 27 Apr 2026 17:18:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E4B66F80075
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2026 17:18:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4B66F80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18aa3fc58075a400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/755@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/755@alsa-project.org>
Subject: ucm2: Qualcomm: Add HONOR MagicBook Art 14 support
Date: Mon, 27 Apr 2026 17:18:42 +0200 (CEST)
Message-ID-Hash: 3EYLH42LBOGLYODSX42QRPLH35MMYNXL
X-Message-ID-Hash: 3EYLH42LBOGLYODSX42QRPLH35MMYNXL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3EYLH42LBOGLYODSX42QRPLH35MMYNXL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #755 was opened from etehtsea:

Works with the same topology as CRD device.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/755
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/755.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

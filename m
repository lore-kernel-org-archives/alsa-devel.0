Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E493C19776
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2025 19:54:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBFA060315;
	Wed, 26 Feb 2025 20:54:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBFA060315
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1740599694;
	bh=1HbmsZcE9SJcUqdDlRnTEVIkBwx6ONRZsw+8VGx5f3E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GlhGUYSGmER1GjwBnTssRmoNw76KpqfQpoNV32OrQ1H+WZYGnSRIBeZQrlhAGNdHc
	 w3jlrdifsCWqSkKBy6jMzFETrsT3oaZhrkqVtZnbhECKCRJpr33/2gWNeovv9JM3qP
	 DUnXwhLwsXQpLEO/cGN5fTwBz1gC6OHPShXPvZNo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 926F5F805C1; Wed, 26 Feb 2025 20:54:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B7D1F805AE;
	Wed, 26 Feb 2025 20:54:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4EF2AF8016E; Wed, 26 Feb 2025 20:53:19 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 958B4F800E5
	for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2025 20:53:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 958B4F800E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1740599597137050390-webhooks-bot@alsa-project.org>
References: <1740599597137050390-webhooks-bot@alsa-project.org>
Subject: ucm2: Add support for MSI PRO B650-A w/ Realtek ALC4080
Message-Id: <20250226195319.4EF2AF8016E@alsa1.perex.cz>
Date: Wed, 26 Feb 2025 20:53:19 +0100 (CET)
Message-ID-Hash: 7VXL7VLDC3BS6D6XBH7J2ZB6NQO7KQUR
X-Message-ID-Hash: 7VXL7VLDC3BS6D6XBH7J2ZB6NQO7KQUR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7VXL7VLDC3BS6D6XBH7J2ZB6NQO7KQUR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #514 was opened from gbrener:

Gets the front panel audio to work.

[alsa-info.txt](https://github.com/user-attachments/files/18993322/alsa-info.txt)

Thanks in advance.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/514
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/514.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

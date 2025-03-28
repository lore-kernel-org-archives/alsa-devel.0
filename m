Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84999C28B20
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Mar 2025 04:55:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE310601B6;
	Fri, 28 Mar 2025 05:55:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE310601B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743137730;
	bh=WLRIg9w8floHpJK3e1WkXbatssZ6CWf14A6QDyDbKsw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Nb2B/qeIfn+W7CXutw+uihO8EwUFR+CABShUxsxvzbzG85Q/VXqQ9lFhSJVR5L2fP
	 yrlw4Vo3XqFClXcdP7q1BEds2A+2sb9DrCw6H/QHP1+MJQvklhdIZMGNR14F9jI+zJ
	 a4xfVpze4tVx0abztygIBbKWkoqnCTLOEHASpEFE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C8696F805B6; Fri, 28 Mar 2025 05:54:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9101F805B0;
	Fri, 28 Mar 2025 05:54:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 119C9F80548; Fri, 28 Mar 2025 05:54:53 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id ABD1EF800E5
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2025 05:54:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABD1EF800E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1830de7eb9baa600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/537@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/537@alsa-project.org>
Subject: Add UCM2 support for ASUS ROG Strix B850-I Gaming WiFi
Date: Fri, 28 Mar 2025 05:54:53 +0100 (CET)
Message-ID-Hash: DZMBYH3CC3MPY7HH6CFGP2KNCL4WU7MV
X-Message-ID-Hash: DZMBYH3CC3MPY7HH6CFGP2KNCL4WU7MV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DZMBYH3CC3MPY7HH6CFGP2KNCL4WU7MV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #537 was edited from austinthiel:

Referenced [this guide](https://askubuntu.com/a/1469066) to get SPDIF out working on my ASUS B850-I Gaming WiFi

[alsa-info.txt](https://github.com/user-attachments/files/19499096/alsa-info.txt)

In case it's relevant, using a sample rate of 48kHz is required. I found that other sample rate produces very low quality, garbled audio. I read that this is because SPDIF only supports 48kHz in hardware, and any other sample rates require the Realtek drivers.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/537
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/537.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

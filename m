Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6C8C5B552
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:33:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCC97601FA;
	Mon,  9 Jun 2025 17:33:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCC97601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749483206;
	bh=alad9cLOOjV5Y57se8DT1YNvD5Xd1r51sxdPO+aYy/8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Sk8UxanIySY4366zctj9iiJQSz8BrXKrCdR0Eq1xRQriX3OXUV1l0RBiKiUCtVZgp
	 bl4+kiK/2JRC7qTcxiQyvL2rjxh9BsrzHHG9CpxOjFCtkfbLxf7uXefS1xfVVg8h9/
	 km3slRjTalgKXXC3DuENa7oEeLHSNhmtCdEidSFI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8937F805BF; Mon,  9 Jun 2025 17:32:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C8530F805C6;
	Mon,  9 Jun 2025 17:32:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E0E4F8049C; Mon,  9 Jun 2025 17:32:48 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A7D88F801F7
	for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2025 17:32:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7D88F801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184769ababad5b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/576@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/576@alsa-project.org>
Subject: Qualcomm: Add QCS9075-IQ-EVK HiFi config
Date: Mon,  9 Jun 2025 17:32:48 +0200 (CEST)
Message-ID-Hash: JFYNRDKV7L6CXGA3PEUHJHA55K2WEQJF
X-Message-ID-Hash: JFYNRDKV7L6CXGA3PEUHJHA55K2WEQJF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JFYNRDKV7L6CXGA3PEUHJHA55K2WEQJF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #576 was opened from mohsRafi:

Add UCM2 configs for the Qualcomm QCS9075-IQ-EVK Board to handle:
	- I2S Speaker Amplifier
	- I2S Mic

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/576
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/576.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

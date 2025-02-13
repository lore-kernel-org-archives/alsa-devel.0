Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E2DC021A0
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2025 22:48:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BF0D6027E;
	Thu, 13 Feb 2025 23:48:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BF0D6027E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1739486928;
	bh=fs/GUfnAzCduPKxm4zUZmmH9vfnpNKT17fuNxFEDEH8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=MHz7yocziVTLX4udLijRfh63+yTBYCCRxNr+fLpxN2swZ9EGfyuetiAuaBjkkpePg
	 nJ7NXHNF4uyEihSXY8o1vCjt2cAQRkTbAVB5EhKSKRwDwt3+CaLEks1uxpw9i8SaLI
	 xXhc+yWepouD9vrnr8H4eGm8wlrDLB3dm6TDNmj0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 916FDF805BF; Thu, 13 Feb 2025 23:48:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BA9BF805B4;
	Thu, 13 Feb 2025 23:48:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02819F80269; Thu, 13 Feb 2025 23:48:03 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C023F80185
	for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2025 23:47:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C023F80185
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1739486878144608498-webhooks-bot@alsa-project.org>
References: <1739486878144608498-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Add support for RME Fireface UCX II
Message-Id: <20250213224804.02819F80269@alsa1.perex.cz>
Date: Thu, 13 Feb 2025 23:48:03 +0100 (CET)
Message-ID-Hash: KBJMVYFMNZOEVVYNVQY3WAOW2WZKDFKU
X-Message-ID-Hash: KBJMVYFMNZOEVVYNVQY3WAOW2WZKDFKU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KBJMVYFMNZOEVVYNVQY3WAOW2WZKDFKU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #509 was opened from illdefined:

[alsa-info.txt](https://github.com/user-attachments/files/18790978/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/509
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/509.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

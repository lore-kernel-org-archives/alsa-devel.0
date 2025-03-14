Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA9CC282EC
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Mar 2025 15:58:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3978960401;
	Fri, 14 Mar 2025 16:58:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3978960401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741967896;
	bh=hb1rNFcy7x4r+WKETC3Emi8l3CGYOAIQ2Vnq4dZVtkM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ppda3+7fPQ5bEm6VrCDG7corQQIDRM8qoePXw8HWxXp36sIYaa2qNTS56vUlH/vE+
	 2qB5xKBR5JIlRrLzjZ2qRmKoL420QKFtE17tDaSpfzbo1NOyvxSRin0GSeO8NJo/O+
	 2x7EG3u7NvboAYuOVabTrCFRb5umFAaa+sOcHX0g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C6C86F805B0; Fri, 14 Mar 2025 16:57:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C8B0F805B4;
	Fri, 14 Mar 2025 16:57:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 575CAF80424; Fri, 14 Mar 2025 16:57:24 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A2D6BF800FA
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2025 16:57:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2D6BF800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <182cb685f3079a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/522@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/522@alsa-project.org>
Subject: ucm2: Add support for Lenovo Yoga 7x and T14s
Date: Fri, 14 Mar 2025 16:57:24 +0100 (CET)
Message-ID-Hash: NB32PCEAGCSHRBXS2MXF57MAQNFWYLUE
X-Message-ID-Hash: NB32PCEAGCSHRBXS2MXF57MAQNFWYLUE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NB32PCEAGCSHRBXS2MXF57MAQNFWYLUE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #522 was opened from Srinivas-Kandagatla:

This patch series adds support for Lenovo T14s and Yoga Slim 7x based on Qualcomm x1e80100 SoC.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/522
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/522.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

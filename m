Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A75C624C6
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:49:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AB76601C9;
	Mon, 31 Aug 2026 11:49:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AB76601C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788169791;
	bh=1gKDqBaMOcVdIXH7tBV8UgISL/11aofkhdaEzYreyyA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=taWb7rWrjhfMOBd6m2lVinXa1qsWMyUNgai4haLTE53JNSNXxQ3CcKtzuxmPunflR
	 UbH5P01tJFISM/0YlQOI9KvxndJJLY4YgMbuj5bmQVFhAPuErNAW7Z5HkL438ARY/Z
	 agaMx+XV69gvbFIx2NOxQocYjs5W9TbclnpL0PZA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51836F805FF; Mon, 31 Aug 2026 11:49:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BFB8F805F9;
	Mon, 31 Aug 2026 11:49:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12503F8051F; Mon, 31 Aug 2026 11:49:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788169747;
	b=NJelEdxd/7ZeajGuY87QPTueltEzi74T3uBu4ZeJcL1Fa+UdQCpumAXDq9aH3IewDqrY
	 SdoFAtAnsaLcctlaGwRLWok3lNRGDAXLBLPhfaRXKjXTd1Hq6Zw3GDTUNhnQ5PJP70h9J
	 61PwPMQGPklO6M2p5PYx5N2kxkjZi6fte4rMuIztvfM/ecX2UZILZPlp03Mv8YcI/lPYq
	 AAHgSopDx2+oxJAz/8m7X3kFZqQusgwKDV8IBPOqFxgrzhl1DtPnC4OUVjEjaOz+lVq15
	 1+6iXBHW+mK9qvOTy2epmN0Dxkn7xrHcxhiNX5iCYFqK1S9ZXoDlyredRAxOOaZBz5w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788169747;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=1gKDqBaMOcVdIXH7tBV8UgISL/11aofkhdaEzYreyyA=;
	b=DZfwU0w6XN3fygkueMJfZzQFcQzfdbBKcy9RbNhZX+Fm9X8suskhmqKrwGYy+UcJY8Er
	 2AZssvE65wFxAR3U+Pw9pDKDBdcoznUjDBP5FteNwgwwyrH55wrurJoE4GmPK7kyK57xT
	 lMgENk+ICyEd/KE1UemMsf1Ig2+40yNufACeFcR2xmkh8oZlLvBLGUZmT3fYB48UWVkPi
	 oBZPE1jCG5qGilRdcf5JHKzNGf4DP/vngoAUt/ZKNUo91ERSHbxszkx4P3My16PDsL36e
	 CaMwdVV9vlBmtnQUE6OLvFzylqYyRLml/X5rarP1zTS39+2x5yYD0xuH+0E3pNtgpUg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 09B54F800AC
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2026 11:49:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09B54F800AC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d0dae8cbd37d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/845@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/845@alsa-project.org>
Subject: ucm2: Qualcomm: add ASUS Zenbook A16 (UX3607OA)
Date: Mon, 31 Aug 2026 11:49:08 +0200 (CEST)
Message-ID-Hash: HFX3R2VUEVUBE2X7QCIMHHH23EJE6U5M
X-Message-ID-Hash: HFX3R2VUEVUBE2X7QCIMHHH23EJE6U5M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HFX3R2VUEVUBE2X7QCIMHHH23EJE6U5M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #845 was opened from quic-kdybcio:

This Glymur/X2 Elite Extreme laptop features:
- 4 speakers
- 2 DMICs (that notably return a square-ish wave at S16_LE)
- 3 HDMI/DP ports

This patch adds support to Speaker and DMICs for now.

cc @Srinivas-Kandagatla

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/845
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/845.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

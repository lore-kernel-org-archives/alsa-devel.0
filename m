Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F82C369D3
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:58:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BF20851;
	Wed, 25 Sep 2024 13:58:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BF20851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727265496;
	bh=6kOcv89bnTzfo/KKI8y52IZaXlKDmpjBtokQR/8gRjo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rFmfJtopVffU0kS5w6xWogVcOcTrPzj1yqNzQn+8k9HW49SUoo5vXnoUCUVUA/pL+
	 34plsSwqm3tSx20hzb4kh1Excul03dbCRVRTxRxcs1PxvAZ8RmWBZvRfWy2DG/w9l+
	 kPTQMhgc+dZD6PHcwQT8+24p8kGdjAFD8FO8wAVU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7AEB5F805A9; Wed, 25 Sep 2024 13:57:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A4C5F805B3;
	Wed, 25 Sep 2024 13:57:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A969F802DB; Wed, 25 Sep 2024 13:57:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D8A7F80107
	for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2024 13:57:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D8A7F80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1727265456937456369-webhooks-bot@alsa-project.org>
References: <1727265456937456369-webhooks-bot@alsa-project.org>
Subject: Some volume controls are swapped
Message-Id: <20240925115739.6A969F802DB@alsa1.perex.cz>
Date: Wed, 25 Sep 2024 13:57:39 +0200 (CEST)
Message-ID-Hash: HUWHKLW3GAQAD6PE7PG5YLOPX3GDZYT4
X-Message-ID-Hash: HUWHKLW3GAQAD6PE7PG5YLOPX3GDZYT4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HUWHKLW3GAQAD6PE7PG5YLOPX3GDZYT4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #410 was opened from suddenfall:

When using amixer and alsamixer, I noticed that the volume controls for certain channels are reversed. I have verified the problem with two sound cards:

Terratec Aureon XFire8.0HD
hifidom DSC8-MAIN

Both are USB sound cards (UAC2).

Both sound cards have the channel map: FL FR FC LFE RL RR SL SR (cat stream0)

The channels FC/LFE are swapped with RL/RR.

I am using Ubuntu 24.04. The version of libasound2t64 is 1.2.11-1build2.

I am happy to help with troubleshooting.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/410
Repository URL: https://github.com/alsa-project/alsa-lib

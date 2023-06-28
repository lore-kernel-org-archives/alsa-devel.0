Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E07EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jun 2023 11:05:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7928E7F8;
	Wed, 28 Jun 2023 13:04:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7928E7F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687950339;
	bh=vT8w1cOsPrUh+tHlBdJCfxGy6366vg5guwVRJazoxEU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=h0qLBHhNcf/VrBUdxjZwC6H+sCemVyq6kqavSRwQoGqVwM8eYIyOirBv1dbvtDdMc
	 L7MedSBkpMTnfaFBmBIzOLGCSMLgyMCntecUiPKD85zr5r15+PtBZCZnUbfWs0h5+U
	 2CZsNdf6z6s74c3ikivKgxi6oxFVK9QLHevmrYXU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D74ACF80246; Wed, 28 Jun 2023 13:04:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 72DC2F80246;
	Wed, 28 Jun 2023 13:04:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F3698F80246; Wed, 28 Jun 2023 13:04:20 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 44CCCF80169
	for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2023 13:04:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44CCCF80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687950258869607449-webhooks-bot@alsa-project.org>
References: <1687950258869607449-webhooks-bot@alsa-project.org>
Subject: ucm2: USB-Audio: Add support for ALC4080 Gigabyte Z590 AORUS ULTRA
Message-Id: <20230628110420.F3698F80246@alsa1.perex.cz>
Date: Wed, 28 Jun 2023 13:04:20 +0200 (CEST)
Message-ID-Hash: G2AA3SJ3KOA674EEWCORF4HVLSQOGYWQ
X-Message-ID-Hash: G2AA3SJ3KOA674EEWCORF4HVLSQOGYWQ
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G2AA3SJ3KOA674EEWCORF4HVLSQOGYWQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #310 was reopened from BearsPunch:

When installed Manjaro I had an issue my audio card was not recognized. USB ID is 0414:a00d and as I see you already have it under if.realtek-alc1220-vb condition, but I have ALC4080. So I manually changed USB-Audio.conf under If.realtek-alc4080 condition from (0414:a0(0e|1[0124])) to (0414:a0(0[de]|1[0124])) and now it works perfectly.

But Ubuntu (maybe from 22.04) doesn't have this issue. Does Canonical update alsa-ucm-conf by themselves without pull request to main branch?

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/310
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/310.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

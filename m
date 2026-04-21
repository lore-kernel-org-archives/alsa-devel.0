Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0205F8FA6E
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A67E601F2;
	Tue, 21 Apr 2026 14:24:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A67E601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776774300;
	bh=xgZclkK45jtwLF/kJz1I9yckL+AQZsEiFRimJXjEz3c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=puNIT2pk3GPfZ7oaW3tsf8ftWLOcnLM2qeHugVRIjD4wk6amyk9EZkk1Hw2/wVcaR
	 uNfPIzGD/RgCSlY9Q5LPTtgmledyS7ShYwqBddCNcNST6Gt+r+m5HDM5K1JjknYA70
	 bdoW98CT9244AMihzu8dMC8CPNCAYKhBNXUVDIUA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EAF9CF805EC; Tue, 21 Apr 2026 14:24:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ECDF5F805EB;
	Tue, 21 Apr 2026 14:24:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEA6BF8055A; Tue, 21 Apr 2026 14:24:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BC887F800AE
	for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2026 14:24:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC887F800AE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a85ec533685200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/751@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/751@alsa-project.org>
Subject: ucm2: add Arduino VENTUNO support
Date: Tue, 21 Apr 2026 14:24:16 +0200 (CEST)
Message-ID-Hash: PYFIFU6Y4TMFSRRKKVCY5DYUKUMG6HXT
X-Message-ID-Hash: PYFIFU6Y4TMFSRRKKVCY5DYUKUMG6HXT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PYFIFU6Y4TMFSRRKKVCY5DYUKUMG6HXT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #751 was opened from Srinivas-Kandagatla:

Arduino VENTUNO has 1xHDMI, 1xDP, Headset(Mic and speakers), LineOut and EarOut connectors.

Add support for everything except DP, as it is not fully enabled yet.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/751
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/751.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

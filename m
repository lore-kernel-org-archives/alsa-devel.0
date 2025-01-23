Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A1CC02182
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2025 12:38:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0A1D602DD;
	Thu, 23 Jan 2025 13:38:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0A1D602DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1737635934;
	bh=+NZyFBX86N91jliQjAJsKSrKQC3XeYcSeA0KPqZdVKY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KsGvynaUK8d3w4Qf4dS9VsdJea2rV+2+iqhvNbN+t9+h9D1PZphyOZjtdo+VB9PyU
	 ZEuUzf/MV05wqyzRlib+/StzraqwNqckI+YF2q/dq07vqnCRehKVpfr8fTJJkGvctB
	 JS+ktFC0QAMpetqdLR2S67dRxHFX+vMJI5pBEuuA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04DE3F805C0; Thu, 23 Jan 2025 13:38:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BDF07F805BD;
	Thu, 23 Jan 2025 13:38:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0CB4CF80217; Thu, 23 Jan 2025 13:37:47 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8618EF800FE
	for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2025 13:37:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8618EF800FE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1737635839619709730-webhooks-bot@alsa-project.org>
References: <1737635839619709730-webhooks-bot@alsa-project.org>
Subject: ucm2: Intel: avs: Add UCM files for HDA configuration
Message-Id: <20250123123748.0CB4CF80217@alsa1.perex.cz>
Date: Thu, 23 Jan 2025 13:37:47 +0100 (CET)
Message-ID-Hash: QUVVRI7GRPUFSLQS2MHUPFB4JCWJCOAC
X-Message-ID-Hash: QUVVRI7GRPUFSLQS2MHUPFB4JCWJCOAC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QUVVRI7GRPUFSLQS2MHUPFB4JCWJCOAC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #499 was opened from amadeuszslawinski-intel:

Add configs for devices using HDA codec.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/499
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/499.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

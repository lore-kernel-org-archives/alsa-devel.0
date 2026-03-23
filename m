Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C833F4610C
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:21:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B6F7601F6;
	Mon, 23 Mar 2026 14:21:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B6F7601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774272114;
	bh=2qoGYUwATeKcGDL9T4Oh85gUIMubdxxJtd7d3rvhXp0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=E3NpJuXoatg7m/wfPpuDVcpFYcAdRg1o4OMXwrAzCG4kKGmMIWw1VaDwEE2p6D/2Y
	 8voojRm87k5rVPuHypD5jsG3pxbwtM21f6eQj9liAZxewPOKK6DhheOPdafZ9uE+j3
	 Vm7clRwTO4J857BGvsO1DS0C8AObdA9mbJwMpsF0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D19B3F805E8; Mon, 23 Mar 2026 14:21:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CEEAF805F4;
	Mon, 23 Mar 2026 14:21:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D81CDF80496; Mon, 23 Mar 2026 14:21:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D8EDF8014C
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2026 14:21:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D8EDF8014C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189f7b0b699c3800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/732@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/732@alsa-project.org>
Subject: ucm2: sof-soundwire: Add ACP DMIC configuration
Date: Mon, 23 Mar 2026 14:21:09 +0100 (CET)
Message-ID-Hash: 2V5NTUZXAI7CWOQ6ZNCCDFI2SKJ6S4GJ
X-Message-ID-Hash: 2V5NTUZXAI7CWOQ6ZNCCDFI2SKJ6S4GJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2V5NTUZXAI7CWOQ6ZNCCDFI2SKJ6S4GJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #732 was opened from ChaitanyaKrishna001:

Add acp-dmic.conf to the sof-soundwire configuration tree to enable the ACP digital microphone (DMIC) endpoint for AMD SoundWire platforms.

Signed-off-by: Chaitanya Krishna.J <chj@amd.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/732
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/732.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

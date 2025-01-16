Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DECC02180
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:30:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2AEF60367;
	Thu, 16 Jan 2025 09:30:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2AEF60367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1737016227;
	bh=lmQ8RsGRlX/DFHBdL3J1rJtgMDdIP3afri0nyBklsj4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=p9wxoctHNrFU+n24R5JqdLNEmsUtDdIPvd0iiUHF/ZBdBKbMsqFS5EIKSli/4nRLt
	 ewo7yCds7R9jY2mmkipiRSbThWIz2rE/eZ/JTuAIbT8kb27lGyl9tLiSoqPhxI1vc6
	 +Ab8ZSybdBwv5A7rFQf3tvcHV/nDZJZCZFH3FDbw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17A0FF80579; Thu, 16 Jan 2025 09:30:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DD2BF805AE;
	Thu, 16 Jan 2025 09:30:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7399F8045D; Thu, 16 Jan 2025 09:28:44 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BFD3F8012B
	for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2025 09:28:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BFD3F8012B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1737016121873947382-webhooks-bot@alsa-project.org>
References: <1737016121873947382-webhooks-bot@alsa-project.org>
Subject: Topology: NHLT: Intel: Fix DMA slots config in SSP blob
Message-Id: <20250116082844.C7399F8045D@alsa1.perex.cz>
Date: Thu, 16 Jan 2025 09:28:44 +0100 (CET)
Message-ID-Hash: SEUWPUCZ56JSCITDWBQWIJWULJJHQNIP
X-Message-ID-Hash: SEUWPUCZ56JSCITDWBQWIJWULJJHQNIP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SEUWPUCZ56JSCITDWBQWIJWULJJHQNIP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #289 was opened from singalsu:

This fixes a mistake in function ssp_calculate_intern_v30(). The rx_dir[0] and tx_dir[0] value was hard-coded to 0x3 for typical stereo slots configuration. It should be instead retrieved from topology parameters for the SSP.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/289
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/289.patch
Repository URL: https://github.com/alsa-project/alsa-utils

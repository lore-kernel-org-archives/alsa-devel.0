Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638E5E668A0
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Nov 2024 04:09:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A09B0868;
	Sun, 24 Nov 2024 05:09:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A09B0868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732421360;
	bh=GRXYGaDcHZ74zrGSior+GKmoM2hFkhEFGDCNsWDtxRE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Wn1AqaiuKxIVixB0FMSRo02R7AtgcNC5dwoKa2j2I6btqX8zzWra43tqv1brGaPBW
	 WbyTeMN1Gg9akAAKEGDq+saV1m1lDKTPnM7tspu/R9R9d+OJHGMK8AIs8DhcKEhns8
	 XOZwN3fWVRRyPFQsB3TgxWEuqhaJNtsNpMzbhRZI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34496F805C0; Sun, 24 Nov 2024 05:08:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E21AFF805C3;
	Sun, 24 Nov 2024 05:08:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E454F80496; Sun, 24 Nov 2024 05:08:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 60906F8019B
	for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2024 05:08:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60906F8019B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732421316651742458-webhooks-bot@alsa-project.org>
References: <1732421316651742458-webhooks-bot@alsa-project.org>
Subject: Configuration for Roland BridgeCastX
Message-Id: <20241124040839.1E454F80496@alsa1.perex.cz>
Date: Sun, 24 Nov 2024 05:08:39 +0100 (CET)
Message-ID-Hash: Z7CYXJVRKNNTE3S2ITLOB7ASB2PEGHA7
X-Message-ID-Hash: Z7CYXJVRKNNTE3S2ITLOB7ASB2PEGHA7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z7CYXJVRKNNTE3S2ITLOB7ASB2PEGHA7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #469 was opened from Konna1337:

Added Configuration for the X version of Bridge Cast. Config is based on the non X version but it's wired differently and has two more Hardware Channels. It's for the 2.0 Firmware of the Device. The "Game" channel has a virtual 5.1 mode which doesn't work properly and isn't configured.  

- Added condition to USB-Audio.conf
- Added BridgeCastXV2.conf
- Added BridgeCastXV2-Hifi.conf with configuration for channels

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/469
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/469.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

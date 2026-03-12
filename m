Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D697E105A589
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:37:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 760F560206;
	Thu, 12 Mar 2026 12:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 760F560206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773315426;
	bh=ZazxlkZW2uQE+moqjO8oD23IEWDv7pRwJ9+0Y8m3hp4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UQOaEe7x04VKfeOZ03MJPfBM1007Uj7aD5W68YS6bx5HXuk5Mma3S/Aj7INj+N7H5
	 zWF0Lv3bnPhuipPdnqbcMaPfGulQqTh99ONZQYzKwGSB7LbCi8gWxDFl1mAAyGCBrC
	 xkFVauGhsl+lYQCD2l4hfKY87DG4Yt+ePDDRf19c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51A00F805F4; Thu, 12 Mar 2026 12:36:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C589F805ED;
	Thu, 12 Mar 2026 12:36:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C942F8045D; Thu, 12 Mar 2026 12:36:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B78F9F8016E
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2026 12:36:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B78F9F8016E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189c14f123ab3600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/34@alsa-project.org>
References: <alsa-project/tinycompress/pr/34@alsa-project.org>
Subject: fcplay: Decode the AAC header to set correct codec->format value
Date: Thu, 12 Mar 2026 12:36:21 +0100 (CET)
Message-ID-Hash: 3LPQGLAZHWNDRXDKK3R2ICRIES756LYL
X-Message-ID-Hash: 3LPQGLAZHWNDRXDKK3R2ICRIES756LYL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3LPQGLAZHWNDRXDKK3R2ICRIES756LYL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #34 was opened from ujfalusi:

Set the codec->format for AAC based on the information from the header.

Request URL   : https://github.com/alsa-project/tinycompress/pull/34
Patch URL     : https://github.com/alsa-project/tinycompress/pull/34.patch
Repository URL: https://github.com/alsa-project/tinycompress

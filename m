Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019CDC28B20
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Mar 2025 03:37:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BD0E601F9;
	Sun, 30 Mar 2025 05:37:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BD0E601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743305838;
	bh=zNTn1craRJyUWO2kZa4/yRbygKyaNzqdiXa968B6PSA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=oFlEhe7Q+4M5vHQPLY3zQRdpbL90ADGXHUiYxh88CwIjc1Xl5GFh9gaJvYcQYurri
	 WHM1dxlSxBzciKH1AUTm6MQd7sI/DJJWkcYBPgnqJk2/Wj34IgDktNLruCVtEEDxaG
	 i1RFPiwfxYDUiymmIqHrAV7r4/mVzJkpPE5VHwgg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9797EF805C4; Sun, 30 Mar 2025 05:36:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53C14F805C1;
	Sun, 30 Mar 2025 05:36:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6F95F802DB; Sun, 30 Mar 2025 05:36:38 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A2F59F8001D
	for <alsa-devel@alsa-project.org>; Sun, 30 Mar 2025 05:36:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2F59F8001D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <183177629c84a400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/538@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/538@alsa-project.org>
Subject: USB-Audio: Add Focusrite Scarlett 18i20 Lineup
Date: Sun, 30 Mar 2025 05:36:38 +0200 (CEST)
Message-ID-Hash: YKG5EIXAFM6FM4FJZO6EVEFH5B7EWJZM
X-Message-ID-Hash: YKG5EIXAFM6FM4FJZO6EVEFH5B7EWJZM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YKG5EIXAFM6FM4FJZO6EVEFH5B7EWJZM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #538 was edited from ScarletRav3n:

Other solutions exist to add full mixing and routing with these devices. This PR adds basic functionality in an out-of-the-box style for 1st gen, 2nd gen, 3rd gen, and 4th gen.

I/O includes all XLR, Line, S/PDIF, ADAT, and Headphone ports.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/538
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/538.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

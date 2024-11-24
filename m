Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07563E668B3
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Nov 2024 15:01:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D19B31CE;
	Sun, 24 Nov 2024 16:01:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D19B31CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732460512;
	bh=UPcIqc14T+yKFluMASgh//u8mlYQ/GYTCjQKGvEjL+8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=IlzEWI1RlAuSS/Z/4RdANVSk9ZsZuxSnwj8BgRW30b6oOzUY5/fgCBOsFHWuXi/YM
	 qu4PxOjrN52//JY4PLNXZWrzTgU41IEnd6JKSVciLdRrT4j3hOFsWGM/sVDZqPOQbT
	 9oYXwa5xS9vt40hQUdHIi7wIxoJNd7sbfXY9qETA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6364F805C4; Sun, 24 Nov 2024 16:01:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 945ADF800F0;
	Sun, 24 Nov 2024 16:01:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9347EF80496; Sun, 24 Nov 2024 16:01:17 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DF057F800F0
	for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2024 16:01:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF057F800F0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732460475893038750-webhooks-bot@alsa-project.org>
References: <1732460475893038750-webhooks-bot@alsa-project.org>
Subject: amd-soundwire: add support for AMD generic soundwire legacy machine
 driver
Message-Id: <20241124150117.9347EF80496@alsa1.perex.cz>
Date: Sun, 24 Nov 2024 16:01:17 +0100 (CET)
Message-ID-Hash: GXDLFXGH7FIMPJJD2MBEYWUEPO56XMSB
X-Message-ID-Hash: GXDLFXGH7FIMPJJD2MBEYWUEPO56XMSB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GXDLFXGH7FIMPJJD2MBEYWUEPO56XMSB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #470 was edited from vijendarmukunda:

Add support for AMD generic legacy(No DSP) machine driver for ACP6.3 platform using RT722 codec.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/470
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/470.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

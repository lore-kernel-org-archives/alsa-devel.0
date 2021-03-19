Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2741EC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 11:22:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6946964F6C
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 11:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6946964F6C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49DC6167C;
	Fri, 19 Mar 2021 12:22:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49DC6167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616152972;
	bh=Kv2iofSHdJeiSViwe/cy2WEJnA76tKUhnEqPm1EZUvw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YaR3Zyndv1pkMQ6NNej1h+aQidUhCbaDp2bXCeTJPtZvtar816oqHtcg3H1193InU
	 rA3Y7r4AD86BrXKMHe48qak79F85lk9EE0/KiCXYRfJH4ghFPFiafGG/4dsAsz1KZs
	 RysRFhk5WtbkSBFqJYsvn0mzQRHFNPh/ueMMcgHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6128F800BB;
	Fri, 19 Mar 2021 12:22:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AE43F8021C; Fri, 19 Mar 2021 12:21:59 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3A5F1F800BB
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 12:21:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A5F1F800BB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1616152904419620037-webhooks-bot@alsa-project.org>
References: <1616152904419620037-webhooks-bot@alsa-project.org>
Subject: aplay: avoid any further PCM writing if in abort
Message-Id: <20210319112159.9AE43F8021C@alsa1.perex.cz>
Date: Fri, 19 Mar 2021 12:21:59 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils pull request #81 was opened from aditpape:

Terminating stream with CTRL-C will set in_aborting flag which is used to leave any
write/read loop on the ALSA device.
After ending the read/write loop aplay tries to drain the stream which is not required and can also lead to malfunctions:
-If user interrupts a blocked/non responsive PCM (e.g. usb uac2 gadget which does not consume data
due to stream stopped by host) it will successfully terminate the write loop but will hang again in drain call.
This would require to hit CTRL-C again to unblock which should be avoided.
Aplay currently anyhow allows signal handler to get invoked only once.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/81
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/81.patch
Repository URL: https://github.com/alsa-project/alsa-utils

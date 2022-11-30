Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504F6C4321E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Nov 2022 18:41:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A19CD847;
	Wed, 30 Nov 2022 19:40:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A19CD847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669833692;
	bh=LWlQdBp9ut0y1ASX5HIqU1NUKq9IOgjnwgaX0/3cjJg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NvC3jXb38XTwysQ52i83SdK8o9zpZBZsJqar5mzjK8/5HK6L6TzVecE2tEivcr1cu
	 nMK/My6lqqbe7jtm3Oc3wjnsbTsHIRewWPD77K/Wwp3pUcr2oCAt3jF/syzPHZt0mW
	 eQ8xVxYFV5yDKL4tl/HQq+I3ZAqxJfc2/kpTLFD4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B215F8016B;
	Wed, 30 Nov 2022 19:40:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5912EF8023A; Wed, 30 Nov 2022 19:40:40 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2F24BF800B6
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2022 19:40:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F24BF800B6
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1669833635670357943-webhooks-bot@alsa-project.org>
References: <1669833635670357943-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Update quirk for Aorus Pro WiFi Rev 1.2
Message-Id: <20221130184040.5912EF8023A@alsa1.perex.cz>
Date: Wed, 30 Nov 2022 19:40:40 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #245 was opened from 13r0ck:

An improvement for https://github.com/alsa-project/alsa-ucm-conf/pull/157

The line in was using the wrong device.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/245
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/245.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

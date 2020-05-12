Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E29BC47255
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 02:47:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA98D2070B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 02:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aGbhzgzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA98D2070B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E8DC86E;
	Tue, 12 May 2020 04:46:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E8DC86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589251664;
	bh=34PwPS99VyIcK9A2bm9xpOcGNPOKgDbIhynMS4v5Wls=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aGbhzgzoMYM+JHzpRH/h2NsoEACPdaKJ5tbq5lD0V8fRTUdBUY9iFgEO/9y2azskJ
	 JcNwUgaGixSOimr1BGE37IS+ONuamyFgbDXp+SEmD3Ju0LnCxWCT/7TsqTPxA5OiAx
	 jO90qvRfcnGpRmnuFjEhNN/7ASeXt6K5vA9LLYv4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 509A5F800AA;
	Tue, 12 May 2020 04:46:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4683BF8014C; Tue, 12 May 2020 04:44:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 704D6F800AA
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 04:44:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 704D6F800AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1589251439118243933-webhooks-bot@alsa-project.org>
References: <1589251439118243933-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: seq: user_client: remove useless argument of
 delete_port()
Message-Id: <20200512024424.4683BF8014C@alsa1.perex.cz>
Date: Tue, 12 May 2020 04:44:24 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #21 was opened from takaswie:

In implementation of ALSA sequencer core, the port owned by client can
be deleted by userspace applications which opens the client, therefore
it's necessary and sufficient to have an argument just for the numerical
ID of port.

This commit removes the useless argument for port information.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/21
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/21.patch
Repository URL: https://github.com/alsa-project/alsa-gobject

Return-Path: <SRS0=tU6Y=FV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E98C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 05:54:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4785923715
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 05:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4785923715
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9551E174B;
	Thu, 17 Dec 2020 06:53:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9551E174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608184479;
	bh=X1lAuwdu/k+Fg5OURdEhAdRVG9yW6qHylXydz6deaEI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CinJ4Q3Yf9/IQlcv64gYCHFO2PguzqIAa6wDUhtR2f8V1aflhTQdwOx3DgXcLIYTA
	 lK7B/9Os+ouM+tq3Eiiu1pisN4Teza9QEhQneNFod3zV57TmisNPKddKsgRnHIxmtm
	 td+A+hLw1ooTNMm7/NV0bj3wr1zy37KZ+dkQoLfY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6B73F80259;
	Thu, 17 Dec 2020 06:53:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44912F80260; Thu, 17 Dec 2020 06:53:46 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B080DF80148
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 06:53:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B080DF80148
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1608184420233531952-webhooks-bot@alsa-project.org>
References: <1608184420233531952-webhooks-bot@alsa-project.org>
Subject: chtrt5645: Enable Internal MIC of ECS EF20EA
Message-Id: <20201217055346.44912F80260@alsa1.perex.cz>
Date: Thu, 17 Dec 2020 06:53:46 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #68 was edited from starnight:

* Add a card long name "Standard-EF20EA-1.0" match chtrt5645 enabling the internal DMIC.
* Create HdmiLpeAudio folder and copy & modify HDMI.conf from HDA-Intel for the devices using HdmiLpeAudio as the HDMI audio driver.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/68
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/68.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

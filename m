Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB46C2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 10:02:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA98611BE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 10:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA98611BE
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 641B51787;
	Mon, 14 Jun 2021 12:01:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 641B51787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623664955;
	bh=Q3nSpBvxFYjvfzZDAZtA4/mxERsrKMdOoe96jGDmHRE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AZrbdBmh0jrJVyWrPaqtHN/BTwkiXLqPT6NoSsyiCEUFuT/klNHKaBPl4I94T/7np
	 mWCmxu+e/JkLgQ6m+lVtA2BUROI2+BBbyM9DDc739sklJuvUy3ENzlzl4ucxwsmLuq
	 RE0RywwOAG7rTn+R2+9UJ0caQJu1cXalDvXVF2bs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04EFEF80234;
	Mon, 14 Jun 2021 12:01:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2627F8023C; Mon, 14 Jun 2021 12:01:43 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 88BBAF8021C
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 12:01:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88BBAF8021C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623664900589035034-webhooks-bot@alsa-project.org>
References: <1623664900589035034-webhooks-bot@alsa-project.org>
Subject: added an option to aseqnet to optionally set the midi process name
Message-Id: <20210614100143.E2627F8023C@alsa1.perex.cz>
Date: Mon, 14 Jun 2021 12:01:43 +0200 (CEST)
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

alsa-project/alsa-utils pull request #95 was reopened from BrainDamage:

This option allows to run multiple instances of aseqnet without having
to double check the assigned port number, since each one can get spawned
with a unique name.

The patch is pretty minimal and clean, thopefully here shouldn't be troubles 
merging it.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/95
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/95.patch
Repository URL: https://github.com/alsa-project/alsa-utils

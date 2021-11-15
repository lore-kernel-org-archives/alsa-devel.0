Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A28C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 11:37:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E1261C32
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 11:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6E1261C32
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 881641678;
	Mon, 15 Nov 2021 12:36:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 881641678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636976219;
	bh=Lhny+3mPB2WTivHDBs6zvB2MPhP8F2BbpuZmUCNU4Ew=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FIDhRG15BIC6Rh3AAJiU9zC994nULI+wVlw6616SeUBMUISENE/JXDQFK304+k1L9
	 9VpaPeThprv55ea3ZsWvPXbcVRHHf2zyU8YuaI0goenwtR3+8lRHBAMK8NxORDbQga
	 T96yOHhK1WwXt9IZtHWuyrVC8titW0cxKrufDB4U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1BF3F801D5;
	Mon, 15 Nov 2021 12:36:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 716AFF8027D; Mon, 15 Nov 2021 12:36:07 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C47D9F800FA
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 12:36:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C47D9F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636976161880198956-webhooks-bot@alsa-project.org>
References: <1636976161880198956-webhooks-bot@alsa-project.org>
Subject: hw: add "min_rate" and "max_rate" as alternatives to single "rate"
 parameter
Message-Id: <20211115113607.716AFF8027D@alsa1.perex.cz>
Date: Mon, 15 Nov 2021 12:36:07 +0100 (CET)
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

alsa-project/alsa-lib pull request #191 was opened from bku-sue:

Our typical use case is to limit the rate to between 44100 and 48000, as with these boundaries the resampling becomes easier, than if only allowing 48000.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/191
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/191.patch
Repository URL: https://github.com/alsa-project/alsa-lib

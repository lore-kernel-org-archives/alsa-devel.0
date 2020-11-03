Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C14CC2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:56:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF83B2222B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XGv/dxuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF83B2222B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3699B17DA;
	Tue,  3 Nov 2020 08:55:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3699B17DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604390199;
	bh=mfBNPfCjTCtLY+sGmJzVsF1b351LfRyVB2LJeeHV5cE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGv/dxuwjY1bv4aybpdEV/lcgcOuULAEIZoQW7rW+ipVtFO2So+99LyajHz9sicIX
	 qFLJpsQZLzz3LQ+tp2zTrO/zHVh/m/MV5ZlJAsw7QmK13pDdPJZbZr3iesBAUxFJNv
	 b3lrxzEdzvQx8tms4auKWFDheFZj3PRT5MJAIhwM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03CC3F80162;
	Tue,  3 Nov 2020 08:46:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09A6AF805C3; Tue,  3 Nov 2020 08:46:44 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 91367F80162
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 08:46:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91367F80162
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1604389595738744020-webhooks-bot@alsa-project.org>
References: <1604389595738744020-webhooks-bot@alsa-project.org>
Subject: ucm2:sof-soundwire: Add Support For Dell Privacy Mic Mute LED Control
Message-Id: <20201103074645.09A6AF805C3@alsa1.perex.cz>
Date: Tue,  3 Nov 2020 08:46:44 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #59 was opened from GoPerry:

Dell is going to add internal microphone mute led control for Dell privacy system,
which has hardware level protection for audio privacy, when mic mute
state is changed, the ucm2 will help to switch the Mic Mute LED state.

This solution has been discussed by this FR.
https://github.com/thesofproject/linux/issues/2496

This system EC which support audio privacy needs get ACK event when the LED state need to change.
I add one new mixer for RT715 (local mics) to switch the mic mute led state
So the UCM2 will help to call the mixer to notify the LED state is changed.
The led trigger driver will emit the notification to EC through the  LED driver.
Then LED state controlled by the EC will be changed accordingly.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/59
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

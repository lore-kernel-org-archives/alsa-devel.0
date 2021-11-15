Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983CFC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 03:48:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CB961BA4
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 03:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92CB961BA4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B63915E5;
	Mon, 15 Nov 2021 04:47:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B63915E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636948107;
	bh=HXaBUPSf6ntAqSd5NrL/BPmTtovl2kGSlx7FbhmaHkk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CCV6UD0DRV3n2ETp8d460hJRqfd+8Hto5swnGlrH9XAcUpz+R1Mzo+ZMUQSoz+SmF
	 QG1whSfs/Ubb6a5Zm4u7YyGXmiOY4AVBrOE8wyk3wkYGMZRjXWg0MdK5B4422IwpXk
	 jC83hTgb+zTQYx2gLMqwKj3xI+1R6kshOnbMrWp4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88713F801D5;
	Mon, 15 Nov 2021 04:47:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A111F8027D; Mon, 15 Nov 2021 04:47:33 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 81F59F80134
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 04:47:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81F59F80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636948042887592077-webhooks-bot@alsa-project.org>
References: <1636948042887592077-webhooks-bot@alsa-project.org>
Subject: ucm2: Add UCM support for Dell Desktop
Message-Id: <20211115034733.3A111F8027D@alsa1.perex.cz>
Date: Mon, 15 Nov 2021 04:47:33 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #120 was opened from shumingfan:

The Dell Desktop uses two USB audio codecs as front and rear panel.
The front UAC has two outputs of speaker/headphone and one input of headset mic.
The rear UAC has one output of line-out.

Signed-off-by: Shuming Fan <shumingf@realtek.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/120
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/120.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

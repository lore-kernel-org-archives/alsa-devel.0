Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EB1C32796
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Aug 2022 16:00:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F5E4210;
	Wed, 24 Aug 2022 17:59:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F5E4210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661356848;
	bh=1HbFsllxRonjLurPdyEjWHTHLNbPdx5oVKLhIyF9D/A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rjpoAKza88hiVA8yGm205WZKQk95Xzfztg4c9wFmjbMIJUGBXKHBviL6SEHNJ+yG8
	 CaN/RrFvxaEqtiOKywkC98H3WUEa6fUyX8vhuZB/7q2cefCeeRLLX0psw5gb1OZxqI
	 jJo0D4z3U7agKWIJMzNjCbedaCpuai+HJ/9+ct7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10119F8014E;
	Wed, 24 Aug 2022 17:59:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33380F8014E; Wed, 24 Aug 2022 17:59:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 06288F8014B
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2022 17:59:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06288F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661356790538121939-webhooks-bot@alsa-project.org>
References: <1661356790538121939-webhooks-bot@alsa-project.org>
Subject: Have I got a missing ucm files problem ?
Message-Id: <20220824155957.33380F8014E@alsa1.perex.cz>
Date: Wed, 24 Aug 2022 17:59:57 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #204 was opened from xevilstar:

Hello,

this is my alsa-info
http://alsa-project.org/db/?f=cc1f9ff2eb1e223ebf6024aa1605db1d737ff5fa

I am having problems with callaudiod not finding the headset and mic on my audio cards and one of the members on the callaudiod git suggested me I am missing some ucm files ....

This is a raspberrypi4

can you please help me ?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/204
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

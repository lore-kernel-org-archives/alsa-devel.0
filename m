Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E570C433F5
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Apr 2022 16:49:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D04CD822;
	Sat, 30 Apr 2022 18:49:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D04CD822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651337395;
	bh=pwEFNKYa9qUYH9FGl9E2WGLdyTWMtCNZ+8Lq58htxe4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+KW61j2wnmuxtb/vf/ldKJiycEmVdaqFbEKxtRjE/LM0iFudJA01YGhC6Cb1lm7I
	 4tfCl7rp3NxWM+EWymm07v/A+sjcTgfbRHcnuevKfGUfzbLUvklaDKP/S4UBna6p82
	 jbEA1d+++i3DfhttICVmoD94nXJu7FEBxQDKz1QA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 818C5F80128;
	Sat, 30 Apr 2022 18:49:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32B80F8012A; Sat, 30 Apr 2022 18:49:04 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DD94AF80125
 for <alsa-devel@alsa-project.org>; Sat, 30 Apr 2022 18:48:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD94AF80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1651337337514448881-webhooks-bot@alsa-project.org>
References: <1651337337514448881-webhooks-bot@alsa-project.org>
Subject: how can i swich between sound card without reboot in archlinux
Message-Id: <20220430164904.32B80F8012A@alsa1.perex.cz>
Date: Sat, 30 Apr 2022 18:49:04 +0200 (CEST)
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

alsa-project/alsa-utils issue #144 was edited from EN-KS:

I use riverwm and kitty. Currently there is no sound output when i try to plugin a usb 2.4G wireless headset in and then use alsamixer F6 to select the usb sound card unless I leave the usb adapter on the machine and reboot. the usb sound card was detected tho, Is this what it suppose to be? or any procedure that I missed?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/144
Repository URL: https://github.com/alsa-project/alsa-utils

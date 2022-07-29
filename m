Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A77C00144
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jul 2022 06:21:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C5611655;
	Fri, 29 Jul 2022 08:20:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C5611655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659075678;
	bh=FIHNyEexut1uiDgP2WCRuuPdogj72O9cEl987lOFcQ8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G23ea+u/HN3uB11lbqJp0jTBkEOXNHQwE+KHXBVwAJfwgY2G32h7nbCXzE7lrNUtg
	 PJtL6Q93BOlvAsUj3z2MKqyhHzEhpkT0wScnh64eWZ58m3cxjCtN4Xk7pbKt6fWe3J
	 ANTQClIxpWeThRG6dpyKnMpV6wE4Bv67QfyIuurk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2742F8015B;
	Fri, 29 Jul 2022 08:20:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BD10F8049C; Fri, 29 Jul 2022 08:20:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 03B64F8015B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2022 08:20:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03B64F8015B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1659075616578162909-webhooks-bot@alsa-project.org>
References: <1659075616578162909-webhooks-bot@alsa-project.org>
Subject: HDA ATI HDMI not supported
Message-Id: <20220729062025.6BD10F8049C@alsa1.perex.cz>
Date: Fri, 29 Jul 2022 08:20:25 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #194 was edited from yangxiaohua2009:

I am using the latest ucm2 file and alsalib 

alsainfo [http://alsa-project.org/db/?f=92c58f3a6b72fee05b678386858dbc816d25dbf3](http:)

The `alsaucm reload` command returns error saying:

`ALSA lib parser.c:244:(error_node) UCM is not supported for this HDA model (HDA ATI HDMI at 0xfeb60000 irq 28)`

and the HDMI is not working.

despite the fact that I already added the acpes8336.conf in conf.d and acpes8336 folder.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/194
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

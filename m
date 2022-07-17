Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37098C43334
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jul 2022 04:37:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E37716D1;
	Sun, 17 Jul 2022 06:36:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E37716D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658032665;
	bh=kURSKN3vj0bs8mQ5q4RtKlgSnJ5TH3R0OXRYANcgwTg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dhpcDkUM2kQ0Ui7Q4TpdanJyZdGN00hcALMulNYPlcK0yZMD+OObyKs8tD8P6J8t/
	 ZHrtgQiWJa4H+CAUU5eOIZ5+LUyePUKE0fjr03E605gIPHQ+JTQ+IdaiFOcPY9o3y+
	 +B+xZpB07D+ocVQXAsgf7u7U9onRAUveLUSZhzos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26A42F8012A;
	Sun, 17 Jul 2022 06:36:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0164AF8015B; Sun, 17 Jul 2022 06:36:53 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2A0E6F800CB
 for <alsa-devel@alsa-project.org>; Sun, 17 Jul 2022 06:36:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A0E6F800CB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1658032605648432970-webhooks-bot@alsa-project.org>
References: <1658032605648432970-webhooks-bot@alsa-project.org>
Subject: Audio interface unable to be loaded in 1.2.7.2
Message-Id: <20220717043653.0164AF8015B@alsa1.perex.cz>
Date: Sun, 17 Jul 2022 06:36:53 +0200 (CEST)
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

alsa-project/alsa-lib issue #254 was opened from KevHg:

I upgraded from 1.2.6.1 to 1.2.7.2 and found that pulseaudio no longer detects my Motu M2 interface.

Main error log seems to be:
`module-alsa-card.c: Failed to find a working profile.`
`failed to load module module-alsa-card`

I'm new to debugging Linux issues, let me know what other info I can provide to help out on this topic.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/254
Repository URL: https://github.com/alsa-project/alsa-lib

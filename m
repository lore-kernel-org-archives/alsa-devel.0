Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB20C7EE2C
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Aug 2023 21:45:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4096A844;
	Fri, 25 Aug 2023 23:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4096A844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692999906;
	bh=LCa/vnpmJkJYzj2E/Cvbpg0jsuQESkDG7x4441CW7f4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dhZ7efmq/RbqRYwN3YHC3jOwZGS+2s2S2DEmHZQDqFqB7NmmEZRMC4ns8uVgXla+F
	 yiLVWHIdYEXXU0qXh01/eYlaUYZTxl9NZ2AuCINTstrqdD9wWerehqCKdstwGF+ym6
	 ZLKeZpw9gzvTQyG/fuyUbM5TJHT0SRIzttjBXAlU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CB6FF80158; Fri, 25 Aug 2023 23:43:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 264D6F800F5;
	Fri, 25 Aug 2023 23:43:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6446F800F5; Fri, 25 Aug 2023 23:43:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id E9868F800AE
	for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2023 23:43:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9868F800AE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692999813200426102-webhooks-bot@alsa-project.org>
References: <1692999813200426102-webhooks-bot@alsa-project.org>
Subject: Asus ZenBook UX363EA audio codec ALC294 - Speakers reporting as
 Headphones
Message-Id: <20230825214341.E6446F800F5@alsa1.perex.cz>
Date: Fri, 25 Aug 2023 23:43:41 +0200 (CEST)
Message-ID-Hash: FBIMQ4J5YO3OYZBFKA5SLOKRHOU2CMDL
X-Message-ID-Hash: FBIMQ4J5YO3OYZBFKA5SLOKRHOU2CMDL
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FBIMQ4J5YO3OYZBFKA5SLOKRHOU2CMDL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #343 was opened from SoloRobo:

I have an Asus ZenBook UX363EA audio codec ALC294 and the Speakers report as Headphones.

This laptop does not have a 3.5mm jack, only speakers, and audio is working normally despite the incorrect sink port name.

I've been advised to leave the following:

also-info.sh 
http://alsa-project.org/db/?f=84daae5bf1954aeebdcbd78c52cc1813376e6d66

alsaucm -c hw:0 dump text:
https://pastebin.com/pfYxSbz0

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/343
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

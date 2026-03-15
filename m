Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEF2F3028A
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Mar 2026 21:33:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04F746023D;
	Sun, 15 Mar 2026 22:33:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04F746023D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773610437;
	bh=i9mJHkXsWmC+ApjzzKHVUqaH3EPQA2PckB6ignIwO20=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TpcA+CWbsQhJCd2qvtIaJbDBr3sW/MTVhehJSUJYWrkGnZed3yguzH4Vc7XiGo33u
	 bTNl/tw5Ahh2TWFGe41EyXX5QIB+chbNRGqmoKF+0v3IsxoaAA21Q7hWO6Tt8kX0D7
	 FkUhqx8qqE/su2oTkjhGHDgQyw7BE1pGXaTLdHkE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40DBEF805F3; Sun, 15 Mar 2026 22:33:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1E63F805F3;
	Sun, 15 Mar 2026 22:33:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E88D9F8058C; Sun, 15 Mar 2026 22:33:13 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 54346F80424
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2026 22:33:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54346F80424
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189d21402d04a900-webhooks-bot@alsa-project.org>
In-Reply-To: <189d21402cde0300-webhooks-bot@alsa-project.org>
References: <189d21402cde0300-webhooks-bot@alsa-project.org>
Subject: Support of Yamaha CD-S3000
Date: Sun, 15 Mar 2026 22:33:13 +0100 (CET)
Message-ID-Hash: HFSD332DS2BVEPFB4RXGW3XQLFY6CIGB
X-Message-ID-Hash: HFSD332DS2BVEPFB4RXGW3XQLFY6CIGB
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HFSD332DS2BVEPFB4RXGW3XQLFY6CIGB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #498 was opened from JLColaco:

Hi,
I own a Yamaha CD player CD-S3000 with numerical inputs.
I tried to used it with ALSA and with the default setings and quirks, it works but produces regularly (every 10s to 1mn) a clic.
Since there was no specific quirk for it I tried to map it to an existing quirk for another Yamaha device using the quirk_alias option and it worked! (A suggestion from Kimmo who develops the Daphile music server, https://daphile.com/)
Now I would like to have this quirk integrating the quirks_table.h file.
The alias am using it the following: quirk_alias=0499150d:04991509
it would be great to have it in a further release of the driver.

I am ready to help to achieve this goal.

Many thanks for your work.

Jean-Louis

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/498
Repository URL: https://github.com/alsa-project/alsa-lib

Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B5E1077608
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:50:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B1E6601F3;
	Wed, 18 Mar 2026 19:50:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B1E6601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773859857;
	bh=VxN8vujHDqiHmDdCCdau7e9TpxICWhj3sSa5ryx+fpM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TOJqpW2Jr7NUBy+8L2XcXojbnDulnuiwE8Ix20juE2iPPFOeOC79UTraaOVcIzWuF
	 LcrXQED2e+h9vVgZOK1En7BGoD3ORQuilTW8SU27EVN0uiuWJtlj2/TW0GwhvVWsOb
	 ML+Mv02610T1ycADOm/S40dHxPh6xNUAZEOasj7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08B08F805E8; Wed, 18 Mar 2026 19:50:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B174F805F4;
	Wed, 18 Mar 2026 19:50:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4866F80553; Wed, 18 Mar 2026 19:50:17 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FBE7F800BA
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2026 19:50:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FBE7F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189e0419be451500-webhooks-bot@alsa-project.org>
In-Reply-To: <189e0419be3e3600-webhooks-bot@alsa-project.org>
References: <189e0419be3e3600-webhooks-bot@alsa-project.org>
Subject: Found the quirk for Yamaha CD-S3000
Date: Wed, 18 Mar 2026 19:50:17 +0100 (CET)
Message-ID-Hash: S2LOMPOLTBIEA6OEKUFVCNN2SFLYMKWO
X-Message-ID-Hash: S2LOMPOLTBIEA6OEKUFVCNN2SFLYMKWO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S2LOMPOLTBIEA6OEKUFVCNN2SFLYMKWO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #498 was edited from JLColaco:

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

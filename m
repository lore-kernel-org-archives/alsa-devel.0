Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBA3107760A
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:56:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3A8B601F3;
	Wed, 18 Mar 2026 19:55:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3A8B601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773860158;
	bh=gHchrcK0pV77oLmtm4ZFODBRzdxerl11t3+swchx7vA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OhURIT/ANKEjs+loO7Nj2yNlpdpLzjGP1KnUGtFEj4xmMyN1HKSzMgq5lHrH9BwOh
	 uXg3InAS/UKSmR3tVkBGbx+j0gf560gAuY/DZJUEwvNkqzdqeIgJ/+AqytktuO83O/
	 y1W4Eb732eYXEy8iCsGVQXKiEcSX6BhGmQScI6XQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CCFD9F805F7; Wed, 18 Mar 2026 19:55:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 56EAEF805E4;
	Wed, 18 Mar 2026 19:55:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 264ADF80553; Wed, 18 Mar 2026 19:55:19 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F220EF8001F
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2026 19:55:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F220EF8001F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189e045ffb986200-webhooks-bot@alsa-project.org>
In-Reply-To: <189e045ffb8fe400-webhooks-bot@alsa-project.org>
References: <189e045ffb8fe400-webhooks-bot@alsa-project.org>
Subject: Found the quirk for Yamaha CD-S3000
Date: Wed, 18 Mar 2026 19:55:19 +0100 (CET)
Message-ID-Hash: ORCJOPVFMTYDQBW6W2ETHR26T45ZQVQJ
X-Message-ID-Hash: ORCJOPVFMTYDQBW6W2ETHR26T45ZQVQJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ORCJOPVFMTYDQBW6W2ETHR26T45ZQVQJ/>
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
I tried to used it with ALSA and with the default setings and quirks, it almost work but produces regularly (every 10s to 1mn) a clic.
Since there was no specific quirk for it I tried to map it to an existing one for another Yamaha device with a Steinberg USB interface, using the quirk_alias option and it worked! (A suggestion from Kimmo who develops the Daphile music server, https://daphile.com/)
Now, I would like to integrate this quirk to the quirks_table.h file.
The alias am using it the following: quirk_alias=0499150d:04991509
it would be great to have it in a further release of the driver.

I am ready to help.

Many thanks for your work!

Jean-Louis

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/498
Repository URL: https://github.com/alsa-project/alsa-lib

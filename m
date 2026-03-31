Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2687A10F9303
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 20:51:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A801E601F4;
	Tue, 31 Mar 2026 22:51:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A801E601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774990285;
	bh=a2PqbUqD6xX2XpMEBPeCyryj2UIWe9fXlXt2J/6wq40=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=k4b1o5nKz9it2hBEm6RRVlQDss0/tVajV4Q+pE7gyXKCAnxUjTPKn4wfBukWI+eQM
	 3QWZHrSzOS3TEr5uubUZiyYvdTwFWuvc7sKa9+QoMb/jnqMAbtaqMIA0g2UDV8iR/w
	 Pfzt8+e0inaOCYW8Vzkpy80PQ5b+2djGm3nSJYOg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A255CF805F5; Tue, 31 Mar 2026 22:50:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FA4BF805F2;
	Tue, 31 Mar 2026 22:50:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5ED59F80549; Tue, 31 Mar 2026 22:50:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B6002F80087
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 22:50:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6002F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a20836ae2ea700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/35@alsa-project.org>
References: <alsa-project/tinycompress/pr/35@alsa-project.org>
Subject: Add sofprobeclient binary
Date: Tue, 31 Mar 2026 22:50:42 +0200 (CEST)
Message-ID-Hash: GQJKMJMJ45QUH7CAY6A5RGIVO6A43JW5
X-Message-ID-Hash: GQJKMJMJ45QUH7CAY6A5RGIVO6A43JW5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GQJKMJMJ45QUH7CAY6A5RGIVO6A43JW5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #35 was opened from jsarha:

I was hoping this SOF [1] debug tool could be accepted as part of tinycompress package. The current method of usage [2] is not very convenient and a single binary doing everything would simplify things nicely. And since this method of debugging uses alsa compressed support, I think the most natural place for the tool would be as part of tinycompress repository.

Best regards,
Jyri

[1] https://github.com/thesofproject
[2] https://thesofproject.github.io/latest/developer_guides/debugability/probes/index.html

Request URL   : https://github.com/alsa-project/tinycompress/pull/35
Patch URL     : https://github.com/alsa-project/tinycompress/pull/35.patch
Repository URL: https://github.com/alsa-project/tinycompress

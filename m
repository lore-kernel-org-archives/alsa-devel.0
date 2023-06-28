Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B54EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jun 2023 09:26:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E867083A;
	Wed, 28 Jun 2023 11:25:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E867083A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687944383;
	bh=hNpRYxHvYfwI1Jcz8JPt97ukKD/BpHi1pNJ1dJ2xKmE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=iRKaepNYUFS8g/+zBtoghsI8+GR4kyz+sKKJoaUjZ6mAq641n08n9FZZYuofujSDi
	 plM6DqA79KVVd4swiAv5h+qfFIaJVNNGt9bIHvhrTGWjhivLFuyysnHVjclXyijFYN
	 jNfnB3JwDpe+3SLq03zlVrHmEZRcU2D3c5HOdYfE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29097F80212; Wed, 28 Jun 2023 11:24:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C4858F80535;
	Wed, 28 Jun 2023 11:24:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 466D8F80212; Wed, 28 Jun 2023 11:24:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 19F9AF80535
	for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2023 11:24:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19F9AF80535
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687944284531708479-webhooks-bot@alsa-project.org>
References: <1687944284531708479-webhooks-bot@alsa-project.org>
Subject: ucm2: Qualcomm: sc8280xp: fix device numbers
Message-Id: <20230628092451.466D8F80212@alsa1.perex.cz>
Date: Wed, 28 Jun 2023 11:24:51 +0200 (CEST)
Message-ID-Hash: SWW2R5TMJKFJNOVHZLYQQXHZABVCDY6S
X-Message-ID-Hash: SWW2R5TMJKFJNOVHZLYQQXHZABVCDY6S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SWW2R5TMJKFJNOVHZLYQQXHZABVCDY6S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #331 was opened from Srinivas-Kandagatla:

Due to a bug in the Qualcomm ASoC drivers, we ended up with card device numbers starting at some number that is not dai-link id. This bug is now fixed, so update the ucm files inline with this.

Fixes: https://github.com/alsa-project/alsa-ucm-conf/pull/284

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/331
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/331.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

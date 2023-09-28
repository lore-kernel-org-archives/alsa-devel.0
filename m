Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1724BCE7B10
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Sep 2023 10:13:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62DE9DF0;
	Thu, 28 Sep 2023 12:12:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62DE9DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695895987;
	bh=NUVrMuTERkRUqkLoHkNn/nCAdzFLoMG18ztUkR0CXu8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=jUeDCy1gLSRZK4kLu5fA5FJ3TrIzxV1Wz5GiqfdL4HoPOnPMkiy+wRlrxjHuf6wMz
	 j3bV7VcPMmH1KY5tcP4VTYTXxCg3Ag/dvZT/7uZW6iEI/acJUn9tDQB/prAyaNh0hp
	 RZiHOVGRSbytoDOohoBA5THrLIWfOMeReN5U8F6g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD75DF80558; Thu, 28 Sep 2023 12:11:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A87EF801D5;
	Thu, 28 Sep 2023 12:11:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1502CF801D5; Thu, 28 Sep 2023 12:11:53 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F679F800AE
	for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2023 12:11:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F679F800AE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1695895907421766043-webhooks-bot@alsa-project.org>
References: <1695895907421766043-webhooks-bot@alsa-project.org>
Subject: Gapless support
Message-Id: <20230928101153.1502CF801D5@alsa1.perex.cz>
Date: Thu, 28 Sep 2023 12:11:53 +0200 (CEST)
Message-ID-Hash: 4PXXPOYBXRVHCY3522K5BFPPZYXM3BI6
X-Message-ID-Hash: 4PXXPOYBXRVHCY3522K5BFPPZYXM3BI6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4PXXPOYBXRVHCY3522K5BFPPZYXM3BI6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #24 was opened from mohsRafi:

Gapless playback support with codec profile switching

Request URL   : https://github.com/alsa-project/tinycompress/pull/24
Patch URL     : https://github.com/alsa-project/tinycompress/pull/24.patch
Repository URL: https://github.com/alsa-project/tinycompress

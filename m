Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2786C25B76
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Jun 2024 21:58:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C1C582B;
	Sat,  1 Jun 2024 23:58:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C1C582B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717279133;
	bh=QflTB36cpWOS8QweBxUgteC5eTUXXZAZcFas7ed+6cM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=H53vgdXLhIQZjrkjdFxwTXRlogQx0OS+khAOxPjjOBEZcDeMeJ/cCqtgui8FjnQY7
	 Veqxc35d/I4rmcZR94tLvewb8EoEdRtLhzkUaP0RQZ0RXYda9j5z2xPKc/bHDtL4by
	 xhHHhnliNI5zuZruRm61saGMYhIdHr8TNBsJ+aN8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DBF3BF804FF; Sat,  1 Jun 2024 23:58:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E146F805A8;
	Sat,  1 Jun 2024 23:58:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E0A1F8026D; Sat,  1 Jun 2024 23:55:48 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 09FD2F800BA
	for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2024 23:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09FD2F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1717278939539937019-webhooks-bot@alsa-project.org>
References: <1717278939539937019-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Add support for MOTU Ultralite mk5
Message-Id: <20240601215548.2E0A1F8026D@alsa1.perex.cz>
Date: Sat,  1 Jun 2024 23:55:48 +0200 (CEST)
Message-ID-Hash: 77UYEKTPIH4QBALP6E5CBGYI25BIPQAV
X-Message-ID-Hash: 77UYEKTPIH4QBALP6E5CBGYI25BIPQAV
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/77UYEKTPIH4QBALP6E5CBGYI25BIPQAV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #422 was opened from clement-dufour:

Adds support for the [MOTU Ultralite mk5](https://motu.com/en-us/products/gen5/ultralite-mk5/) soundcard. I named each device after their names on the MOTU Cuemix Control application.

Successfully tested on my hardware, see the [alsa-info.sh output](http://alsa-project.org/db/?f=ca07253279e53fa354820f356f6beb5d2026d23f).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/422
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/422.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

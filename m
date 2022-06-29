Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69A4C43334
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jun 2022 22:27:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DD6D950;
	Thu, 30 Jun 2022 00:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DD6D950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656541638;
	bh=bHtYnRkrWznSysS6wwA2nRQr8yppSplLHnf1C51wc3s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DBsetOaQckAu8c1AWQZ6WxgBfXgyTXSxb5svZJdnxyXy68cjcfAoEbOY05k6Dw1YV
	 utD+O1yEddtaliUP+YYMv3UZ/UsRoXTuABmmB29wlGTx/4whfuHc68w4a+by91gwSL
	 eOpP96ZrQh2apLawi/8XZPlulqRwdn9Zh6FlgCd0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9555DF80158;
	Thu, 30 Jun 2022 00:26:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C166F8020D; Thu, 30 Jun 2022 00:26:26 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E2FBDF80115
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2022 00:26:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2FBDF80115
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656541583091228962-webhooks-bot@alsa-project.org>
References: <1656541583091228962-webhooks-bot@alsa-project.org>
Subject: ucm2: add profile for the Librem 5
Message-Id: <20220629222626.5C166F8020D@alsa1.perex.cz>
Date: Thu, 30 Jun 2022 00:26:26 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #181 was opened from craftyguy:

cc @agx

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/181
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/181.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

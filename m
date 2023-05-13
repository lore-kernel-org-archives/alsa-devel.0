Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511FAC77B7D
	for <alsa-devel@archiver.kernel.org>; Sat, 13 May 2023 10:27:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08E42DEB;
	Sat, 13 May 2023 12:26:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08E42DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683973624;
	bh=9mangd1Pv8j4mhAEG2mcgr3FcAfKWqDx6L7dn6ptZD0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BZ/bCayVe3Lo9r1/u83Ca/zqohRwCmmx9s5cP0IXyh4DdkFm7miNlSHSON/cXDdus
	 SuGI49jHWSxZEgfhGcN8gwElagvWYXrxWn1bWTsmhso4/IputyLSM1oUvoWdPHQhjS
	 aLquDg24HyDglNOylwcSdAgLUq5ZXe82hG6rjzdU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 039ADF80534; Sat, 13 May 2023 12:25:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 868DBF8052E;
	Sat, 13 May 2023 12:25:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9335DF8052E; Sat, 13 May 2023 12:24:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 766B2F802E8
	for <alsa-devel@alsa-project.org>; Sat, 13 May 2023 12:24:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 766B2F802E8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683973467866495371-webhooks-bot@alsa-project.org>
References: <1683973467866495371-webhooks-bot@alsa-project.org>
Subject: Update USB-Audio.conf
Message-Id: <20230513102431.9335DF8052E@alsa1.perex.cz>
Date: Sat, 13 May 2023 12:24:31 +0200 (CEST)
Message-ID-Hash: TWQ5JM3BDLLKYYTVP27W4ZHWGIDOKP7P
X-Message-ID-Hash: TWQ5JM3BDLLKYYTVP27W4ZHWGIDOKP7P
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TWQ5JM3BDLLKYYTVP27W4ZHWGIDOKP7P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #315 was opened from Sunsheep:

Added configuration for ASUS ROG Strix B650E-I Gaming WiFi and ALC4080

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/315
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/315.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

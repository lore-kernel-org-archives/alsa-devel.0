Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1A0C00144
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jul 2022 03:01:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E38E7846;
	Wed, 27 Jul 2022 05:00:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E38E7846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658890877;
	bh=LLJT/MTfrXGm4uqCX4kGhAVBOEmNNmzj/XzmLBLhqKE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h02bfihpVlQYXqgo5gI+N6UzC3X7fsxAnIL5uTNnElT821BqhjMZuC5sUNeNYFEOt
	 dfKZ4RPPUy46eHU7hGWR+QlG4eTn1khH7qh35NAwmnEeo6/nF0BC/fU3tTU3CBhnZ/
	 Jzeq3+lvKcQQ0wHlcS1qZKjuq9+vwIL4MuVTLcuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D90BF80155;
	Wed, 27 Jul 2022 05:00:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC2A5F8015B; Wed, 27 Jul 2022 05:00:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DB9ECF800FA
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2022 05:00:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB9ECF800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1658890813687171936-webhooks-bot@alsa-project.org>
References: <1658890813687171936-webhooks-bot@alsa-project.org>
Subject: HDA ATI HDMI not supported
Message-Id: <20220727030022.EC2A5F8015B@alsa1.perex.cz>
Date: Wed, 27 Jul 2022 05:00:22 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #194 was opened from yangxiaohua2009:

I am using the latest ucm2 file and alsalib 

alsainfo [http://alsa-project.org/db/?f=92c58f3a6b72fee05b678386858dbc816d25dbf3](http:)

 

When nothing is changed, the alsaucm reload command returns error saying:

 

`ALSA lib parser.c:244:(error_node) UCM is not supported for this HDA model (HDA ATI HDMI at 0xfeb60000 irq 28)`

 

and the HDMI is not working.

 

After changing the file /ucm2/HDA/HDA.conf, from 

`Define.AcpCardId "$${find-card:field=name,return=id,regex='^(acp|acp6x)$'}"`

to

`Define.AcpCardId "$${find-card:field=name,return=id,regex='^(acp|acp6x|acpes8336)$'}"`

 

alsucm reload returns no error, but alsaucm listcards returns:

`ALSA lib main.c:1541:(snd_use_case_mgr_open) error: failed to import hw:1 use case configuration -2`

`  0: hw:0`

 `   HDA ATI HDMI at 0xfeb60000 irq 28`

despite the fact that I already added the acpes8336.conf in conf.d and acpes8336 folder.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/194
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

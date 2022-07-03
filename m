Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF2EC433EF
	for <alsa-devel@archiver.kernel.org>; Sun,  3 Jul 2022 17:07:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B6ED16CA;
	Sun,  3 Jul 2022 19:06:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B6ED16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656868056;
	bh=VVvlRSa6N3dUEvz9WqaXxuJmQVH63ZKUm/Tv3bi0Vnw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aCtDavvvzVkqqsD4bSiL1He4BXgQMmh5qnxOGC5fFyaF0E0Qh8MSAG2W1YwAPprAK
	 2GrNF8wSsW8aSuqnZBQSoeOLwCUHGd9foQ8LFiYWaQ+re35RCoQSprPTcCHcfmjlJv
	 Z0PPUKP+/x6f/dbiF3GMxi9MMupiwnsGXjACk0T0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 051D4F8019B;
	Sun,  3 Jul 2022 19:06:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57985F80089; Sun,  3 Jul 2022 19:06:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 15F41F80089
 for <alsa-devel@alsa-project.org>; Sun,  3 Jul 2022 19:06:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15F41F80089
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656868000734338045-webhooks-bot@alsa-project.org>
References: <1656868000734338045-webhooks-bot@alsa-project.org>
Subject: direct.conf fails to work if DirectCardName is not specified
Message-Id: <20220703170644.57985F80089@alsa1.perex.cz>
Date: Sun,  3 Jul 2022 19:06:44 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #183 was opened from brndd:

The following error is produced when a card uses direct.conf but DirectCardName is not specified (with e.g. `Define { DirectCardName "UMC204HD" }`

```
$ spa-acp-tool -c 1 -vvvv info
variable '${var:DirectCardName}' is not defined in this context!
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/183
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319B8C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 09:39:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDEE91689;
	Wed, 16 Nov 2022 10:38:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDEE91689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668591554;
	bh=9Qk+vi5YQVfAOSKjqx2oexb0RXKBk8G1UxGl8Pfi5Os=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i7lzgJ2Q8588xSqNofsSWdOl84hrzhRk5eZ+35nzj60tFoeIZj9tcg4s7pRWZIotK
	 VeAb10Tm7NRBk0aImdwizP/ntRAC/ZbYGqbFfa4LFtoPCgg1DBUQgtbC+6mixeftma
	 nOwSYa8BxXEoXsqLATeJkyEzhCbqcElfZAUuRhbM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80844F80163;
	Wed, 16 Nov 2022 10:38:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82985F80169; Wed, 16 Nov 2022 10:38:23 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7B830F800B8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 10:38:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B830F800B8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1668591496425622940-webhooks-bot@alsa-project.org>
References: <1668591496425622940-webhooks-bot@alsa-project.org>
Subject: ucm2: sof-soundwire: add basic settings for RT1318 SDCA device
Message-Id: <20221116093823.82985F80169@alsa1.perex.cz>
Date: Wed, 16 Nov 2022 10:38:23 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #242 was opened from shumingfan:

Add support for rt1318 amplifier

Signed-off-by: Shuming Fan <shumingf@realtek.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/242
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/242.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

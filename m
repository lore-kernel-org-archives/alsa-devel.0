Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B97C04A68
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jul 2022 20:48:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54E7D164D;
	Wed, 27 Jul 2022 22:47:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54E7D164D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658954909;
	bh=26BEsf9zoPL/MPotDzjR2o7E99sxk+tyu+FlOBmXv3s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCpeEqzDyVPvFX8xRE3nyXNTOi/jLd044pdKViFYedc2bnagzbQ8ECiNhXZoCZI1f
	 T2SE1dCKxV3CvDquMwIWroDZWFxMXGI3FB2bWnxH1nrJ6pmWJFgbLlYBlzG+CoX2fk
	 FSYVgKAlL1zv3pk4cCx/3rchTEWzcA4hVd9Glbvk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C088BF80155;
	Wed, 27 Jul 2022 22:47:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95BBDF800C9; Wed, 27 Jul 2022 22:47:36 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6621BF800C9
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2022 22:47:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6621BF800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1658954849363334894-webhooks-bot@alsa-project.org>
References: <1658954849363334894-webhooks-bot@alsa-project.org>
Subject: snd_soc_skl - No sound on PopOS
Message-Id: <20220727204736.95BBDF800C9@alsa1.perex.cz>
Date: Wed, 27 Jul 2022 22:47:36 +0200 (CEST)
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

alsa-project/alsa-lib issue #255 was opened from runcros:

Hello, I have no sound on skylake nau8825 max98357a here is my alsa-info : http://alsa-project.org/db/?f=c1b90f94c1bb072f507636f3979c0bc8a62ae470
Can you help me please
If you need others infos, I am here =) thank you !

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/255
Repository URL: https://github.com/alsa-project/alsa-lib

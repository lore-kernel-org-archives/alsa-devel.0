Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3B8C32772
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 22:23:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DE9D3E;
	Wed, 24 Aug 2022 00:22:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DE9D3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661293418;
	bh=yKF7M8Le7KpfE+EZexBAtszsnLG7HA/ZxDSoUVaXtsc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lB92OMLKswUWJGpBwxxOLemtODVcSe8DzQdDLlPPznvake1OC6GCOUD0ONh++Pira
	 eV5nBbrDdBHpaOKC+VU8Dwu7QoZw6L7JP37CesBPhXu4xZwA4BXtWB8/E83PMoqMHG
	 uq2f7J9oJpmno0tFXwxO0My8FV21kbTs00ya5GMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAEC7F800C9;
	Wed, 24 Aug 2022 00:22:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82BEFF8020D; Wed, 24 Aug 2022 00:22:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id EFA8DF8014E
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2022 00:22:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFA8DF8014E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661293363487472057-webhooks-bot@alsa-project.org>
References: <1661293363487472057-webhooks-bot@alsa-project.org>
Subject: arcam_av.c: Include missing string.h
Message-Id: <20220823222246.82BEFF8020D@alsa1.perex.cz>
Date: Wed, 24 Aug 2022 00:22:46 +0200 (CEST)
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

alsa-project/alsa-plugins pull request #47 was opened from kraj:

bzero() function needs this header to be included

Signed-off-by: Khem Raj <raj.khem@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/47
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/47.patch
Repository URL: https://github.com/alsa-project/alsa-plugins

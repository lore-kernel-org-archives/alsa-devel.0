Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0C4C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Dec 2021 09:51:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30EC5229E;
	Thu,  9 Dec 2021 10:50:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30EC5229E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639043471;
	bh=WqbLTCmZrlcIu/snn67E8B65KsbAKNAXrkvb05neBYs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jxBEHfTGY4KBpWfOtQ0uuOcEZ89R6ASvvpu6vzIJorgTaNMaMKT+D5tx7ttLbGIav
	 uf9ohGnCXwcxC3JGWjohZHIH7dFck2kHH5Cwu46koAjv899Mmpnp/ONUnpPC0pfpZ9
	 oyL7tG01Z2qI7kyV+OkksdzEQYCOtIwhqt5LCpiA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91F61F802A9;
	Thu,  9 Dec 2021 10:50:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4D1DF800FC; Thu,  9 Dec 2021 10:50:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9C3F5F802A9
 for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2021 10:50:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C3F5F802A9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639043400228790998-webhooks-bot@alsa-project.org>
References: <1639043400228790998-webhooks-bot@alsa-project.org>
Subject: PinePhone Pro support
Message-Id: <20211209095009.C4D1DF800FC@alsa1.perex.cz>
Date: Thu,  9 Dec 2021 10:50:09 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #125 was opened from tomfitzhenry:

It'd be great to have PinePhone Pro support in alsa-ucm-conf. https://gitlab.com/pine64-org/pine64-alsa-ucm/-/issues/4 is another project that tracks this.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/125
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

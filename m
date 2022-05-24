Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCA1C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 24 May 2022 11:48:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41E3416F7;
	Tue, 24 May 2022 13:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41E3416F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653392920;
	bh=PkfOcXRA+tLM3eYM29GdcchAeuFqaIF/shnseoNDkKY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gQ0/KJuNB5L34dVWimyYnZ435cZZMgmSoufIUNPvKMJ1SIzudiIelRua711/gcc1H
	 gdnKaNnEPUusFVF1IW2xtZdK+9GEviHiNaGLJ119ZAVVxjdpzouxJej4xmkLLQnZUX
	 9ksQjLEzQ5E7Xm4MLl4oMVqu7f2OymaB0RC245WI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE475F804CC;
	Tue, 24 May 2022 13:47:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 031F3F804D1; Tue, 24 May 2022 13:47:47 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 63E50F800E3
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2022 13:47:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63E50F800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1653392864710031986-webhooks-bot@alsa-project.org>
References: <1653392864710031986-webhooks-bot@alsa-project.org>
Subject: Fix for arecord recording ghost data
Message-Id: <20220524114748.031F3F804D1@alsa1.perex.cz>
Date: Tue, 24 May 2022 13:47:47 +0200 (CEST)
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

alsa-project/alsa-utils pull request #150 was opened from amadeuszslawinski-intel:

We noticed the issue in our tests, when using arecord would produce files with glitches at recording end.

Apparently it was caused by writing full buffer to output file instead of the data read, when stopping recording.
Following commit adjust the code to only write the amount of data that was read and making sure that file size matches internal format data.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/150
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/150.patch
Repository URL: https://github.com/alsa-project/alsa-utils

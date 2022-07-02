Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECA3C43334
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Jul 2022 00:03:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5218616C3;
	Sat,  2 Jul 2022 02:02:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5218616C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656720211;
	bh=Z9xdRQ7XavuH/EM3ze7Pewxz1oxETAnWFdT1+Rl0gb8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EIjVOYiotrFy7AeDCab8oBcCErAjz59RVbx/njkG24Qbv/NwlOjgb75iG+fCc+uHm
	 ijrmsndxKsUzO/jm3iF60TyVib+pRGj5P+q99NC64Ym/7M6YpERni7Y/8pWIqm4KLt
	 ffMcdq9uO30mOBGMCe4EnSqBSNyacCFEVJAT+xcE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF179F8047C;
	Sat,  2 Jul 2022 02:02:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 104A4F80256; Sat,  2 Jul 2022 02:02:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A44E4F80256
 for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2022 02:02:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A44E4F80256
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656720156241345882-webhooks-bot@alsa-project.org>
References: <1656720156241345882-webhooks-bot@alsa-project.org>
Subject: Crackling on playback - Mackie ProFX6v3
Message-Id: <20220702000239.104A4F80256@alsa1.perex.cz>
Date: Sat,  2 Jul 2022 02:02:39 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #182 was edited from emaxoda:

Hi. I tried to add support for the Mackie ProFX6 and while it technically works (before I was getting one a 4.0 surround profile instead of the two output devices it should show) I get this crackling sound on playback whenever I try to play any sound, the craclking or distortion can be heared alonside whatever is on playback. I tried playing sound with aplay and paplay and got the same craclking noise alongside with the played track. 

[alsa-info](https://github.com/alsa-project/alsa-ucm-conf/files/9032058/profx.txt)

https://github.com/emaxoda/alsa-ucm-conf/commit/51b9b6f1a81ab55e16bba12a370afc518d961550

^ my commit

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/182
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

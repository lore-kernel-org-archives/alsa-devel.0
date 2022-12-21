Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C094DC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Dec 2022 07:05:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AC6E168D;
	Wed, 21 Dec 2022 08:05:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AC6E168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671606352;
	bh=HE28zBRBlt4AGGvCRo7GwdoclPmDBizGGWcoNj0bm7A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bIK0dtWrtcoHBw6c6iJpGIkXdziDqE2R7lyTee5ThKR5E+ZHj1gjjCt/dO6/Mq4Wm
	 brrsK6e7RmWynpvTXvd9ayOv0rZw85ApvaTmN6Kgwofzjico5EJl7cHEYz3qA1+bRN
	 Hl52DHDsg/pJqEb3N9VyODPehgyZZjFooXNDf7WE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B855AF80423;
	Wed, 21 Dec 2022 08:05:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DFBBF801C1; Wed, 21 Dec 2022 08:05:00 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8DA6BF801C1
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2022 08:04:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DA6BF801C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1671606298090306997-webhooks-bot@alsa-project.org>
References: <1671606298090306997-webhooks-bot@alsa-project.org>
Subject: rt715-sdca soundwire micphone record no sound
Message-Id: <20221221070500.4DFBBF801C1@alsa1.perex.cz>
Date: Wed, 21 Dec 2022 08:05:00 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-ucm-conf issue #255 was opened from KaiChuan-Hsieh:

On linux kernel 6.0, with rt715-sdca codec on Dell platform.

The internal mic can't record sound after boot.
Try $ amixer cset name='PGA5.0 5 Master Capture' 1

Then the internal mic can record sound successfully.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/255
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

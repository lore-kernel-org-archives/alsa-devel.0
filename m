Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF3EC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jun 2022 18:01:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46CD41B03;
	Fri, 17 Jun 2022 20:00:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46CD41B03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655488872;
	bh=z/pG4S9fr21RdkJ2IxULjQIIP19NW1RRh+7PbfSoD/I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pcUCzVljfPA8u2t1hlMKhKFAZVpXTxgBchxusBfXu5+oXnUTMZXErcYeXjKGjRQ1Q
	 kOG04/uj1KqrpjhLdO4s2yGgMuB/X+ManYnlljuO+0v+Oo2Fe7fcPS79gTUIHMBL/S
	 T6+fhAE1ADK8e0GlGZ/gzj62lHjtpaYNjorlLlHU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C69C0F8051F;
	Fri, 17 Jun 2022 20:00:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7D4EF80527; Fri, 17 Jun 2022 20:00:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 16E82F8028B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 20:00:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16E82F8028B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1655488816471978903-webhooks-bot@alsa-project.org>
References: <1655488816471978903-webhooks-bot@alsa-project.org>
Subject: No sound on AMD audio device
Message-Id: <20220617180019.A7D4EF80527@alsa1.perex.cz>
Date: Fri, 17 Jun 2022 20:00:19 +0200 (CEST)
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

alsa-project/alsa-lib issue #241 was edited from chvmq:

I have a laptop huawei 14 amd 2021

I don't know where write about it. maybe there

I tried ubuntu 22.01 | arch-linux and no sound at all

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/241
Repository URL: https://github.com/alsa-project/alsa-lib

Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AD0C6FA82
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Sep 2022 16:54:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA296827;
	Tue, 20 Sep 2022 18:54:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA296827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663692891;
	bh=vmAfqG4Q5PoA2oHJe44LVRuaVUCUpeeNFoN2ziFP7DU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BsNxQMQ/piyopAl1Cb/DCvwO8Mwf+IkcLOdXZFbnTAsLU6CyS3L3on8WIJ2YJV2bN
	 A2nStObGPPH0hPIG7v84WH3vZWiqHyZN5GpYBOiDxC8RebwVrOTYuj3+FP3Gbk18t1
	 lIAEGrumIbyqlGjZViOJAWr3evvTngmhh6VXORcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3637AF80153;
	Tue, 20 Sep 2022 18:54:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58579F80155; Tue, 20 Sep 2022 18:53:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D1DC5F800C9
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 18:53:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1DC5F800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1663692832297085047-webhooks-bot@alsa-project.org>
References: <1663692832297085047-webhooks-bot@alsa-project.org>
Subject: ACP6x: UCM not working
Message-Id: <20220920165359.58579F80155@alsa1.perex.cz>
Date: Tue, 20 Sep 2022 18:53:59 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #215 was opened from sebastianst:

My Ryzen 6000 laptop has an AMD audio coprocessor driving the microphone with the ACP6x kernel module. #138 added initial support for this, but me and some other people on different Ryzen 6000 laptops have issues with alsa-ucm not configuring the microphone properly. We have to disable `alsa-ucm` to get any sound input or output working with pulseaudio, see https://bbs.archlinux.org/viewtopic.php?pid=2058087#p2058087 for the relevant discussion. Note that we first had to add our laptops to some quirk table of the kernel module to get it working at all.

Any idea how to fix this?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/215
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

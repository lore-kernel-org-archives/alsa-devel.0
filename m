Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA0EC4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Nov 2022 01:24:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF461843;
	Tue, 15 Nov 2022 02:23:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF461843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668475484;
	bh=CR1OnUhKUjtMNC06SyDQaEr+tBJn8g14imDG79VE8NM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyUTwNlgCJjOiDjkVM8WEhhWO+rE3ZZ6HVpUrZCIriFEpsbVaG3eq0NceCRmUXb53
	 S7NjYQ+Vs1kOigLGLs9egs/HHF8VVeL3a57oF2UqhIJNQPPHFEPnJyK50dv4Csd6Jz
	 NW6ry8eraC9NWAhkm4+M6l4u1m9q91C5O/N7xWkE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6179CF800B8;
	Tue, 15 Nov 2022 02:23:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2735F80431; Tue, 15 Nov 2022 02:23:52 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1C079F800B8
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2022 02:23:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C079F800B8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1668475429302025080-webhooks-bot@alsa-project.org>
References: <1668475429302025080-webhooks-bot@alsa-project.org>
Subject: ucm2: [Digidesign MBox3] Added default SplitPCMPeriodTime and
 reordered
Message-Id: <20221115012352.B2735F80431@alsa1.perex.cz>
Date: Tue, 15 Nov 2022 02:23:52 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #240 was opened from ManuLinares:

Added default SplitPCMPeriodTime of 500 (0.5ms): to solve latency issues https://github.com/alsa-project/alsa-ucm-conf/issues/238
Reordered configs: to make pulseaudio select the correct default card profile, input and ourputs (pavucontrol)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/240
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/240.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf

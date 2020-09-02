Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6036AC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:31:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09D3207EA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CrznifQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09D3207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 628EB171B;
	Wed,  2 Sep 2020 23:30:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 628EB171B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599082306;
	bh=rI5wkWYTb2OnqSAx7wDxN1HqlyIyqCd1r9dV29LRdaY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CrznifQXC+4fKdPlj9u2sv4kg3L2xQACFzk4PjsYvlKF+/DATp2CtOqFchN/dLf4Y
	 Tu7qU0TvszlOlgmAtAU4PZ7uRn/cNoD0+sTYv6FmipKEKOomhsF5wRKTGeRczGeRCa
	 IuI2Rx33Y3zPrGNGj9s8F41LpLALPNDuL4a+RXAU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F07B4F80345;
	Wed,  2 Sep 2020 23:22:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 996BBF802E3; Wed,  2 Sep 2020 23:22:35 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0DEEF802E8
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0DEEF802E8
IronPort-SDR: 7upAJpcGzAQniLVBerFel2ivwMLnX4l6iD5qeejGfndbSrEHlcvLRw1zDytzmmdjqPBDlcwG8E
 2ts0st0ez3aQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482900"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:12 -0700
IronPort-SDR: r1Eir6ecieuVQ3e3dBgjV7d1v69sVsBrD82GHw3RgBfZSOL5PxFd6IiYwNFgjGjhHh8MiYwRZf
 haXcrLJj/YMQ==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798297"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:11 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 17/18] ALSA: vx: vx_pcm: remove redundant assignment
Date: Wed,  2 Sep 2020 16:21:32 -0500
Message-Id: <20200902212133.30964-18-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
References: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix cppcheck warning:

sound/drivers/vx/vx_pcm.c:539:30: style: Variable
'chip->playback_pipes[audio]' is reassigned a value before the old one
has been used. [redundantAssignment]
 chip->playback_pipes[audio] = pipe;
                             ^
sound/drivers/vx/vx_pcm.c:533:31: note: chip->playback_pipes[audio] is
assigned
  chip->playback_pipes[audio] = pipe;
                              ^
sound/drivers/vx/vx_pcm.c:539:30: note: chip->playback_pipes[audio] is
overwritten
 chip->playback_pipes[audio] = pipe;
                             ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/drivers/vx/vx_pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index 664b9efa9a50..47361e26be80 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -530,7 +530,6 @@ static int vx_pcm_playback_open(struct snd_pcm_substream *subs)
 		err = vx_alloc_pipe(chip, 0, audio, 2, &pipe); /* stereo playback */
 		if (err < 0)
 			return err;
-		chip->playback_pipes[audio] = pipe;
 	}
 	/* open for playback */
 	pipe->references++;
-- 
2.25.1


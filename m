Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA40FC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:29:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6184A20767
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dR9lqXER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6184A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F294818A9;
	Wed,  2 Sep 2020 23:28:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F294818A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599082142;
	bh=qN8ir4Vi4bmuW5UvlyqwGEoUoB4xbhn16gj2GNi6rZ8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dR9lqXERCtmG5Wa30V6C91Jw9btdfIihr/5f/wUu5UX/O61mGMqrXzpKmPmNkNTT3
	 MJqwrjhg7xrl9Pjy0fk48dCUSuEkNRkZBjYIBfG2IJyMtsrlSiWmBC9ZL/qvfBhSxl
	 cM01zIeHbdsU/8Q/0epLpvCv4YbXHmfm3X2Uk4vI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A333F80322;
	Wed,  2 Sep 2020 23:22:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F7DBF80307; Wed,  2 Sep 2020 23:22:30 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 043CCF802DB
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 043CCF802DB
IronPort-SDR: WDYnrVjoZ7A9/3W8f9lG4Ptk8XFn8w/CduBhrGif3+DgW4wDuI6Iufb2+L8Vf3Y3g0e+ch5yQx
 nfWWZ4wEp72w==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482870"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482870"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:05 -0700
IronPort-SDR: HDtl1awHtZIfqlFvrUfef2fMgFKyMrXeXtS2Xv0hPQKtFP2V8ihb2bp25K3+dOzd/lTVQL8Xda
 iAdu000wHSmw==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798282"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:05 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 09/18] ALSA: aoa: i2sbus: use DECLARE_COMPLETION_ONSTACK()
 macro
Date: Wed,  2 Sep 2020 16:21:24 -0500
Message-Id: <20200902212133.30964-10-pierre-louis.bossart@linux.intel.com>
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

Follow recommendation in Documentation/scheduler/completion.rst and
use macro to declare local 'struct completion'

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/aoa/soundbus/i2sbus/pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index d350dbd24305..1c8e8131a716 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -254,12 +254,11 @@ static void i2sbus_wait_for_stop(struct i2sbus_dev *i2sdev,
 				 struct pcm_info *pi)
 {
 	unsigned long flags;
-	struct completion done;
+	DECLARE_COMPLETION_ONSTACK(done);
 	long timeout;
 
 	spin_lock_irqsave(&i2sdev->low_lock, flags);
 	if (pi->dbdma_ring.stopping) {
-		init_completion(&done);
 		pi->stop_completion = &done;
 		spin_unlock_irqrestore(&i2sdev->low_lock, flags);
 		timeout = wait_for_completion_timeout(&done, HZ);
-- 
2.25.1


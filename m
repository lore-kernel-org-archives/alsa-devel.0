Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C385AC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:49:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0B02088E
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kEmyTkmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0B02088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE9FE16EC;
	Thu,  2 Jul 2020 21:48:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE9FE16EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593719376;
	bh=nQHnK89O5fo9kVO+zwH9PhkUxYh+mxY1a7Nl287nL5o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kEmyTkmyLJ8iKk31zD3tC/rJCL5vzwQEuxPPzT0hLkhpkim6HwRUoSPn/1/nXXyZK
	 NbbAA+BeKmvdiw3y85itWitKWEYxkX6scOhh+lbEm1PuYPIZiJimw517gV3BPSKi1D
	 B/2XS4R4zswqoi8l9aFsbfcaG/pJZzIO5YAylUbo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E021F8036C;
	Thu,  2 Jul 2020 21:37:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84FC4F80329; Thu,  2 Jul 2020 21:37:03 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56CC4F80307
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:36:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56CC4F80307
IronPort-SDR: b+K4oWdgqxf/X/qF/4GCWPk7mnFw4CbRULHt2GNvetR6aLFO75qI5l+CI7ieZDLtUtR77NPGz7
 I/HGbFY57+iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148549367"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="148549367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:32 -0700
IronPort-SDR: tUk4r7xvv/7PdSxh9715LVh2xxLAJl1wDVQ62HgHC+Ne0ZiY2N+LpixZ+PeIgkzLex2eumPneu
 VIEbUKVvjYyw==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="482116414"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:32 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 22/23] ALSA: vx_core: remove warning for empty loop body
Date: Thu,  2 Jul 2020 14:36:03 -0500
Message-Id: <20200702193604.169059-23-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
References: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warning.

sound/drivers/vx/vx_core.c: In function ‘snd_vx_threaded_irq_handler’:
sound/drivers/vx/vx_core.c:515:3: warning: suggest braces around empty
body in an ‘if’ statement [-Wempty-body]
  515 |   ; /* so far, nothing to do yet */
      |   ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/drivers/vx/vx_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index ffab0400d7fb..26d591fe6a6b 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -511,8 +511,9 @@ irqreturn_t snd_vx_threaded_irq_handler(int irq, void *dev)
 	/* The start on time code conditions are filled (ie the time code
 	 * received by the board is equal to one of those given to it).
 	 */
-	if (events & TIME_CODE_EVENT_PENDING)
+	if (events & TIME_CODE_EVENT_PENDING) {
 		; /* so far, nothing to do yet */
+	}
 
 	/* The frequency has changed on the board (UER mode). */
 	if (events & FREQUENCY_CHANGE_EVENT_PENDING)
-- 
2.25.1


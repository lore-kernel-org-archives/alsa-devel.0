Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5260CA9EB6
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:21:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3B721928
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OQ+hgTn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3B721928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3054884C;
	Wed, 23 Oct 2019 18:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3054884C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571847693;
	bh=JMoicWWCqgeV0h5pRr9jstlfEW6ba6imu7yvznH799Y=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OQ+hgTn8S1asQT/HCZfv6BmZOnYPy9LzrTkbbEZeUk6J6Qfm1ELe4rF1Z5d3+zSYk
	 XD9xz5DTzMWk6JkSC6kupj6Y0vxty8I+ZA2oxNUzGBzCcLJem8G0ZVxhtQqTQNQuph
	 P5tDFpwXjJn0hq58MLuWU5yJhVN40gY1b1aqjsp0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9F39F80321;
	Wed, 23 Oct 2019 18:20:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A41AF80368; Wed, 23 Oct 2019 18:20:40 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0BE6F80112
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 18:20:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0BE6F80112
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 09:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; d="scan'208";a="209951301"
Received: from unknown (HELO vganji-B85M-D3H.iind.intel.com) ([10.223.163.76])
 by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2019 09:20:32 -0700
From: vani.ganji@intel.com
To: alsa-devel@alsa-project.org
Date: Wed, 23 Oct 2019 21:52:35 +0530
Message-Id: <20191023162235.12539-1-vani.ganji@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vani.ganji@intel.com
Subject: [alsa-devel] [PATCH] ASoC: Intel: Reduce Resource notification
	trace to once per minute.
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Vani Ganji <vani.ganji@intel.com>

Resource notification trace "MCPS Budget violation" observed very
frequently which might cause losing critical debug information.
Added a counter to print trace on first instance and once per minute.
It is required to be notified when module resource is used more than
a threshold so enabled once per minute.

Suggested-by: Grant Grundler <grundler@google.com>
Signed-off-by: Vani Ganji <vani.ganji@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 667cdddc289f..03ff0d8cea3e 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -346,6 +346,7 @@ int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
 		struct skl_ipc_header header)
 {
 	struct skl_dev *skl = container_of(ipc, struct skl_dev, ipc);
+	static unsigned long j;
 
 	if (IPC_GLB_NOTIFY_MSG_TYPE(header.primary)) {
 		switch (IPC_GLB_NOTIFY_TYPE(header.primary)) {
@@ -355,12 +356,17 @@ int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
 			break;
 
 		case IPC_GLB_NOTIFY_RESOURCE_EVENT:
-			dev_err(ipc->dev, "MCPS Budget Violation: %x\n",
+			/*Print trace on first instance and for every minute*/
+			if (printk_timed_ratelimit(&j, 60000)) {
+				dev_err(ipc->dev, "MCPS Budget Violation: %x\n",
 						header.primary);
+			}
 			break;
 
 		case IPC_GLB_NOTIFY_FW_READY:
 			skl->boot_complete = true;
+			/* reset timer on every FW load */
+			j = 0;
 			wake_up(&skl->boot_wait);
 			break;
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

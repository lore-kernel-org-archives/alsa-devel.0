Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034BAC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:26:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8697F207DA
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LCy+CZW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8697F207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A2CC16F7;
	Tue, 18 Aug 2020 05:25:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A2CC16F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597721202;
	bh=JqVRZt5qCEsEXnX7cmlYBhujNgBVz4P/6UpxCKa1cLI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCy+CZW8tyW7HYFb6s76ZzrgCeVCxQ/GrvQ50GvsG2WnsYxfyHB8hNQUPAqasI6Rz
	 FFMJ5F8ZCp6JtG2AcyUHqofYuSgm7bfC6Qd53dFFCpbOH7xDthsdMq2E8iyWyV4324
	 AonVuur9n4tOzn/nDVzurfzuAr87bfs8WxNr0WcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F189F802E1;
	Tue, 18 Aug 2020 05:23:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DD27F802A2; Tue, 18 Aug 2020 05:23:34 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91EAFF8023F
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 05:23:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91EAFF8023F
IronPort-SDR: J1MFCYltqZjY/qLQuaoSdNjeweLyoWBL5vBxtW3T352ZNZwCVNwRJajvTIrqC39mrNdPB4a/wf
 W6CYsMf+p3KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152243005"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="152243005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:25 -0700
IronPort-SDR: IUKUFnI+VfHvI/oK/YYda08gAN/iI3qK4UOrhlxMWdHsQQfh/5zBbmT2Q+XrBhVdSEpxnIf4un
 C82uTajiXHCQ==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="441084559"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:21 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 03/12] soundwire: intel: fix race condition on system resume
Date: Mon, 17 Aug 2020 23:29:14 +0800
Message-Id: <20200817152923.3259-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Previous patches took care of the case where the master device is
pm_runtime 'suspended' when a system suspend occurs.

In the case where the master device was not suspended, e.g. if suspend
occurred while streaming audio, Intel validation noticed a race
condition: the pm_runtime suspend may conflict with the enumeration
started by the system resume.

This can be simply fixed by updating the status before exiting system
resume.

GitHub issue: https://github.com/thesofproject/linux/issues/1482
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0e21bae3cd19..00c5de1250ec 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1528,6 +1528,18 @@ static int intel_resume(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * after system resume, the pm_runtime suspend() may kick in
+	 * during the enumeration, before any children device force the
+	 * master device to remain active.  Using pm_runtime_get()
+	 * routines is not really possible, since it'd prevent the
+	 * master from suspending.
+	 * A reasonable compromise is to update the pm_runtime
+	 * counters and delay the pm_runtime suspend by several
+	 * seconds, by when all enumeration should be complete.
+	 */
+	pm_runtime_mark_last_busy(dev);
+
 	return ret;
 }
 
-- 
2.17.1


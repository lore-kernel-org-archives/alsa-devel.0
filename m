Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92020C4708E
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Dec 2022 15:15:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB10F185A;
	Fri,  2 Dec 2022 16:14:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB10F185A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669994141;
	bh=D2sSBZAYc+Vg9KltmJ/1P5cigpDrjdOXDLq9JRG7bY0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aZl8EIRwApqYCwyZBNh+r6RtXK9ZjHMyRDp+RsGoHsA4WV1uSSpYrSSfWOdGsR9d1
	 dQvETviWBYagjoKhwPPKL/YdZS6YSCsJ7XxbnhPc1HfdDvp5+m5ejqoPOjJUO6rKMx
	 +ia4q4sZZFheI++VhvtADzaGT942XKAftOFpk/h0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05D4DF805C8;
	Fri,  2 Dec 2022 16:12:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 577B8F805C9; Fri,  2 Dec 2022 16:12:11 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 476D9F805B2
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2022 16:12:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 476D9F805B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="AItucu/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669993925; x=1701529925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D2sSBZAYc+Vg9KltmJ/1P5cigpDrjdOXDLq9JRG7bY0=;
 b=AItucu/K2XiZOHfS9nfBVqh6GJGMAS15pocjOseMVA0g7uulPtWEnRTi
 RxauMYF4ZtAFlmBkk7u6wOdxtsBEivUequbCfRbTFUa7BP+zGC2w6EI5w
 EhyL9fahqD7CIyPXOP3nrUE3jW/u1YQN9D2YgSrma9WEeTC/3McStC68h
 W4PKufNaN0YwSabxc2TrlmqFM1K7fB+oAz3Zs6PwANWWBFz4urhiBr2Sg
 eZHb/o2smEfeCnshOAZEqk6ipS070gynGZknSpeTVkVBjbDJKQ52GKrmr
 Sy9qImz4KBfi1iQCVJWXodSvVJvNLwiNV8rKeHeaLELODwNRoCEEtH9hM A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="402251840"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; d="scan'208";a="402251840"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2022 07:12:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708504769"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; d="scan'208";a="708504769"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2022 07:12:01 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v2 14/16] ASoC: Intel: avs: Gather remaining logs on
 strace_release()
Date: Fri,  2 Dec 2022 16:28:39 +0100
Message-Id: <20221202152841.672536-15-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202152841.672536-1-cezary.rojewski@intel.com>
References: <20221202152841.672536-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

When user closes the tracer, some logs may still remain in the tail of
the buffer as firmware sends LOG_BUFFER_STATUS notification only when
certain threshold of data is reached. Add whatever is left to already
gathered logs so no information is lost.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/debugfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
index 678572ee6b9d..e7b0b99824aa 100644
--- a/sound/soc/intel/avs/debugfs.c
+++ b/sound/soc/intel/avs/debugfs.c
@@ -201,11 +201,25 @@ static int strace_open(struct inode *inode, struct file *file)
 
 static int strace_release(struct inode *inode, struct file *file)
 {
+	union avs_notify_msg msg = AVS_NOTIFICATION(LOG_BUFFER_STATUS);
 	struct avs_dev *adev = file->private_data;
-	unsigned long flags;
+	unsigned long resource_mask;
+	unsigned long flags, i;
+	u32 num_cores;
+
+	resource_mask = adev->logged_resources;
+	num_cores = adev->hw_cfg.dsp_cores;
 
 	spin_lock_irqsave(&adev->trace_lock, flags);
+
+	/* Gather any remaining logs. */
+	for_each_set_bit(i, &resource_mask, num_cores) {
+		msg.log.core = i;
+		avs_dsp_op(adev, log_buffer_status, &msg);
+	}
+
 	kfifo_free(&adev->trace_fifo);
+
 	spin_unlock_irqrestore(&adev->trace_lock, flags);
 
 	return 0;
-- 
2.25.1


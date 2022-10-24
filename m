Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B821C38A2D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 16:57:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABF547041;
	Mon, 24 Oct 2022 18:56:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABF547041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666630643;
	bh=Cxb94rhXkeUwxfqs3RlTvBKzgcy2PP0M/LmCMDnYOHI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JEridmc4QevChX5/qFPrWR7+pYYVZlW634PkBtwap9dXKA/NgD0FCT+CVi3p5wtZk
	 ASDn2sBAoU+EIyo3L2J7yiq9GAhNkvDNOjSkOfOoIRkwToYc494M9RW4uWQsEnIqo2
	 YT2o5brN/BN8m7+/HRfgVzx3FqUGbxJS/ct00jkQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94378F805B6;
	Mon, 24 Oct 2022 18:53:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADE0DF80580; Mon, 24 Oct 2022 18:53:42 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3779F80533
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 18:53:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3779F80533
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="RjoXyt/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666630416; x=1698166416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cxb94rhXkeUwxfqs3RlTvBKzgcy2PP0M/LmCMDnYOHI=;
 b=RjoXyt/aZzD6jq3+1V4em8kurU5X6P3WF0iFRMRmo8hD0i+Ye21KcQds
 P5qu+iry4p6Ni5WCuaN8RxCFC7P+eu+JEZ3s96vMSUHIDNuYrJquTtCfu
 qbSMeCVpuPGvrvZI0hFAGkYn2eH34Gw6yO16ThNkgyD173Z1u0CoOwfeB
 FcYV79SkKfq8lY9p4HwPQ6unyJMHlMMYPE3HKWi4GJDM56QXIV32zDQ1Z
 IY40I1byHbgYRk7e+m9lL519FtreUJbragZ2t9jvmAsVk0fbXDbPAlmq/
 OdCsR8kl9vpJyasMgwfbk3AMuFWY9nI8R0Xwkuo34TXgxky9d1zQN/9vv Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287868659"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; d="scan'208";a="287868659"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2022 09:53:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609263076"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; d="scan'208";a="609263076"
Received: from tdsilva-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.186.236])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2022 09:53:30 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 12/16] ASoC: SOF: Intel: hda-stream: use SOF helpers for
 consistency
Date: Mon, 24 Oct 2022 11:53:06 -0500
Message-Id: <20221024165310.246183-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024165310.246183-1-pierre-louis.bossart@linux.intel.com>
References: <20221024165310.246183-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Not sure why we mixed sof and hdac helpers, this makes the code way
less readable.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 8cb91788912cb..7ac703515be4a 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -697,7 +697,8 @@ bool hda_dsp_check_stream_irq(struct snd_sof_dev *sdev)
 	/* The function can be called at irq thread, so use spin_lock_irq */
 	spin_lock_irq(&bus->reg_lock);
 
-	status = snd_hdac_chip_readl(bus, INTSTS);
+	status = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTSTS);
+
 	trace_sof_intel_hda_dsp_check_stream_irq(sdev, status);
 
 	/* if Register inaccessible, ignore it.*/
@@ -778,7 +779,7 @@ irqreturn_t hda_dsp_stream_threaded_handler(int irq, void *context)
 	for (i = 0, active = true; i < 10 && active; i++) {
 		spin_lock_irq(&bus->reg_lock);
 
-		status = snd_hdac_chip_readl(bus, INTSTS);
+		status = snd_sof_dsp_read(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTSTS);
 
 		/* check streams */
 		active = hda_dsp_stream_check(bus, status);
-- 
2.34.1


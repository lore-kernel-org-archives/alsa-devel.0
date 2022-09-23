Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F220DC6FA82
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Sep 2022 13:37:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24B3F886;
	Fri, 23 Sep 2022 15:36:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24B3F886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663940260;
	bh=gPpwHxbPRFqh5h7ecA3eLrRwC/kVhAzYYbNSOQ7tHv0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rWNOa9LAn1QwCes0b1Tq6rqj6G6F0g/532oV8tF2AcqGW3uECboBBytA12TAN8jtE
	 5Fmff0Af8HqS5Pkit8O6fIvD+1oKS2h0haQdvOpKGwLJ6Dp8L4dbn2ewoydNi2lQ8e
	 I08WSacrR2XS4CodzmqFjWavTrTD0FzBWCENhyKU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21568F80124;
	Fri, 23 Sep 2022 15:36:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96EF8F80549; Fri, 23 Sep 2022 15:36:24 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62B39F80224
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2022 15:36:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62B39F80224
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Q13bDgRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663940178; x=1695476178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gPpwHxbPRFqh5h7ecA3eLrRwC/kVhAzYYbNSOQ7tHv0=;
 b=Q13bDgRMeJL/YtDngApvMRDBSiQKxxYFQU07CXR5uPd7FevHEeBqtgOe
 xgbl4VkMB6GXdHRy5rZqardtD+jIkb5+hVYFhkS2rVbuoDqNPxQMlhm6J
 OeulshOHgQ46AdDBAc5eIapW0uRqvuDXX/V6sK0BdgHv5B3SRSVjkn8ho
 h+D++uiMAXsxalY1SD9+qPXtxxxvKI4l1A4g2fTGIfBglDOGHprGakqQU
 4eb7gcIWfFVhvSGX0fMMW6ZDzmsWG6k+20khadxOrlnx06nfh6MZibqPA
 SbmOeXcUQZEMVu4C4+kUvdXOVa9/Hn7KWn/x9Fy8xAGYcW5Y5Hcp36fqf g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300575624"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; d="scan'208";a="300575624"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2022 06:36:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; d="scan'208";a="571375304"
Received: from acarr-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.3.209])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2022 06:36:12 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 3/6] ASoC: SOF: Intel: skl: Use the ipc4 version of the
 ipc_dump
Date: Fri, 23 Sep 2022 16:36:13 +0300
Message-Id: <20220923133616.26267-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923133616.26267-1-peter.ujfalusi@linux.intel.com>
References: <20220923133616.26267-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com, rander.wang@intel.com
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

The use of the IPC registers are different between IPC3 and IPC4.
The ipc_dump needs to use different prints depending on the used IPC
protocol.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/sof/intel/skl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/skl.c b/sound/soc/sof/intel/skl.c
index f05905e00368..eba166fe4d33 100644
--- a/sound/soc/sof/intel/skl.c
+++ b/sound/soc/sof/intel/skl.c
@@ -87,7 +87,7 @@ int sof_skl_ops_init(struct snd_sof_dev *sdev)
 	/* debug */
 	sof_skl_ops.debug_map	= skl_dsp_debugfs;
 	sof_skl_ops.debug_map_count	= ARRAY_SIZE(skl_dsp_debugfs);
-	sof_skl_ops.ipc_dump	= hda_ipc_dump;
+	sof_skl_ops.ipc_dump	= hda_ipc4_dump;
 
 	/* firmware run */
 	sof_skl_ops.run = hda_dsp_cl_boot_firmware_skl;
-- 
2.37.3


Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF153C433E6
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:39:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ABE64E77
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ABE64E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB79C1692;
	Tue,  9 Feb 2021 00:38:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB79C1692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827572;
	bh=ylUHfM+zRKkxJBR4BjrDQTB5XbllsFDaQlC7ZHbzgD8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XvRptTBFi7HGPputGejUKzuuoW2Xddiqxfsh9oJ+sP2akjm/zOd/VzYtU7No8Efz8
	 oDz1BvVfCuIQMpz9NjURk0zYwCODyKJQwGxF7Dprwt66u6ysquN5yXV4DzVjoE7uzv
	 lWLBtQOAOfqer6IfKanJ/Bmz1+vWWomghuQ+A0SU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8528F804E4;
	Tue,  9 Feb 2021 00:34:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6353EF804DF; Tue,  9 Feb 2021 00:34:20 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 901B7F8028B
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:34:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 901B7F8028B
IronPort-SDR: cO65CEj+3sOEL2mykPr2jyXwCMrYPfiAaAlJeQK+jAdE3OMqLdr/kTlzk2XKjwT8mwoGd6OoI/
 qEWuXM593S6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168923521"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="168923521"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:58 -0800
IronPort-SDR: wrk84wwP8hXPYhlkrFgZt/vt4QmZf5CjK8ULIDQh8OEYn6ZJa8JtkbpIVOlfIJb69J7HeNTFJ6
 whYQeP+HryyA==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="374741365"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:58 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 10/11] ASoC: SOF: Intel: HDA: don't keep a temporary
 variable
Date: Mon,  8 Feb 2021 17:33:35 -0600
Message-Id: <20210208233336.59449-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
References: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 broonie@kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

fixup_tplg_name() doesn't need to keep the string, allocated for
filename - it's temporary.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
---
 sound/soc/sof/intel/hda.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 4f7de3d12292..e8094be6bfc6 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -531,22 +531,22 @@ static const char *fixup_tplg_name(struct snd_sof_dev *sdev,
 				   const char *dmic_str)
 {
 	const char *tplg_filename = NULL;
-	char *filename;
-	char *split_ext;
+	char *filename, *tmp;
+	const char *split_ext;
 
-	filename = devm_kstrdup(sdev->dev, sof_tplg_filename, GFP_KERNEL);
+	filename = kstrdup(sof_tplg_filename, GFP_KERNEL);
 	if (!filename)
 		return NULL;
 
 	/* this assumes a .tplg extension */
-	split_ext = strsep(&filename, ".");
-	if (split_ext) {
+	tmp = filename;
+	split_ext = strsep(&tmp, ".");
+	if (split_ext)
 		tplg_filename = devm_kasprintf(sdev->dev, GFP_KERNEL,
 					       "%s%s%s.tplg",
 					       split_ext, idisp_str, dmic_str);
-		if (!tplg_filename)
-			return NULL;
-	}
+	kfree(filename);
+
 	return tplg_filename;
 }
 
-- 
2.25.1


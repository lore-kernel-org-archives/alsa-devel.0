Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AA5C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 20:40:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E058364F45
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 20:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E058364F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 421581680;
	Thu,  4 Feb 2021 21:39:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 421581680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612471216;
	bh=1gAnIfiWrF54LbFRMY1IIln9df3ifu4NPKX0gup42EA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iru+Rn1AK1PEYw3rTynoJl3ixLL9HXjDCoPwVcF6z6gGU3bCGb/EsX94riYrG/9W7
	 N33Z03Y3V2s0g251rxklOYQ4f3iVz27PA50nyhHxjX2/ElqGBQKg0fVvnLJLfkflEF
	 5knjptU+OvuxnMdFlm7oy7obyDbRgivvU21tPzko=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F797F804FD;
	Thu,  4 Feb 2021 21:34:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D33D0F802A0; Thu,  4 Feb 2021 21:34:03 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25105F8025D
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 21:33:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25105F8025D
IronPort-SDR: 06VJVD+OC11GB9S1Cmcz2FZr26Ea2WvzNDAmJwxFAkHb1BdJOHKf1RlbxNW+gEpZdvdSsChXXK
 IPqQlw+f87ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181472558"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="181472558"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:33:57 -0800
IronPort-SDR: Mp9V3CauhM+QQZvHzU6v8eD89L3HRQbS/4WtLcXDGoeRmLMuuq4C5vLM92/fQrpI58WRrvp3e3
 PnKrLP73Lidw==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="483700368"
Received: from jdasilva-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.66.22])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 12:33:55 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/14] ASoC: SOF: Intel: HDA: don't keep a temporary variable
Date: Thu,  4 Feb 2021 14:33:11 -0600
Message-Id: <20210204203312.27112-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
References: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 7dfa30c8a168..a61eb7afd364 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -579,22 +579,22 @@ static const char *fixup_tplg_name(struct snd_sof_dev *sdev,
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


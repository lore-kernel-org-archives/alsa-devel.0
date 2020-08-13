Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01010C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:04:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C1E20774
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fSSk+OXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C1E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A8EC167C;
	Thu, 13 Aug 2020 22:03:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A8EC167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597349087;
	bh=XtUZbPVl0ROKtXqUmQtr5vZKDemSncALnKrrXh4TMGg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fSSk+OXi4NgAYMOqjU2F0bWg9BzPLyXXkoOCDjaGyQDLvHUS1s24RBNTuhMG7ejAB
	 W5qEmJLjMOvMDaCvmdg+6MTCMm5M5dewnD5POzlMHD0fpENu9TkOL9vnkg1SZ/Z2qS
	 p1iEi5BqQmWEcpG55BxvKVuHbGXOy3jx5qy+J/VQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 282E1F802EA;
	Thu, 13 Aug 2020 22:02:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D8CCF8015B; Thu, 13 Aug 2020 22:02:17 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68583F8015B
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 22:02:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68583F8015B
IronPort-SDR: oAMLNcMPQ/XcGlVruWg+zf/9dxGxSwvzHJqO98b2b2faxCqi5UQrvQhXOE9sai2Y1fvrD/c6Jl
 UfQbtEKV6yEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="172360699"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="172360699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:01 -0700
IronPort-SDR: D5ofgr/NILcJoc0oqsT+cioO1A24dPPaZsMDLUCpHhnbD7rAwsR5zOk1Vps6EWy2sX3eHQwPaI
 6nE0uvxR4kfA==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="495506252"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:01:59 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/21] ASoC: Intel: Atom: sst-atom-controls: remove redundant
 assignments
Date: Thu, 13 Aug 2020 15:01:27 -0500
Message-Id: <20200813200147.61990-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
References: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

cppcheck complains of a possible NULL pointer dereference but setting
a pointer before using list_for_each_entry() is not useful.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index ff42f629b035..6b5a34a15acb 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -299,7 +299,7 @@ static int sst_find_and_send_pipe_algo(struct sst_data *drv,
 {
 	int ret = 0;
 	struct sst_algo_control *bc;
-	struct sst_module *algo = NULL;
+	struct sst_module *algo;
 
 	dev_dbg(&drv->pdev->dev, "Enter: widget=%s\n", pipe);
 
@@ -602,7 +602,7 @@ static int sst_set_pipe_gain(struct sst_ids *ids,
 	int ret = 0;
 	struct sst_gain_mixer_control *mc;
 	struct sst_gain_value *gv;
-	struct sst_module *gain = NULL;
+	struct sst_module *gain;
 
 	list_for_each_entry(gain, &ids->gain_list, node) {
 		struct snd_kcontrol *kctl = gain->kctl;
-- 
2.25.1


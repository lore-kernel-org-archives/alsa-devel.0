Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBAC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:14:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8816320829
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jaq+f2/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8816320829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DDFA16BC;
	Thu, 13 Aug 2020 22:13:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DDFA16BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597349657;
	bh=uRX2qwTe3EgM6OJYnw97Wgg3QMDdouJ5GoRL0rm5emc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jaq+f2/gAwTct+J/55c+8L6iZKWZSJKDwP1wzekUBf6prIJdkRM2SpsuGdXRJ+Rqd
	 LG9+QND+5UMRbhwc7LqiKhcY/0jIuYmV3WdRmfcWW0oGICN3KYTWu6i+SHOYqew8Kl
	 qUwg9MIlEaf5XpAKg5tTk0+S2yssEO24VxQaO2ls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F2C8F8036E;
	Thu, 13 Aug 2020 22:02:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D08BDF80343; Thu, 13 Aug 2020 22:02:41 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4913F802F7
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 22:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4913F802F7
IronPort-SDR: Ko/QrYgVaCALzJMyQcauYdZR4RsZfjGqVsDhsUhhAoNZ/eFiMwD53bPzfgfA/iK4MTksP/MdQy
 i2rNzPlsxU7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="134374678"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="134374678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:11 -0700
IronPort-SDR: +VlvwBDRzeEzXiEq15/gc5wvxW/0VvPnG9H4kOputsT7hTas2+gKkzsC1zwql0M3tVMpDgmm54
 qkRY3+R7r3yQ==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="495506330"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:09 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 19/21] ASoC: Intel: Skylake: skl-topology: remove redundant
 assignments
Date: Thu, 13 Aug 2020 15:01:45 -0500
Message-Id: <20200813200147.61990-20-pierre-louis.bossart@linux.intel.com>
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

Cppcheck complains about possible NULL pointer dereferences but the
assignments are actually not needed before walking through lists.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b7d2d97d12a7..3928a1645820 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -550,8 +550,8 @@ static int skl_tplg_unload_pipe_modules(struct skl_dev *skl,
 	 struct skl_pipe *pipe)
 {
 	int ret = 0;
-	struct skl_pipe_module *w_module = NULL;
-	struct skl_module_cfg *mconfig = NULL;
+	struct skl_pipe_module *w_module;
+	struct skl_module_cfg *mconfig;
 
 	list_for_each_entry(w_module, &pipe->w_list, node) {
 		guid_t *uuid_mod;
@@ -1893,7 +1893,7 @@ static int skl_tplg_be_set_src_pipe_params(struct snd_soc_dai *dai,
 static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
 	struct snd_soc_dapm_widget *w, struct skl_pipe_params *params)
 {
-	struct snd_soc_dapm_path *p = NULL;
+	struct snd_soc_dapm_path *p;
 	int ret = -EIO;
 
 	snd_soc_dapm_widget_for_each_sink_path(w, p) {
-- 
2.25.1


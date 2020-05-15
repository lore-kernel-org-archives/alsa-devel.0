Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D6DC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 14:04:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5E220728
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 14:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y8yd17A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5E220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99C8B1658;
	Fri, 15 May 2020 16:03:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99C8B1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589551480;
	bh=3LO6iBYoQ+nsor7BZrvRRlxgT4Ss8h8MCS1F0TuriU8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y8yd17A2aP/ZCk3NG5i+qodDLtkL/P4qlZFWv5rSUlHWsv/NfJlORRPEbPENtjzfa
	 4EwDFt+WTi1orswjtk28k+qBulY05UokYittRp1nccuSUMCg7/HJ5PMdJ+zpXxn6M+
	 yXFmvkRoYBfm8e7lq11A7CnZjMnWGXk2K5uLSmTs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EC70F802A8;
	Fri, 15 May 2020 16:00:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F7B7F802A2; Fri, 15 May 2020 16:00:52 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65481F8027B
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 16:00:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65481F8027B
IronPort-SDR: NhQeDLRHFchRnUDjCFS+lQZj68gJAe8aUETfQlTGMix7DVUTx+uOveiZ7lxA7y2inm7DP9A8fx
 ZyW48gjI6oIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 07:00:39 -0700
IronPort-SDR: /vCn2Y9gA5i4duLwbH2DkSJekbmMOAbU0ys/wnZzCDxlPMa3DRlGTHNo+YSXfc46QQV4AMcBog
 T6DseWOVjXkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; d="scan'208";a="266611117"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006.jf.intel.com with ESMTP; 15 May 2020 07:00:38 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 5/8] ASoC: SOF: Intel: sdw: relax sdw machine select
 constraints
Date: Fri, 15 May 2020 16:59:55 +0300
Message-Id: <20200515135958.17511-6-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200515135958.17511-1-kai.vehmanen@linux.intel.com>
References: <20200515135958.17511-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
 randerwang <rander.wang@linux.intel.com>
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

From: randerwang <rander.wang@linux.intel.com>

On some platforms such as Up Extreme all links are enabled but only one
link can be used by external codec. Instead of exact match of two masks,
first check whether link_mask of mach is subset of link_mask supported
by hw and then go on searching link_adr.

Signed-off-by: randerwang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 578ac7b036b0..63ca920c8e6e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1107,7 +1107,15 @@ static int hda_sdw_machine_select(struct snd_sof_dev *sdev)
 	if (link_mask && !pdata->machine) {
 		for (mach = pdata->desc->alt_machines;
 		     mach && mach->link_mask; mach++) {
-			if (mach->link_mask != link_mask)
+			/*
+			 * On some platforms such as Up Extreme all links
+			 * are enabled but only one link can be used by
+			 * external codec. Instead of exact match of two masks,
+			 * first check whether link_mask of mach is subset of
+			 * link_mask supported by hw and then go on searching
+			 * link_adr
+			 */
+			if (~link_mask & mach->link_mask)
 				continue;
 
 			/* No need to match adr if there is no links defined */
-- 
2.26.0


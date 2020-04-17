Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB24C2D0EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:39:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5812820936
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pv7AE/4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5812820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98D1815F9;
	Fri, 17 Apr 2020 16:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98D1815F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587134377;
	bh=p8zQhRJ5bmzbPNeKvQhJZTyclP+HhQCjJRStO5ZTIpI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pv7AE/4Uqko3LQNBuT1APytVZj9lu9tOJn2cLfomk7Mr1z7IA3SOeGhRYoW0fX4O1
	 Z5C4tlF6E/Wzt524l6JLD7DOGwWN918bbOl7hGv8dBaDe/cfQ19sVWJZ5WGQX7gLcP
	 yMp4skvquQ6CXuO0gxwBQgjvxOpouX0Gdw9EKmSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2516AF80229;
	Fri, 17 Apr 2020 16:38:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE62AF80245; Fri, 17 Apr 2020 16:38:45 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAECBF800AB
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 16:38:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAECBF800AB
IronPort-SDR: gqygIFz88J+4oUBmlWYN9wYfSI+9+0oR22XPcxzA5vV0cgoBYPqmWE9HVIszL1FhQ/hRugynQN
 0tYTN7NDJ9UQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2020 07:38:32 -0700
IronPort-SDR: baXknFGLCSkkGUBZzBc6qb+BU4tK/xCLn1Y2IDUQIV/ERg4d8a7IXxLlFZYNRV0UeOPWIn/ebr
 AzwqymPM5//Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; d="scan'208";a="278397148"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2020 07:38:32 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Jaroslav Kysela <perex@perex.cz>
Subject: [ALSA-LIB PATCH] topology: Use bool parser to parse boolean value
Date: Fri, 17 Apr 2020 12:47:47 -0400
Message-Id: <20200417164747.673-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

It should be safe to change this as correct values with int would be 0
or 1 and bool parser handles them correctly.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 src/topology/dapm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 70645126..cd1a8770 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -595,7 +595,8 @@ int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 		}
 
 		if (strcmp(id, "invert") == 0) {
-			if (tplg_get_integer(n, &ival, 0))
+			ival = snd_config_get_bool(n);
+			if (ival < 0)
 				return -EINVAL;
 
 			widget->invert = ival;
-- 
2.17.1


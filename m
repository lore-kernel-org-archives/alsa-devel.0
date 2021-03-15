Return-Path: <SRS0=ty8W=IN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396FFC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 16:42:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0603E64F2A
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 16:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0603E64F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B79217B4;
	Mon, 15 Mar 2021 17:41:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B79217B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615826543;
	bh=2tsCdGJrlm7rYgVWK1opS+T7B/2Sm3z0L6QTt6VjmOo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGwhft29yRVsAGn/nwKAH7LOXPkVo/JWqY9u2W/+QyGGMX9JwStXnPu6Ri7d/ySmG
	 qRnZaCY5/8Jq9l2E52TrzrAxG8Xm+5DfyOrmA5poNRjsmkwR+W8EeTJA2Lx9LHP8zX
	 HBTgDY6EpNuELTjQzBlHRWzJMqerObOsvVm+IA6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8BD3F801F7;
	Mon, 15 Mar 2021 17:40:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CF9AF80423; Mon, 15 Mar 2021 17:40:11 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34453F801F7
 for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2021 17:39:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34453F801F7
IronPort-SDR: ugjPNQDrf1mztqfZvs7s2O4zTI0z80YMYZzoZB8+eL7FyOdJWYtCLV9KM4MbI37dkdAB/fvwQ3
 PKSokttK10ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274160570"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="274160570"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 09:39:45 -0700
IronPort-SDR: 3EP6WpDAfYPCw3g2XApnjVgCwxQl7v3Z0GQ8OuQMFn8vT0fDNsXfcpDS8QX6cjFtFtZVZrJVKy
 WenHcMUHAwuA==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="604912907"
Received: from pwells-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.5.38])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 09:39:43 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: SOF: remove superfluous NULL check in debugfs read
Date: Mon, 15 Mar 2021 11:39:32 -0500
Message-Id: <20210315163932.18663-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315163932.18663-1-pierre-louis.bossart@linux.intel.com>
References: <20210315163932.18663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Xiuli Pan <xiulipan@outlook.com>, Keqiao Zhang <keqiao.zhang@intel.com>,
 tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

When reading from IPC flood debugfs entries no need to check whether
.cache_buf is NULL - it's impossible since otherwise the initialisation
would have failed. This also fixes a klocwork reported issue:

passed to function and may be dereferenced there by passing argument 2
to function 'memcpy' at line 510.
sound/soc/sof/debug.c:510 | sof_dfsentry_read()

Reported-by: Keqiao Zhang <keqiao.zhang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Xiuli Pan <xiulipan@outlook.com>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 778c7d028493..a51a928ea40a 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -451,8 +451,7 @@ static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
 
 	dentry = file->f_path.dentry;
 	if ((!strcmp(dentry->d_name.name, "ipc_flood_count") ||
-	     !strcmp(dentry->d_name.name, "ipc_flood_duration_ms")) &&
-	    dfse->cache_buf) {
+	     !strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))) {
 		if (*ppos)
 			return 0;
 
-- 
2.25.1


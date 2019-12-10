Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEBAC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:45:41 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E336206E0
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E336206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E33301677;
	Tue, 10 Dec 2019 01:44:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E33301677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575938739;
	bh=7H9ltI1nbxHT3mHxxdpxEQK0VPTPgNW6b/Vxn4MbUVc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g8+lQpLFYuS6PO7PCLSKHQy7erlIusSdiul+X20uXdt5HoJdRXaKM8a+i8xZg9rA6
	 hLjUEuwQdEAsH1B6UKotRG0tNwnbh4v7Ja7iIUCJ/pZ9ysUIjGQAuX6s23XABHbbAY
	 rZvPK+oX6NNZAq6egzcUFqGX9hxsky3yxyJDJaQ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62BEFF80246;
	Tue, 10 Dec 2019 01:39:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCD6AF80240; Tue, 10 Dec 2019 01:39:51 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F6ECF800C4
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 01:39:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F6ECF800C4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 16:39:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; d="scan'208";a="210284347"
Received: from sneuhier-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.188.78])
 by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 16:39:43 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 18:39:39 -0600
Message-Id: <20191210003939.15752-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210003939.15752-1-pierre-louis.bossart@linux.intel.com>
References: <20191210003939.15752-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, Dragos Tarcatu <dragos_tarcatu@mentor.com>,
 broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 2/2] ASoC: topology: Check return value for
	soc_tplg_pcm_create()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

The return value of soc_tplg_pcm_create() is currently not checked
in soc_tplg_pcm_elems_load(). If an error is to occur there, the
topology ignores it and continues loading.

Fix that by checking the status and rejecting the topology on error.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 93ba6778ef27..92e4f4d08bfa 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2046,6 +2046,7 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	int size;
 	int i;
 	bool abi_match;
+	int ret;
 
 	count = le32_to_cpu(hdr->count);
 
@@ -2087,7 +2088,12 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 		}
 
 		/* create the FE DAIs and DAI links */
-		soc_tplg_pcm_create(tplg, _pcm);
+		ret = soc_tplg_pcm_create(tplg, _pcm);
+		if (ret < 0) {
+			if (!abi_match)
+				kfree(_pcm);
+			return ret;
+		}
 
 		/* offset by version-specific struct size and
 		 * real priv data size
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

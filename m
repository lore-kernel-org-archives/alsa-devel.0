Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1277C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:36:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0EB206E9
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gcoubm3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0EB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9151C1672;
	Wed, 15 Apr 2020 22:36:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9151C1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586983015;
	bh=Gk3KNs5jxEJvzJfLdVhBcHyZjK7nu3QXD2ar7R/hSkY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gcoubm3QUiDxClJ2Iw5bstqgBoDxMuslX7wy6Vf1R/4BfXKT85UrpJizBZ4U5bFRj
	 5xJ2v3PIva8QgSDc9ymyv8zXVWAazGitdrvxxH48+rRtJGR8EstTVbA/FF85W+iSpw
	 KD/c5at4aac77QSTE+XXbeJcynRyr2Pa0hiV9tqs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9872F802E2;
	Wed, 15 Apr 2020 22:29:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2541EF8029A; Wed, 15 Apr 2020 22:29:17 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F097F802A0
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 22:29:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F097F802A0
IronPort-SDR: pr7OIcchErumjsToJPIo6i2QJHuZgKeKApxhMOip18n/45hb3Mt/2xGJ2UoS4HPCzFSUexve9/
 2AkB69lqvf4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 13:29:08 -0700
IronPort-SDR: ZGnsAhazzbMVphvsUNMSzxA7N39x9H+W6hkvokbk3usErLcgxvpFE6gDLFak6tfMYNzy9B9gS2
 2FVY5yCn0Qsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; d="scan'208";a="288656308"
Received: from jplam-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.82.197])
 by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2020 13:29:07 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/24] ASoC: SOF: change type char to uint8_t in topology.h
Date: Wed, 15 Apr 2020 15:28:05 -0500
Message-Id: <20200415202816.934-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415202816.934-1-pierre-louis.bossart@linux.intel.com>
References: <20200415202816.934-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Pan Xiuli <xiuli.pan@linux.intel.com>

Use uint8_t to replace char in packed ABI structs
to have fixed length for struct.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index 8f8d1cf649f2..6a6b4791eaf6 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -220,7 +220,7 @@ struct sof_ipc_comp_process {
 	/* reserved for future use */
 	uint32_t reserved[7];
 
-	unsigned char data[0];
+	uint8_t data[0];
 } __packed;
 
 /* frees components, buffers and pipelines
-- 
2.20.1


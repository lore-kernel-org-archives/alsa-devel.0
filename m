Return-Path: <SRS0=nNdU=W2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75021C3A5A3
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 05:23:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5AE2087F
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 05:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Obfw4fK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5AE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A6DC822;
	Fri, 30 Aug 2019 07:22:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A6DC822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567142609;
	bh=eupsk3NRhe5P2F2BgGvdTDktZAst6RQrbOZ63KHlyas=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Obfw4fK2OGPHzPnIykSngBJcBk252UP8LCLE56GoOxNBSUVcgZkHfgpT4mPbR8CQx
	 PpFmTH8xhYqDeEZnT5p8+FVK1Dk0I7HGHHviOkZHmyQ9yerLITmxEGgkw96zNnJD3L
	 mFSeW0PJWelkM530O5MYBUlCSobiKem9xaWaQP5c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82582F80362;
	Fri, 30 Aug 2019 07:22:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38881F80369; Fri, 30 Aug 2019 07:22:36 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60C5AF80096
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 07:22:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60C5AF80096
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2019 22:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; d="scan'208";a="197959673"
Received: from vganji-b85m-d3h.iind.intel.com ([10.223.163.76])
 by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 22:22:27 -0700
From: vani.ganji@intel.com
To: alsa-devel@alsa-project.org
Date: Fri, 30 Aug 2019 10:53:18 +0530
Message-Id: <20190830052318.25898-1-vani.ganji@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vani.ganji@intel.com
Subject: [alsa-devel] [PATCH] [PATCH v2] ALSA: hda: Retry codec read on
	first time failure
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190830052318.74x2JoDavkEkcj5TXCbcjokpYAZxjvQ7ZYlVFzBhtsU@z>

From: Vani Ganji <vani.ganji@intel.com>

Sometimes HDMI audio fails while fast switching
between HDMI and Speaker due to codec Get Power state verb read failure.

Verb is codec driver to access codec HW. Since issue scenario involves
fast switching between HDMI and speaker, there might be chance to fail
read from HW and same happened in the error scenario.

Based on Display/Graphics architect suggestion, added a retry mechanism
for failure on first attempt.

Changes from v1:
-Corrected missing braces.

Signed-off-by: Vani Ganji <vani.ganji@intel.com>
---
 sound/hda/hdac_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index b26cc93e7e10..3874d54aa686 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -984,10 +984,17 @@ static unsigned int codec_read(struct hdac_device *hdac, hda_nid_t nid,
 {
 	unsigned int cmd = snd_hdac_make_cmd(hdac, nid, verb, parm);
 	unsigned int res;
-
-	if (snd_hdac_exec_verb(hdac, cmd, flags, &res))
-		return -1;
-
+	unsigned int count;
+
+	/* Retry verb once more if it fails first time */
+	/* recommended to retry since it is HW related */
+	for (count = 0; count <= 1; count++) {
+		if (snd_hdac_exec_verb(hdac, cmd, flags, &res)) {
+			if (count == 1)
+				return -1;
+		} else
+			break;
+	}
 	return res;
 }
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

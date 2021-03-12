Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C51C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 17:04:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1249D6501A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 17:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1249D6501A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6ABE1723;
	Fri, 12 Mar 2021 18:03:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6ABE1723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615568684;
	bh=9eOlMzRiXIfv4iT8og8m+O4dGyfg8/I85vJsQg8ARIE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jCq8u1zAb+2GmhOBV1b/naeeP0qUm2HNfMZkivHhfT3dQYKNKfEWBDYHKjK+dLGHX
	 K+/bpjwetXRdwBPGAl6cTbk09lzEDzFrvMANxakpaAPA10dWxScYmmv91n2CY0WcwA
	 X2B0JBUBjRzWqFmr1GP6ivDkgTCw0fsJpyO7ip2k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44EB1F8016C;
	Fri, 12 Mar 2021 18:03:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7749DF801ED; Fri, 12 Mar 2021 18:03:47 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CCE1F800AB
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 18:03:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CCE1F800AB
IronPort-SDR: WReEW1qoPdAkX4sBc5vuzdPngd1kicl3oZ3TuKuBSYW7OwbTlHPhSxQMlmF9rORVfJjYpZXVNU
 6vF1FXD8oJyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168775060"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="168775060"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 09:03:28 -0800
IronPort-SDR: oJD3zC5D9IyA7/bLjRl4Ngi8+RP/xGhwGhp2aW8J7GNpp8qacQNPWCaIXd5F2dlzKyivQsX1wt
 q+E4/VJSmdFw==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="411067685"
Received: from akharche-mobl2.ccr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.135.254])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 09:03:26 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] speaker-test: add support for S24_LE and S24_BE
Date: Fri, 12 Mar 2021 11:03:16 -0600
Message-Id: <20210312170316.63231-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

These formats are sometimes advertised by drivers, e.g. SOF.
The format is 3 bytes packed in 32-bit container, with the MSB zeroed
out.

sample: 0x00123456

S24_LE format:
b0 56
b1 34
b2 12
b3 00

S24_BE format:
b0 00
b1 12
b2 34
b3 56

I only tested the S24_LE format with the SOF driver, S24_BE was added
for symmetry only.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 speaker-test/speaker-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 773af0a..fd13d88 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -285,6 +285,8 @@ static const int	supported_formats[] = {
   SND_PCM_FORMAT_FLOAT_LE,
   SND_PCM_FORMAT_S24_3LE,
   SND_PCM_FORMAT_S24_3BE,
+  SND_PCM_FORMAT_S24_LE,
+  SND_PCM_FORMAT_S24_BE,
   SND_PCM_FORMAT_S32_LE,
   SND_PCM_FORMAT_S32_BE,
   -1
@@ -338,6 +340,20 @@ static void do_generate(uint8_t *frames, int channel, int count,
         *samp8++ = BE_INT(res.i) >> 8;
         *samp8++ = BE_INT(res.i) >> 16;
         break;
+      case SND_PCM_FORMAT_S24_LE:
+        res.i >>= 8;
+        *samp8++ = LE_INT(res.i);
+        *samp8++ = LE_INT(res.i) >> 8;
+        *samp8++ = LE_INT(res.i) >> 16;
+        *samp8++ = 0;
+        break;
+      case SND_PCM_FORMAT_S24_BE:
+        res.i >>= 8;
+        *samp8++ = 0;
+        *samp8++ = BE_INT(res.i);
+        *samp8++ = BE_INT(res.i) >> 8;
+        *samp8++ = BE_INT(res.i) >> 16;
+        break;
       case SND_PCM_FORMAT_S32_LE:
 	*samp32++ = LE_INT(res.i);
         break;
-- 
2.25.1


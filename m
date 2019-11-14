Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C952C432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:32:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E55206F0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N6XQiR/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E55206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 718EC1698;
	Thu, 14 Nov 2019 19:31:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 718EC1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573756340;
	bh=GK51t0NpcjO6/+IicuUAfGMtITJxKxB5en2r+yf9sqw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N6XQiR/JcZ41jzDyCa9N1zbz//GcujPr/b9yb87eBzQ5M8pMfKglGM1NbJjNQUTiK
	 AcI0hDcwPCZOTPdqOFNmWoqoZEsIGn9lTF/aVr4R6dKyXW2v3vbKrlMtT3w6CmYcdM
	 dgHOc7VOi1UBSXeymAZm8vKyBxu9Gbxg4rde91m0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8A7CF80279;
	Thu, 14 Nov 2019 19:18:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65065F8015E; Thu, 14 Nov 2019 19:18:18 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0010FF8011A
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 19:18:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0010FF8011A
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 10:18:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; d="scan'208";a="195123601"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
 by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:18:03 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 14 Nov 2019 12:17:00 -0600
Message-Id: <20191114181702.22254-21-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 20/22] soundwire: stream: do not update
	parameters during DISABLED-PREPARED transition
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

After a system suspend, the ALSA/ASoC core will invoke the .prepare()
callback and a TRIGGER_START when INFO_RESUME is not supported.

Likewise, when an underflow occurs, the .prepare callback will be invoked.

In both cases, the stream can be in DISABLED mode, and will transition
into the PREPARED mode. We however don't want the bus bandwidth to be
recomputed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index bd0bddf73830..c28ce7f0d742 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1460,7 +1460,8 @@ static void sdw_release_bus_lock(struct sdw_stream_runtime *stream)
 	}
 }
 
-static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
+static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
+			       bool update_params)
 {
 	struct sdw_master_runtime *m_rt;
 	struct sdw_bus *bus = NULL;
@@ -1480,6 +1481,9 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 			return -EINVAL;
 		}
 
+		if (!update_params)
+			goto program_params;
+
 		/* Increment cumulative bus bandwidth */
 		/* TODO: Update this during Device-Device support */
 		bus->params.bandwidth += m_rt->stream->params.rate *
@@ -1495,6 +1499,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 			}
 		}
 
+program_params:
 		/* Program params */
 		ret = sdw_program_params(bus);
 		if (ret < 0) {
@@ -1544,6 +1549,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
  */
 int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 {
+	bool update_params = true;
 	int ret;
 
 	if (!stream) {
@@ -1567,7 +1573,16 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 		goto state_err;
 	}
 
-	ret = _sdw_prepare_stream(stream);
+	/*
+	 * when the stream is DISABLED, this means sdw_prepare_stream()
+	 * is called as a result of an underflow or a resume operation.
+	 * In this case, the bus parameters shall not be recomputed, but
+	 * still need to be re-applied
+	 */
+	if (stream->state == SDW_STREAM_DISABLED)
+		update_params = false;
+
+	ret = _sdw_prepare_stream(stream, update_params);
 
 state_err:
 	sdw_release_bus_lock(stream);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD652C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:12:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546482071E
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WlEIweW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546482071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7CD81680;
	Wed, 29 Jan 2020 23:12:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7CD81680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580335970;
	bh=pzRC0GjBMpsK1E5nbnMNp8W8txCkE0Jrk9ZgE9txGg0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WlEIweW0IEy3S7OnbbB8287Kn3v1++cvub5eqBiQWr8NShtfOKfpaCJ5tq0eFbE4k
	 QWZ3yVu0GCw6VGLrbQ96rUWFYJLnn0DVSgVYppheM9YQH9TAqtL2Z7bq8J30l9nGMo
	 PUkTnZ5S1G3TrOOa1Tkwb82wOk8J5Aq9EScUsz3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C40D2F80299;
	Wed, 29 Jan 2020 23:08:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D9D3F8027C; Wed, 29 Jan 2020 23:08:03 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAC56F80229
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 23:07:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAC56F80229
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 14:07:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; d="scan'208";a="402122395"
Received: from kjhudson-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.70.93])
 by orsmga005.jf.intel.com with ESMTP; 29 Jan 2020 14:07:50 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed, 29 Jan 2020 16:07:24 -0600
Message-Id: <20200129220726.31792-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129220726.31792-1-pierre-louis.bossart@linux.intel.com>
References: <20200129220726.31792-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 7/9] ASoC: SOF: Intel: hda: Amend the DSP state
	transition diagram
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Amend the DSP state transition diagram in preparation
for introducing the feature to support opportunistic
DSP D0I3 state when the system is in S0.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 36 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 8c00e128a7b0..7b8425330ae0 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -488,33 +488,31 @@ int hda_dsp_set_power_state(struct snd_sof_dev *sdev,
 /*
  * Audio DSP states may transform as below:-
  *
- *                                         D0I3 compatible stream
- *     Runtime    +---------------------+   opened only, timeout
+ *                                         Opportunistic D0I3 in S0
+ *     Runtime    +---------------------+  Delayed D0i3 work timeout
  *     suspend    |                     +--------------------+
- *   +------------+       D0(active)    |                    |
+ *   +------------+       D0I0(active)  |                    |
  *   |            |                     <---------------+    |
- *   |   +-------->                     |               |    |
- *   |   |Runtime +--^--+---------^--+--+ The last      |    |
- *   |   |resume     |  |         |  |    opened D0I3   |    |
- *   |   |           |  |         |  |    compatible    |    |
- *   |   |     resume|  |         |  |    stream closed |    |
- *   |   |      from |  | D3      |  |                  |    |
- *   |   |       D3  |  |suspend  |  | d0i3             |    |
+ *   |   +-------->                     |    New IPC	|    |
+ *   |   |Runtime +--^--+---------^--+--+ (via mailbox)	|    |
+ *   |   |resume     |  |         |  |			|    |
+ *   |   |           |  |         |  |			|    |
+ *   |   |     System|  |         |  |			|    |
+ *   |   |     resume|  | S3/S0IX |  |                  |    |
+ *   |   |	     |  | suspend |  | S0IX             |    |
  *   |   |           |  |         |  |suspend           |    |
  *   |   |           |  |         |  |                  |    |
  *   |   |           |  |         |  |                  |    |
  * +-v---+-----------+--v-------+ |  |           +------+----v----+
  * |                            | |  +----------->                |
- * |       D3 (suspended)       | |              |      D0I3      +-----+
- * |                            | +--------------+                |     |
- * |                            |  resume from   |                |     |
- * +-------------------^--------+  d0i3 suspend  +----------------+     |
- *                     |                                                |
- *                     |                       D3 suspend               |
- *                     +------------------------------------------------+
+ * |       D3 (suspended)       | |              |      D0I3      |
+ * |                            | +--------------+                |
+ * |                            |  System resume |                |
+ * +----------------------------+		 +----------------+
  *
- * d0i3_suspend = s0_suspend && D0I3 stream opened,
- * D3 suspend = !d0i3_suspend,
+ * S0IX suspend: The DSP is in D0I3 if any D0I3-compatible streams
+ *		 ignored the suspend trigger. Otherwise the DSP
+ *		 is in D3.
  */
 
 static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

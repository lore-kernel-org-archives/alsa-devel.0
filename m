Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C99C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:37:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C11206A3
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KTfhhQZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C11206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBDCC167D;
	Mon, 11 Nov 2019 23:36:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBDCC167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573511836;
	bh=lyXe/xWfJI1AZVOLshcx/5Yr7gQBqkC/bkDM1lf5Ds0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KTfhhQZxAE7bfw/tyV8JG0ge+pfdJqNJwIAYJ+PnDHmb8NWHeA1HeEQegTdih3LH/
	 z9PQWf5FA1V79UrR6mekNlcXqbhCIgjtbKm7fqSpemLgqbNnbpaI+A9He5CIaH/vS2
	 3frA7tEYLpDtkcywTkjCHnM99j2ZVLd6+Q+5rJGs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E1E3F805FF;
	Mon, 11 Nov 2019 23:34:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7458DF80600; Mon, 11 Nov 2019 23:34:01 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0BE1F804FF
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 23:33:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0BE1F804FF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Nov 2019 14:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; d="scan'208";a="354903238"
Received: from kathyche-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.27.186])
 by orsmga004.jf.intel.com with ESMTP; 11 Nov 2019 14:33:52 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 11 Nov 2019 16:33:43 -0600
Message-Id: <20191111223343.19986-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111223343.19986-1-pierre-louis.bossart@linux.intel.com>
References: <20191111223343.19986-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 4/4] ASoC: SOF: PM: only suspend to D0I3 when
	needed
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

From: Keyon Jie <yang.jie@linux.intel.com>

We should suspend audio to D3 by default, for the sake of power saving,
change the condition of D0I3 suspending here to that when there is
stream with suspend_ignored specified.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index b89810bf3230..0fd5567237a8 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -468,7 +468,7 @@ int snd_sof_resume(struct device *dev)
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	int ret;
 
-	if (sdev->s0_suspend) {
+	if (snd_sof_dsp_d0i3_on_suspend(sdev)) {
 		/* resume from D0I3 */
 		dev_dbg(sdev->dev, "DSP will exit from D0i3...\n");
 		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I0);
@@ -497,7 +497,7 @@ int snd_sof_suspend(struct device *dev)
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	int ret;
 
-	if (sdev->s0_suspend) {
+	if (snd_sof_dsp_d0i3_on_suspend(sdev)) {
 		/* suspend to D0i3 */
 		dev_dbg(sdev->dev, "DSP is trying to enter D0i3...\n");
 		ret = snd_sof_set_d0_substate(sdev, SOF_DSP_D0I3);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

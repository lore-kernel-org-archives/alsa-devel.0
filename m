Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE171C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Feb 2022 15:40:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F12D71872;
	Mon,  7 Feb 2022 16:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F12D71872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644248432;
	bh=HY7MVKcXpMu5mQDAhQkFIj+x1Nih51r+Y0slJWpEr98=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K3u1M4Xd3OLMG0lvCEzLpOPUw8+pdqJfXnOmYXYmXMGBbWTfO3xRcbY26vQ3Ltxkf
	 u8iU9guZ/h0UqFfGHA4KYgeoVRj4axPpfVYAZEr7Fm2YdxX7tbikk+s6hKD9SQg6S6
	 26ir3x8ow+ZUFaq6L9XGjkZsjqRHm2SXMdnuveC4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAC1AF804FF;
	Mon,  7 Feb 2022 16:38:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 904E2F8023B; Mon,  7 Feb 2022 16:38:54 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A174DF8023B
 for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2022 16:38:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A174DF8023B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="GJ+2RDIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644248327; x=1675784327;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HY7MVKcXpMu5mQDAhQkFIj+x1Nih51r+Y0slJWpEr98=;
 b=GJ+2RDIoWy1ZHFFDDzWbvqD0nLwHl+pcAw/Ll8VqH9JkMqlQyQGBhoDj
 8LkwUbzadgg0jR6V0ikNM59kC4bp8xGFKNECjjGviHGRgl7FlEge+DgWC
 0z/ncQIehLxlnWKDynDsdXd0TL3lvr5+tIICYD7nWHNEY56RRwNtZ8iIV
 56XkO2mSVIYliw+Z/yGuZPpQ8SZ6vZwS8gdqfwSJh/EUkZ3pR39e+p1yP
 bmiUwSWyJD5Rmfgj9t/TMQQxPqTkwtkmY1LMqGgYtpY/KgcANaR6HliSP
 z//1q+U31ucwvTowoeo4rv8gxSkqxZ7uRWNmGnmEtUp2cbM9BNI5nOyPw A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228708969"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; d="scan'208";a="228708969"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 07:38:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; d="scan'208";a="481616889"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003.jf.intel.com with ESMTP; 07 Feb 2022 07:38:34 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>,
 broonie@kernel.org
Subject: [PATCH 1/3] ASoC: rt5682s: do not block workqueue if card is unbound
Date: Mon,  7 Feb 2022 17:29:58 +0200
Message-Id: <20220207153000.3452802-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 Shuming Fan <shumingf@realtek.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

The current rt5682s_jack_detect_handler() assumes the component
and card will always show up and implements an infinite usleep
loop waiting for them to show up.

This does not hold true if a codec interrupt (or other
event) occurs when the card is unbound. The codec driver's
remove  or shutdown functions cannot cancel the workqueue due
to the wait loop. As a result, code can either end up blocking
the workqueue, or hit a kernel oops when the card is freed.

Fix the issue by rescheduling the jack detect handler in
case the card is not ready. In case card never shows up,
the shutdown/remove/suspend calls can now cancel the detect
task.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682s.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index efa1016831dd..1e662d1be2b3 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -824,11 +824,13 @@ static void rt5682s_jack_detect_handler(struct work_struct *work)
 		container_of(work, struct rt5682s_priv, jack_detect_work.work);
 	int val, btn_type;
 
-	while (!rt5682s->component)
-		usleep_range(10000, 15000);
-
-	while (!rt5682s->component->card->instantiated)
-		usleep_range(10000, 15000);
+	if (!rt5682s->component || !rt5682s->component->card ||
+	    !rt5682s->component->card->instantiated) {
+		/* card not yet ready, try later */
+		mod_delayed_work(system_power_efficient_wq,
+				 &rt5682s->jack_detect_work, msecs_to_jiffies(15));
+		return;
+	}
 
 	mutex_lock(&rt5682s->jdet_mutex);
 	mutex_lock(&rt5682s->calibrate_mutex);

base-commit: d466706b9d0dae4754a47c34fd5f4654ee54f609
-- 
2.35.1


Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E19DC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Feb 2022 02:33:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B79E1942;
	Wed, 23 Feb 2022 03:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B79E1942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645583587;
	bh=BvI6XKS2a6C7yafGKdew4q9Fsz5hDA4ieFJRLYviGN0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NCq/fbX4ViRY9dkaz8Ue6BJZ11KEKpkN6wDk+FCnedanz6ln9wRiZ0j8+er7E9xEQ
	 34EqC01M55xU+zvAO1YeBdtGiEAhs9wKUCx84DdzGppCmnK8bH8Ix/67euyjrVaHM6
	 XJODg0f42lNXEwIyLjG/ZzRxnNbpmqOnMomTKoD4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE16DF804FD;
	Wed, 23 Feb 2022 03:32:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EA41F80511; Wed, 23 Feb 2022 03:32:15 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8386CF802E3
 for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2022 03:32:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8386CF802E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="anpDHIaN"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 200966150E;
 Wed, 23 Feb 2022 02:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E89AC340EB;
 Wed, 23 Feb 2022 02:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645583525;
 bh=BvI6XKS2a6C7yafGKdew4q9Fsz5hDA4ieFJRLYviGN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=anpDHIaNncLBUWIz9Rgl/z0/KD2CVCxuMoU49xD4LftAGps+O/VAppbOaqWKfsY1o
 4ckEzKzy+dqn+uaqc99CjETuRf/uIGZB/43xqHehMvdH/JtVdeBBF43Z2OcC5ITMKv
 0pkLN+eGfGpyatsXJtOWoEsuNLAurYhLRqy5ScoW3KAKmZM041PlT6RDVeE9k46VYT
 pHrKJjaGKcRdWloqYirnvrZOwy9xgHdNYvyVqtp7OsBm5jgo5XG44RCpn4YHyjTJkX
 bRV1B+S9rhDi3BIF8lozJuLwKFbG9L7d4SyGSjINPXxd6GSPpCipfnbIYGGYLGyb8d
 c/LgokQAbyQsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/13] ASoC: rt5682: do not block workqueue if
 card is unbound
Date: Tue, 22 Feb 2022 21:31:44 -0500
Message-Id: <20220223023152.242065-5-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223023152.242065-1-sashal@kernel.org>
References: <20220223023152.242065-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, oder_chiou@realtek.com,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 lgirdwood@gmail.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 tiwai@suse.com, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Shuming Fan <shumingf@realtek.com>,
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 4c33de0673ced9c7c37b3bbd9bfe0fda72340b2a ]

The current rt5682_jack_detect_handler() assumes the component
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
Link: https://lore.kernel.org/r/20220207153000.3452802-3-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 7a78bb00f874d..5979165ac37cf 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1039,11 +1039,13 @@ static void rt5682_jack_detect_handler(struct work_struct *work)
 		container_of(work, struct rt5682_priv, jack_detect_work.work);
 	int val, btn_type;
 
-	while (!rt5682->component)
-		usleep_range(10000, 15000);
-
-	while (!rt5682->component->card->instantiated)
-		usleep_range(10000, 15000);
+	if (!rt5682->component || !rt5682->component->card ||
+	    !rt5682->component->card->instantiated) {
+		/* card not yet ready, try later */
+		mod_delayed_work(system_power_efficient_wq,
+				 &rt5682->jack_detect_work, msecs_to_jiffies(15));
+		return;
+	}
 
 	mutex_lock(&rt5682->calibrate_mutex);
 
-- 
2.34.1


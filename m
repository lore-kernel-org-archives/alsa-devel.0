Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184C8C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Feb 2022 02:32:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54559192A;
	Wed, 23 Feb 2022 03:31:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54559192A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645583551;
	bh=x8fJSb9IKlcqvRl4YJcfYG9sKVjOS3ECVVnLLeHY8RQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d+f24oc6EO6JzXSSdu8g5iQSnHWshxRz3BOpyvmzS7CUspVpwrpeLaUGZWIBJjbaf
	 KGlqMP8fJbw0qx+bA2Qai9CYEit3oTsauD5rbGz3vH4XBs/aAthtSzyG5sUnfLp7G8
	 BVGRw4Urgpcle2KnS+gDdikL5mF3hnk0jFLJUSkk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A75DDF802A0;
	Wed, 23 Feb 2022 03:31:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 471B5F802E3; Wed, 23 Feb 2022 03:31:38 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF0AEF80237
 for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2022 03:31:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF0AEF80237
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MPy/ci52"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DF4CBB81E1F;
 Wed, 23 Feb 2022 02:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C528AC340EB;
 Wed, 23 Feb 2022 02:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645583488;
 bh=x8fJSb9IKlcqvRl4YJcfYG9sKVjOS3ECVVnLLeHY8RQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MPy/ci52QpCL0GC6+0MzNXTRjEIk42eK11oXHQX1j8UnY7ycSjDRK0APBtYXgpJPF
 +ywdyLAfjWYdD8Dzxb8YGRNzpwv4E/ucpzczYJgsJnBIgm2LiYFXyCh2A0N03BpVOe
 s7SEdRj4t575M7p5EeSuoQohSb6BzD0gEIuSAbXMpyhFEEUF1w2R6m0eVyDzUEKJXz
 tPBJmryWhATE5boQFoup9LV/pan4R5xkqhGrS5ZUu5dxSHWlvdOmPyynfwT8fMIyvb
 5s1y84Y5YHHKdaY/vyBF/4UNA9R+WvxHLsoBbDgxQIifqwjUoPo6uR3yvo2MwLN3oW
 IW8EoI8EJNW2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/13] ASoC: rt5668: do not block workqueue if
 card is unbound
Date: Tue, 22 Feb 2022 21:31:08 -0500
Message-Id: <20220223023118.241815-4-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223023118.241815-1-sashal@kernel.org>
References: <20220223023118.241815-1-sashal@kernel.org>
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

[ Upstream commit a6d78661dc903d90a327892bbc34268f3a5f4b9c ]

The current rt5668_jack_detect_handler() assumes the component
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
Link: https://lore.kernel.org/r/20220207153000.3452802-2-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5668.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 5716cede99cb4..acc2b34ca334a 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -1022,11 +1022,13 @@ static void rt5668_jack_detect_handler(struct work_struct *work)
 		container_of(work, struct rt5668_priv, jack_detect_work.work);
 	int val, btn_type;
 
-	while (!rt5668->component)
-		usleep_range(10000, 15000);
-
-	while (!rt5668->component->card->instantiated)
-		usleep_range(10000, 15000);
+	if (!rt5668->component || !rt5668->component->card ||
+	    !rt5668->component->card->instantiated) {
+		/* card not yet ready, try later */
+		mod_delayed_work(system_power_efficient_wq,
+				 &rt5668->jack_detect_work, msecs_to_jiffies(15));
+		return;
+	}
 
 	mutex_lock(&rt5668->calibrate_mutex);
 
-- 
2.34.1


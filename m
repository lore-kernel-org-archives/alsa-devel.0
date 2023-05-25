Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F8BC77B7A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 May 2023 18:36:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06CD9844;
	Thu, 25 May 2023 20:35:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06CD9844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685039758;
	bh=0mQAkCsUwc7xaj9v83lIYLR/AacKkPZSIJOUfXzWZjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PYeOt4HWGttV3CWvITnZCYMbcP8qLxPfJfsvwZ+n4o7HJK4AS02x4wWyml0kMR8Tg
	 3CZZ0Knb0mSQneYnyfi9/m8+4xroClkQKcCUUmbbl3Lefhg8k/WJmQ+5VnS/F1V1wG
	 PN7jY5p7bb9FuoUi7uiqYEWfN6nr8KOIHE4I8PP8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20A27F8057D; Thu, 25 May 2023 20:34:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 48B5EF80558;
	Thu, 25 May 2023 20:34:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB4B2F8024E; Thu, 25 May 2023 20:34:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08620F80249;
	Thu, 25 May 2023 20:34:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08620F80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RzHjHDiu
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D904E648BB;
	Thu, 25 May 2023 18:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB978C433D2;
	Thu, 25 May 2023 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039643;
	bh=0mQAkCsUwc7xaj9v83lIYLR/AacKkPZSIJOUfXzWZjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzHjHDiuEW+8OF4biX+ZyG28cLICUubAZ8B/ICCoCJvjzRSJFkEsMuzaWICiBRp7a
	 kVyYpYF5vG7bAIDNX5B9r9D6/1ppPxN43NHcT/ugtWyLoIYJCFVf5gMXMTaUSQVFyV
	 4syjUiENaY0eeI60acd8JCwWURP6daKW60jhIIM8WLPJfA9jbHEmHC6Y9Vu48o7v0o
	 Pu+PQihrKVEztkkp+XGHSh+5vXUuctf925DFtqPngRABPWpdkdKndQXTjGHACzafVY
	 zMCALOIlHxOTXGCjIVt0YPu/6rnPXFG1rNG7GCzdqD94ni3o0UNztnlJhH+P/svTRK
	 Hlzc/bFrsJ8Pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 32/67] ASoC: SOF: pcm: fix pm_runtime imbalance in
 error handling
Date: Thu, 25 May 2023 14:31:09 -0400
Message-Id: <20230525183144.1717540-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LMXSHENMQCRW6HIAQXURQHOFWFDMRRNB
X-Message-ID-Hash: LMXSHENMQCRW6HIAQXURQHOFWFDMRRNB
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LMXSHENMQCRW6HIAQXURQHOFWFDMRRNB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit da0fe8fd515a471d373acc3682bfb5522cca4d55 ]

When an error occurs, we need to make sure the device can pm_runtime
suspend instead of keeping it active.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com
Link: https://lore.kernel.org/r/20230512103315.8921-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pcm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 445acb5c3a21b..2570f33db9f3e 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -616,16 +616,17 @@ static int sof_pcm_probe(struct snd_soc_component *component)
 				       "%s/%s",
 				       plat_data->tplg_filename_prefix,
 				       plat_data->tplg_filename);
-	if (!tplg_filename)
-		return -ENOMEM;
+	if (!tplg_filename) {
+		ret = -ENOMEM;
+		goto pm_error;
+	}
 
 	ret = snd_sof_load_topology(component, tplg_filename);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(component->dev, "error: failed to load DSP topology %d\n",
 			ret);
-		return ret;
-	}
 
+pm_error:
 	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
-- 
2.39.2


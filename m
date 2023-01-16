Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68A8C677F1
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Jan 2023 14:03:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D456056C8;
	Mon, 16 Jan 2023 15:02:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D456056C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673877810;
	bh=gd6nnAxCXX6nRwCMcVtm0qxihQ4usvTBVYQsxON9ZlI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mNKuVKeHm6WEBLecru/IDbVhvITMjvJNuj6HcFTS3tIVS2+bJpzcY87gY8aZUwoAd
	 uUvDi9Xuzt69/CiHjj1vRhh/yf9DSrUx74RKHhpTqyqKZIDANorBjceRzLy41TJcv2
	 e8/Y7IdELNEXZUnYJk37G19cRM6YFF+0cFW0ok3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D34B1F80558;
	Mon, 16 Jan 2023 15:02:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69AAAF8053D; Mon, 16 Jan 2023 15:02:14 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F563F8023A;
 Mon, 16 Jan 2023 15:02:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F563F8023A
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=F7VYT2Fl
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A84B160FCC;
 Mon, 16 Jan 2023 14:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966CCC433F2;
 Mon, 16 Jan 2023 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673877721;
 bh=gd6nnAxCXX6nRwCMcVtm0qxihQ4usvTBVYQsxON9ZlI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F7VYT2FlXIS5w2rDCSnB2KQBhT/fWc/g5qeby3PrjLiM1eVrdv/NPTwdlen0LOcuj
 5oYP55PiHZgXYSzzbs7KTDuLKNZAzFDKBtcIfN1l3ePOjy1lkzLX7FpxfTmaeUfkkQ
 WVxT3Ke6R6L956eJ8BWUkTjpB3/0bCTKSwx2VJsYoSvsNH9v6sfVBcig4+pZjTx1q4
 3+WCYLju/Riv6HhnciIbgHcMS36fVLwt6kMdtgNWQAU5/bkX2bbje6MwZaKYyTtoy0
 SQmCSmLCGzXtHRWSc+I9Wn26JJBOxmGHYik8ZIegmIZbpIAYUtireUrEnuWht4KX80
 76ezWsYI8AjBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/53] ASoC: SOF: pm: Always tear down pipelines
 before DSP suspend
Date: Mon, 16 Jan 2023 09:01:03 -0500
Message-Id: <20230116140154.114951-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230116140154.114951-1-sashal@kernel.org>
References: <20230116140154.114951-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 tiwai@suse.com, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 daniel.baluta@nxp.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@chromium.org>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 sound-open-firmware@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit d185e0689abc98ef55fb7a7d75aa0c48a0ed5838 ]

When the DSP is suspended while the firmware is in the crashed state, we
skip tearing down the pipelines. This means that the widget reference
counts will not get to reset to 0 before suspend. This will lead to
errors with resuming audio after system resume. To fix this, invoke the
tear_down_all_pipelines op before skipping to DSP suspend.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20221220125629.8469-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 5f88c4a01fa3..8722bbd7fd3d 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -192,6 +192,9 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	if (runtime_suspend && !sof_ops(sdev)->runtime_suspend)
 		return 0;
 
+	if (tplg_ops && tplg_ops->tear_down_all_pipelines)
+		tplg_ops->tear_down_all_pipelines(sdev, false);
+
 	if (sdev->fw_state != SOF_FW_BOOT_COMPLETE)
 		goto suspend;
 
@@ -216,9 +219,6 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 		goto suspend;
 	}
 
-	if (tplg_ops->tear_down_all_pipelines)
-		tplg_ops->tear_down_all_pipelines(sdev, false);
-
 	/* suspend DMA trace */
 	sof_fw_trace_suspend(sdev, pm_state);
 
-- 
2.35.1


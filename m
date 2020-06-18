Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D1C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53108221EE
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sTUffjK0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKLacmhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53108221EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE80D1697;
	Thu, 18 Jun 2020 03:12:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE80D1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592442823;
	bh=4qBR61r3nM6bdJZcmW6Y39cAB3ZUpIlI9O50ZJzCDrE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sTUffjK0EPg7YCt9aFbrR/61f6xZYLhifQzLLYRMDodHZeRV01rsdRq8mjkju6TuU
	 Ddwo0N12G6DhhG3thWAjerXjQJkf3YYfe9W5P27NBE5nqP+atYWMfZ4MluNGqL8Pr0
	 V4t7ZXDKL1K4ratcHZl9SCU/iDJJY7hgJO2ErAI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29D29F801D9;
	Thu, 18 Jun 2020 03:09:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D50C5F8025F; Thu, 18 Jun 2020 03:09:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 921ACF80171;
 Thu, 18 Jun 2020 03:09:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 921ACF80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GKLacmhr"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 121BC21D7B;
 Thu, 18 Jun 2020 01:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442559;
 bh=4qBR61r3nM6bdJZcmW6Y39cAB3ZUpIlI9O50ZJzCDrE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GKLacmhr/x34DIiETgiaYugUxWvufWTR/Z9iiLlAMrFySa6H6lc+okRCRo9Dr8Jom
 4CY4fLbFdVNNMm1inSaAPBvVJx4Kuy5vAmOPsHSctALYEQzhJmOxueMGVDeKu5Z2Zd
 i9Hl9zWP1mcVYf64NGIFvsh+5sSUqT92Y64bNt0o=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 055/388] ASoC: SOF: Do nothing when DSP PM
 callbacks are not set
Date: Wed, 17 Jun 2020 21:02:32 -0400
Message-Id: <20200618010805.600873-55-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 sound-open-firmware@alsa-project.org
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

From: Daniel Baluta <daniel.baluta@nxp.com>

[ Upstream commit c26fde3b15ed41f5f452f1da727795f787833287 ]

This provides a better separation between runtime and PM sleep
callbacks.

Only do nothing if given runtime flag is set and calback is not set.

With the current implementation, if PM sleep callback is set but runtime
callback is not set then at runtime resume we reload the firmware even
if we do not support runtime resume callback.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20200515135958.17511-2-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index c410822d9920..01d83ddc16ba 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -90,7 +90,10 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 	int ret;
 
 	/* do nothing if dsp resume callbacks are not set */
-	if (!sof_ops(sdev)->resume || !sof_ops(sdev)->runtime_resume)
+	if (!runtime_resume && !sof_ops(sdev)->resume)
+		return 0;
+
+	if (runtime_resume && !sof_ops(sdev)->runtime_resume)
 		return 0;
 
 	/* DSP was never successfully started, nothing to resume */
@@ -175,7 +178,10 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	int ret;
 
 	/* do nothing if dsp suspend callback is not set */
-	if (!sof_ops(sdev)->suspend)
+	if (!runtime_suspend && !sof_ops(sdev)->suspend)
+		return 0;
+
+	if (runtime_suspend && !sof_ops(sdev)->runtime_suspend)
 		return 0;
 
 	if (sdev->fw_state != SOF_FW_BOOT_COMPLETE)
-- 
2.25.1


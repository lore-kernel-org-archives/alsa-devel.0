Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E98C7EE23
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 15:04:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2579828;
	Thu, 18 May 2023 17:04:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2579828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684422290;
	bh=80c2bgdvmHbS1lxXVpKM2KVfCpBgitmwrxKWwZ6FygY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Sa8ZZSArIYtCQeJVo8tfjtDk27SSGMGXkwAqtXq+tKR6BUIJAOF51EtqznJ4ymCGJ
	 YbCJyVLNFivGsM8wV5UjwOWlLl15Xbzo+eGYZ6VjjWJauoUa2PRR/dUYLwsR0u3h1U
	 lDI6Xy6RtdEetdMvr29PZinrgCAt7d1EWDoVXTGE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A75CF80570; Thu, 18 May 2023 17:03:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8469CF8056F;
	Thu, 18 May 2023 17:03:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6CFD4F802E8; Thu, 18 May 2023 17:03:01 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 60DE6F80272
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 17:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60DE6F80272
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=DcfYb17z
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IBl9Gl018534;
	Thu, 18 May 2023 10:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=9VFpFPgEoHqPkXngB8mLww3M78YV7Ay78b5OSGxLAQk=;
 b=DcfYb17zHbduk9hIZzU4/KoI+Me+3J1g5gzmOFm2ekHSH064b2f79mpoSdYYysFj9SDN
 GxzdwcZ7SewgW9p7TGNsJ3lEEEnSfixwjkd5SKxyzaA/EgzApkjiieNw8UztKnGt4tpJ
 yhRxawyrFtpOWIwO7TI7FY1ozX1BGqDBQRikanySPyMP1z6peCsDkamqqzYgeptotUsw
 HRCN5mnwcYjqtdIxFbhS0dIx3dLyRJ/B5QjhsBhCBumzQLvKT7rpkolF692etOg0biZa
 gpqGyP9Dbxa9mZmOgn0r9Gnsu0TAyNFSeX3XxRgL8P1KQQSBxXOeapfwvkepK6Wrj+Er OQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qngq1ghum-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 May 2023 10:02:52 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 10:02:50 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 18 May 2023 10:02:50 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com
 [198.90.251.127])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 36FA9468;
	Thu, 18 May 2023 15:02:50 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: cs35l56: sdw_write_no_pm() should be performed
 under a pm_runtime request
Date: Thu, 18 May 2023 16:02:49 +0100
Message-ID: <20230518150250.1121006-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230518150250.1121006-1-rf@opensource.cirrus.com>
References: <20230518150250.1121006-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HeMTtZiSETusfRvKc2rfNgNW62xe9dvb
X-Proofpoint-ORIG-GUID: HeMTtZiSETusfRvKc2rfNgNW62xe9dvb
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: HJO3AL6UYHFKZNNIU5NXJ5EEH4BU245Q
X-Message-ID-Hash: HJO3AL6UYHFKZNNIU5NXJ5EEH4BU245Q
X-MailFrom: prvs=05023014f4=rf@opensource.cirrus.com
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Simon Trimmer <simont@opensource.cirrus.com>

SoundWire bus accesses must be performed under the guard of a pm_runtime
request, in this case the write was being performed just after the
request had been put() and so the bus could not be guaranteed to be
available.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 906aa416879b..255c442308f2 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -904,15 +904,15 @@ static void cs35l56_dsp_work(struct work_struct *work)
 err_unlock:
 	mutex_unlock(&cs35l56->irq_lock);
 err:
-	pm_runtime_mark_last_busy(cs35l56->dev);
-	pm_runtime_put_autosuspend(cs35l56->dev);
-
 	/* Re-enable SoundWire interrupts */
 	if (cs35l56->sdw_peripheral) {
 		cs35l56->sdw_irq_no_unmask = false;
 		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
 				CS35L56_SDW_INT_MASK_CODEC_IRQ);
 	}
+
+	pm_runtime_mark_last_busy(cs35l56->dev);
+	pm_runtime_put_autosuspend(cs35l56->dev);
 }
 
 static int cs35l56_component_probe(struct snd_soc_component *component)
-- 
2.30.2


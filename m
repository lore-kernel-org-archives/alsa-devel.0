Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE26C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 13:11:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D38622B40
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 13:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D38622B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50543181C;
	Mon, 18 Jan 2021 14:10:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50543181C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610975490;
	bh=cRVa3c27xZO5WyeB8yyZWbP053+sFN355aGU+6TbT4M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dZ2sX4RUnLIwEomFEhf7xTUaKBHXEJO6EQgQYNTRBCUfahM2ITvNK82ay+AsDhuRX
	 vcDgyZAQxqQDsLR35NKyDHpwjMGan+V6Vu2Di/7PGajtN/sEnFz+dja2+9vtMB/Xeh
	 ZKkmIaBGTK+ctSqbYkEgofUCHmc1KI/CLQ/Humk0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE88DF80166;
	Mon, 18 Jan 2021 14:10:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99906F8016E; Mon, 18 Jan 2021 14:10:38 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8FF7F800C0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 14:10:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8FF7F800C0
Received: from 1.general.khfeng.us.vpn ([10.172.68.174] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1l1UHy-0005VN-Be; Mon, 18 Jan 2021 13:09:47 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda: Balance runtime/system PM if direct-complete is
 disabled
Date: Mon, 18 Jan 2021 21:09:36 +0800
Message-Id: <20210118130937.164650-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Harsha Priya <harshapriya.n@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Kenneth R . Crudup" <kenny@panix.com>
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

HDA controller can't be runtime-suspended after commit 215a22ed31a1
("ALSA: hda: Refactor codjc PM to use direct-complete optimization"),
which enables direct-complete for HDA codec.

The HDA codec driver didn't expect direct-complete will be disabled
after it returns a positive value from prepare() callback. However,
there are some places that PM core can disable direct-complete. For
instance, system hibernation or when codec has subordinates like LEDs.

So if a device is prepared for direct-complete but PM core still calls
codec's suspend or freeze callback, resume the device to keep PM
operations balanced.

Reported-by: Kenneth R. Crudup <kenny@panix.com>
Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_codec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 687216e74526..0afbced979df 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2997,6 +2997,9 @@ static void hda_codec_pm_complete(struct device *dev)
 
 static int hda_codec_pm_suspend(struct device *dev)
 {
+	if (pm_runtime_status_suspended(dev))
+		pm_runtime_resume(dev);
+
 	dev->power.power_state = PMSG_SUSPEND;
 	return hda_codec_suspend(dev);
 }
@@ -3009,6 +3012,9 @@ static int hda_codec_pm_resume(struct device *dev)
 
 static int hda_codec_pm_freeze(struct device *dev)
 {
+	if (pm_runtime_status_suspended(dev))
+		pm_runtime_resume(dev);
+
 	dev->power.power_state = PMSG_FREEZE;
 	return hda_codec_suspend(dev);
 }
-- 
2.29.2


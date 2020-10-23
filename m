Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142A9C388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:26:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1AA2225F
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QBcNaQI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1AA2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 483741826;
	Fri, 23 Oct 2020 12:25:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 483741826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603448793;
	bh=SlC15PvOs5+yd9b30E0wo8vKJj1yxTWsIR0wnbIarH8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QBcNaQI0k8zEDwCZPBvi8QfDWMXcXZD8bmNfUjawf1cybrByI9xNb4vJtjwhHnrRw
	 qgXGhywcevgQkNlAfdcuwy13KsFbvvyGwG8oBzzHjXgluwk8DsWXZkTOGSu/CIsCot
	 g3kuGUpcVMdchwRLaRB1ZhfDaEvtDEMhmJt4moAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E620F804B0;
	Fri, 23 Oct 2020 12:24:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 323BFF804BC; Fri, 23 Oct 2020 12:24:21 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CD3AF804B0
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 12:24:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CD3AF804B0
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1kVuEc-0006Qf-2U; Fri, 23 Oct 2020 10:23:46 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH 1/4] ALSA: hda: Refactor codec PM to use direct-complete
 optimization
Date: Fri, 23 Oct 2020 18:23:35 +0800
Message-Id: <20201023102340.25494-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Harsha Priya <harshapriya.n@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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

Upon system resume, hda_codec_pm_resume() uses hda_codec_force_resume()
to resume the codec. However, pm_runtime_force_resume() won't really
resume the codec because of pm_runtime_need_not_resume() check.

Hence, hda_codec_force_resume() schedules a jackpoll work, which is to
really power up the codec.

Instead of doing that, we can use direct-complete to make the PM flow
more straightforward, and keep codec always suspended through system PM
flow if conditions are met.

On system suspend, PM core will decide what to do based on
hda_codec_pm_prepare():
- If codec is not runtime-suspended, PM core will suspend and resume the
device as normal.
- If codec is runtime-suspended, PM core will try to keep it suspended.
If it's still suspended after system resume, we use
hda_codec_pm_complete() to resume codec if it's needed.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_codec.c | 45 +++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index a356c21edb90..c2a510cc81bb 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2934,7 +2934,7 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	snd_hdac_leave_pm(&codec->core);
 }
 
-static int hda_codec_runtime_suspend(struct device *dev)
+static int hda_codec_suspend(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 	unsigned int state;
@@ -2953,7 +2953,7 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int hda_codec_runtime_resume(struct device *dev)
+static int hda_codec_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
@@ -2967,57 +2967,70 @@ static int hda_codec_runtime_resume(struct device *dev)
 	pm_runtime_mark_last_busy(dev);
 	return 0;
 }
+
+static int hda_codec_runtime_suspend(struct device *dev)
+{
+	return hda_codec_suspend(dev);
+}
+
+static int hda_codec_runtime_resume(struct device *dev)
+{
+	return hda_codec_resume(dev);
+}
+
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
-static int hda_codec_force_resume(struct device *dev)
+static int hda_codec_pm_prepare(struct device *dev)
+{
+	return pm_runtime_suspended(dev);
+}
+
+static void hda_codec_pm_complete(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
-	int ret;
 
-	ret = pm_runtime_force_resume(dev);
-	/* schedule jackpoll work for jack detection update */
-	if (codec->jackpoll_interval ||
-	    (pm_runtime_suspended(dev) && hda_codec_need_resume(codec)))
-		schedule_delayed_work(&codec->jackpoll_work,
-				      codec->jackpoll_interval);
-	return ret;
+	if (pm_runtime_suspended(dev) &&
+	    (hda_codec_need_resume(codec) || codec->forced_resume))
+		pm_request_resume(dev);
 }
 
 static int hda_codec_pm_suspend(struct device *dev)
 {
 	dev->power.power_state = PMSG_SUSPEND;
-	return pm_runtime_force_suspend(dev);
+	return hda_codec_suspend(dev);
 }
 
 static int hda_codec_pm_resume(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESUME;
-	return hda_codec_force_resume(dev);
+	return hda_codec_resume(dev);
 }
 
 static int hda_codec_pm_freeze(struct device *dev)
 {
 	dev->power.power_state = PMSG_FREEZE;
-	return pm_runtime_force_suspend(dev);
+	return hda_codec_suspend(dev);
 }
 
 static int hda_codec_pm_thaw(struct device *dev)
 {
 	dev->power.power_state = PMSG_THAW;
-	return hda_codec_force_resume(dev);
+	return hda_codec_resume(dev);
 }
 
 static int hda_codec_pm_restore(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESTORE;
-	return hda_codec_force_resume(dev);
+	return hda_codec_resume(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
 
 /* referred in hda_bind.c */
 const struct dev_pm_ops hda_codec_driver_pm = {
 #ifdef CONFIG_PM_SLEEP
+	.prepare = hda_codec_pm_prepare,
+	.complete = hda_codec_pm_complete,
 	.suspend = hda_codec_pm_suspend,
 	.resume = hda_codec_pm_resume,
 	.freeze = hda_codec_pm_freeze,
-- 
2.17.1


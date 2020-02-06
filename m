Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB87FC33CAC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:30:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55811214AF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pX4smlZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55811214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5252F16A1;
	Thu,  6 Feb 2020 17:29:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5252F16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581006601;
	bh=9lesVmqNWvzZyJ1qMwH+UprPWdbIYlG+ymQIvdaVmdw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pX4smlZhmAnam9H/CUPBQnb04kDZXlSG6jgPF+oGYbkl52XiqR2hhL8hGxtCoPKxj
	 29SzetEZBT4/iZKRbCAUKb+QxcdfZl6Tfgfmmgc6IE/rFa075VT5fbLoONG5kuvHgM
	 Sfj8hrLtsmBC94/xC0ePQpVAWCk7yRxRU8oB8q44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFF5AF80248;
	Thu,  6 Feb 2020 17:28:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 907D0F80255; Thu,  6 Feb 2020 17:28:13 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0D3FF80162
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:28:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0D3FF80162
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EC5D7AF32;
 Thu,  6 Feb 2020 16:28:07 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu,  6 Feb 2020 17:28:03 +0100
Message-Id: <20200206162804.4734-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200206162804.4734-1-tiwai@suse.de>
References: <20200206162804.4734-1-tiwai@suse.de>
Cc: Nikhil Mahale <nmahale@nvidia.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH 3/4] ALSA: hda/hdmi: Move runtime PM resume
	into hdmi_present_sense_via_verbs()
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

For improving the readability, move the runtime PM handling code from
hdmi_present_sense() to hdmi_present_sense_via_verbs().  Now
hdmi_present_sense() became symmetric for both audio-component and
legacy cases.

Just a minor code refactoring.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 98a8c4f97d6b..437177294d78 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1587,6 +1587,11 @@ static void hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	 */
 	int present;
 	bool do_repoll = false;
+	int ret;
+
+	ret = snd_hda_power_up_pm(codec);
+	if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec)))
+		goto out;
 
 	present = snd_hda_jack_pin_sense(codec, pin_nid, dev_id);
 
@@ -1620,6 +1625,8 @@ static void hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 		do_update_eld(codec, per_pin, eld);
 
 	mutex_unlock(&per_pin->lock);
+ out:
+	snd_hda_power_down_pm(codec);
 }
 
 /* update ELD and jack state via audio component */
@@ -1657,20 +1664,11 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_codec *codec = per_pin->codec;
-	int ret;
 
-	/* no temporary power up/down needed for component notifier */
-	if (!codec_has_acomp(codec)) {
-		ret = snd_hda_power_up_pm(codec);
-		if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec))) {
-			snd_hda_power_down_pm(codec);
-			return;
-		}
+	if (!codec_has_acomp(codec))
 		hdmi_present_sense_via_verbs(per_pin, repoll);
-		snd_hda_power_down_pm(codec);
-	} else {
+	else
 		sync_eld_via_acomp(codec, per_pin);
-	}
 }
 
 static void hdmi_repoll_eld(struct work_struct *work)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAFDC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:46:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F1421655
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="voKeGAs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F1421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B0241677;
	Mon, 11 Nov 2019 15:45:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B0241677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573483580;
	bh=ZTnUT3iRBtxw/ReSqHKmkJ30QxiFZlO0HGonfUCD5I4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=voKeGAs5YQ57sQkMDk/00nQ4qAjWnXb4KOPPGbxiIOuCfnD9vGVp1PF7HPM9OCb//
	 Lc1ZHepnrws2pRbPC7L97e7jTiUYAin80vJZSfo+g8YMvvWooDPhf/P8VU/6CTNC27
	 V8sv9xdlxeh9YOQWsz08OFrurzMjXUdm7ugRXGj0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E93AF8045D;
	Mon, 11 Nov 2019 15:45:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36902F804FF; Mon, 11 Nov 2019 15:45:28 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24BBBF80275
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 15:45:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24BBBF80275
Received: from [114.253.244.234] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1iUAwV-0001nK-8A; Mon, 11 Nov 2019 14:45:23 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Date: Mon, 11 Nov 2019 22:45:02 +0800
Message-Id: <20191111144502.22910-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: stable@vger.kernel.org
Subject: [alsa-devel] [PATCH] ALSA: hda/hdmi - add a parameter to let users
	decide if checking the eld_valid
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

With the commit 7f641e26a6df ("ALSA: hda/hdmi - Consider eld_valid
when reporting jack event"), the driver checks eld_valid before
reporting Jack state, this fixes the 4 HDMI/DP audio devices issue.

But recently some users complained that the hdmi audio on their
machines couldn't work anymore with this commit. On their machines,
the monitor_present is 1 while the eld_valid is 0 when plugging a
monitor, and the hdmi audio could work even the eld_valid is 0.

To make the hdmi audio work again on those machines, adding a module
parameter, if usrs want to skip the checking eld_valid, they
could set checking_eld_valid=0 when loading the module. And this
parameter only applies to sense_via_verbs, for those getting eld via
component, no need to apply this parameter since it is impossible
that present is 1 while eld_valid is 0.

BugLink: https://bugs.launchpad.net/bugs/1834771
Fixes: 7f641e26a6df ("ALSA: hda/hdmi - Consider eld_valid when reporting jack event")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index be8a977fc684..d70fca4f4411 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -37,6 +37,11 @@ static bool static_hdmi_pcm;
 module_param(static_hdmi_pcm, bool, 0644);
 MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
+static bool checking_eld_valid = true;
+module_param(checking_eld_valid, bool, 0644);
+MODULE_PARM_DESC(checking_eld_valid, "Checking eld_valid before reporting Jack "
+		 "state (default = 1, using verbs only)");
+
 #define is_haswell(codec)  ((codec)->core.vendor_id == 0x80862807)
 #define is_broadwell(codec)    ((codec)->core.vendor_id == 0x80862808)
 #define is_skylake(codec) ((codec)->core.vendor_id == 0x80862809)
@@ -1557,8 +1562,9 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	jack = snd_hda_jack_tbl_get(codec, pin_nid);
 	if (jack) {
 		jack->block_report = !ret;
-		jack->pin_sense = (eld->monitor_present && eld->eld_valid) ?
-			AC_PINSENSE_PRESENCE : 0;
+		if (checking_eld_valid)
+			jack->pin_sense = (eld->monitor_present && eld->eld_valid) ?
+				AC_PINSENSE_PRESENCE : 0;
 	}
 	mutex_unlock(&per_pin->lock);
 	return ret;
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Return-Path: <SRS0=dMuI=H3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB92C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 10:22:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB1764EC8
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 10:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB1764EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72BDB15E0;
	Thu, 25 Feb 2021 11:21:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72BDB15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614248552;
	bh=Mt3wPpETXxMyt16qhDz+HNQLYO0RYq7JTvd9YBq7qyc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oay+T8AMiVFHwRRYICLD85V2DF9bQLaX/T8CQGDRAos64SFp98PQnQcFE/WhvwvmI
	 f/58imU922NgIcUkAgXAWO/A7cy0Jfsahj9KWR0k2tTKkgQ3Qy/ZTpHo0dnexX6G+W
	 qYZQ7QwuAuxEfiBJ8900EYuMROF/EXPXEdB4bwn8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7438F80159;
	Thu, 25 Feb 2021 11:21:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 346B4F8016A; Thu, 25 Feb 2021 11:21:40 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07847F80159
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2021 11:21:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07847F80159
Received: from [123.112.65.122] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1lFDly-0003Cy-Bh; Thu, 25 Feb 2021 10:21:31 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, tiwai@suse.de, kai.vehmanen@linux.intel.com
Subject: [PATCH v2] ALSA: hda/hdmi: let new platforms assign the pcm slot
 dynamically
Date: Thu, 25 Feb 2021 18:20:28 +0800
Message-Id: <20210225102028.41769-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If the platform set the dyn_pcm_assign to true, it will call
hdmi_find_pcm_slot() to find a pcm slot when hdmi/dp monitor is
connected and need to create a pcm.

So far only intel_hsw_common_init() and patch_nvhdmi() set the
dyn_pcm_assign to true, here we let tgl platforms assign the pcm slot
dynamically first, if the driver runs for a period of time and there
is no regression reported, we could set no_fixed_assgin to true in
the intel_hsw_common_init(), and then set it to true in the
patch_nvhdmi().

This change comes from the discussion between Takashi and
Kai Vehmanen. Please refer to:
https://github.com/alsa-project/alsa-lib/pull/118

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
Did the test with this patch on 2 TGL machines, and with both legacy
HDA driver and sof driver, plug 1 monitor into the machine, plug 2
monitors into the machine and plug 2 monitors into a dp-mst hub, they
all worked as expcted, the first 2 pcm slots was assigned to monitors,
and playback worked well.

 sound/pci/hda/patch_hdmi.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 97adff0cbcab..1aca815b920d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -157,6 +157,7 @@ struct hdmi_spec {
 
 	bool dyn_pin_out;
 	bool dyn_pcm_assign;
+	bool no_fixed_assign;
 	bool intel_hsw_fixup;	/* apply Intel platform-specific fixups */
 	/*
 	 * Non-generic VIA/NVIDIA specific
@@ -1345,6 +1346,12 @@ static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
 {
 	int i;
 
+	/* on the new machines, try to assign the pcm slot dynamically,
+	 * not use the preferred fixed map anymore.
+	 */
+	if (spec->no_fixed_assign)
+		goto last_try;
+
 	/*
 	 * generic_hdmi_build_pcms() may allocate extra PCMs on some
 	 * platforms (with maximum of 'num_nids + dev_num - 1')
@@ -1374,6 +1381,7 @@ static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
 			return i;
 	}
 
+ last_try:
 	/* the last try; check the empty slots in pins */
 	for (i = 0; i < spec->num_nids; i++) {
 		if (!test_bit(i, &spec->pcm_bitmap))
@@ -2988,8 +2996,16 @@ static int patch_i915_tgl_hdmi(struct hda_codec *codec)
 	 * the index indicate the port number.
 	 */
 	static const int map[] = {0x4, 0x6, 0x8, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf};
+	int ret;
 
-	return intel_hsw_common_init(codec, 0x02, map, ARRAY_SIZE(map));
+	ret = intel_hsw_common_init(codec, 0x02, map, ARRAY_SIZE(map));
+	if (!ret) {
+		struct hdmi_spec *spec = codec->spec;
+
+		spec->no_fixed_assign = true;
+	}
+
+	return ret;
 }
 
 /* Intel Baytrail and Braswell; with eld notifier */
-- 
2.25.1


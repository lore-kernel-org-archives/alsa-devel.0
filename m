Return-Path: <SRS0=m6EI=ZO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C308EC432C0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:27:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BF72071B
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PzG0FnNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BF72071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A531917E9;
	Fri, 22 Nov 2019 14:26:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A531917E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574429240;
	bh=/vTqyNC1owjfhsKBEc2sgDKa1tWDJykXtT4htXyphpo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PzG0FnNqgxJLcdymSGzM8u8+SlMxwNXHVlBkOd8lJwwq1QUjKxasE1ERPqjz/ExKi
	 fILxPVlGsGBvlHQLForRgzLMxqs+tLxXgM3f1+SuFBuNJnle5Qf2bvUNVrYC7HRNSt
	 adnUL34mPCQgbDDBPMSWM9uWTbzgyZPLN3oivzb0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E469F8013F;
	Fri, 22 Nov 2019 14:26:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21C73F800EF; Fri, 22 Nov 2019 14:26:29 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98C5FF800EF
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 14:26:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98C5FF800EF
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9CD1AAB91
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 13:26:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 22 Nov 2019 14:26:24 +0100
Message-Id: <20191122132624.5482-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: hda/hdmi - Clear codec->relaxed_resume
	flag at unbinding
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

The HDMI codec may leave codec->relaxed_resume flag set even after
unbinding.  Clear it unconditionally.

It's very unlikely that this actually matters in the real use case,
so just a fix for consistency.

Fixes: ade49db337a9 ("ALSA: hda/hdmi - Allow audio component for AMD/ATI and Nvidia HDMI")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 9063bf88689f..bffde594e204 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2361,8 +2361,8 @@ static void generic_hdmi_free(struct hda_codec *codec)
 		snd_hdac_acomp_exit(&codec->bus->core);
 	} else if (codec_has_acomp(codec)) {
 		snd_hdac_acomp_register_notifier(&codec->bus->core, NULL);
-		codec->relaxed_resume = 0;
 	}
+	codec->relaxed_resume = 0;
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

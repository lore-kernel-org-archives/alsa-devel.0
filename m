Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F1BC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 20:13:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35CA60EB8
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 20:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D35CA60EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CD4F16ED;
	Thu, 22 Jul 2021 22:12:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CD4F16ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626984824;
	bh=BUH4g10+F9iuMa9S4xkFsDNK43rKrt3FNu/17b2E0sc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IgcImJ1tmv9kZVOxwCU13G+jehm46PztxSCHduKWJT4x6ar3lDy62wMvpovsL257u
	 KZNb5Fc1Ty7ZZrzfNGx7v7sobuBALxQzwMLx5nGQahxrSGyQ9LsVJ07/uY4wp66gWZ
	 Zek5YQo9I+QwKDhu3Y0fGEIYRn3sW6ijcvD7IkYo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 263E2F804BB;
	Thu, 22 Jul 2021 22:12:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C56DF804DA; Thu, 22 Jul 2021 22:12:13 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3DA2F8049C
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 22:12:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3DA2F8049C
Received: by m.b4.vu (Postfix, from userid 1000)
 id 48EFB611D167; Fri, 23 Jul 2021 05:42:08 +0930 (ACST)
Date: Fri, 23 Jul 2021 05:42:08 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: scarlett2: Fix Direct Monitor control name for 2i2
Message-ID: <faf5de1d2100038e7d07520d770fda4a1adc276a.1626959758.git.g@b4.vu>
References: <cover.1626959758.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626959758.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

The Direct Monitor control for the 2i2 is an enumerated value, not a
boolean. Fix the control name to say "Playback Enum" instead of
"Playback Switch" in this case.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 347995ea39e4..fa604b61066f 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -2530,14 +2530,18 @@ static int scarlett2_add_direct_monitor_ctl(struct usb_mixer_interface *mixer)
 {
 	struct scarlett2_data *private = mixer->private_data;
 	const struct scarlett2_device_info *info = private->info;
+	const char *s;
 
 	if (!info->direct_monitor)
 		return 0;
 
+	s = info->direct_monitor == 1
+	      ? "Direct Monitor Playback Switch"
+	      : "Direct Monitor Playback Enum";
+
 	return scarlett2_add_new_ctl(
 		mixer, &scarlett2_direct_monitor_ctl[info->direct_monitor - 1],
-		0, 1, "Direct Monitor Playback Switch",
-		&private->direct_monitor_ctl);
+		0, 1, s, &private->direct_monitor_ctl);
 }
 
 /*** Speaker Switching Control ***/
-- 
2.31.1


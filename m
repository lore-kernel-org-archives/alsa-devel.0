Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED0FC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 04:15:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5A864F88
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 04:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5A864F88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73A1816E7;
	Fri, 12 Mar 2021 05:14:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73A1816E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615522519;
	bh=abQe6S4XU0mfxQFxQyCRdJ6KZ+mp8x2Oi92IhOLWSFY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cr9Jrd4U/1o/zcBBihsoTVZiYZWSH0cyKYHcbRA606TGwXbxlCFpZ68/6WybX+37H
	 TsjS1UmtIA3dd0XjQ2+BOJ+B/CefK8KdeklbcAUzxGgKUdQTchnpVIZ2L8GjWeTtKm
	 9jarHCB09uzpTUf1ciJ9xPM9w7JdplWLHTGIXAzU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8251F8016C;
	Fri, 12 Mar 2021 05:14:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1BDEF801D8; Fri, 12 Mar 2021 05:14:27 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71D5DF8012A
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 05:14:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71D5DF8012A
Received: from [103.229.218.199] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1lKZBl-0000MM-8E; Fri, 12 Mar 2021 04:14:13 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: generic: Fix the micmute led init state
Date: Fri, 12 Mar 2021 12:14:08 +0800
Message-Id: <20210312041408.3776-1-hui.wang@canonical.com>
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

Recently we found the micmute led init state is not correct after
freshly installing the ubuntu linux on a Lenovo AIO machine. The
internal mic is not muted, but the micmute led is on and led mode is
'follow mute'. If we mute internal mic, the led is keeping on, then
unmute the internal mic, the led is off. And from then on, the
micmute led will work correctly.

So the micmute led init state is not correct. The led is controlled
by codec gpio (ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY), in the
patch_realtek, the gpio data is set to 0x4 initially and the led is
on with this data. In the hda_generic, the led_value is set to
0 initially, suppose users set the 'capture switch' to on from
user space and the micmute led should change to be off with this
operation, but the check "if (val == spec->micmute_led.led_value)" in
the call_micmute_led_update() will skip the led setting.

To guarantee the led state will be set by the 1st time of changing
"Capture Switch", set -1 to the init led_value.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8b7c5508f368..f5cba7afd1c6 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4065,7 +4065,7 @@ static int add_micmute_led_hook(struct hda_codec *codec)
 
 	spec->micmute_led.led_mode = MICMUTE_LED_FOLLOW_MUTE;
 	spec->micmute_led.capture = 0;
-	spec->micmute_led.led_value = 0;
+	spec->micmute_led.led_value = -1;
 	spec->micmute_led.old_hook = spec->cap_sync_hook;
 	spec->cap_sync_hook = update_micmute_led;
 	if (!snd_hda_gen_add_kctl(spec, NULL, &micmute_led_mode_ctl))
-- 
2.25.1


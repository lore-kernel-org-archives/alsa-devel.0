Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F8C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 02:18:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7E42068F
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 02:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WsNBnkfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7E42068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6C8815F2;
	Mon, 10 Aug 2020 04:17:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6C8815F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597025898;
	bh=MJUaMC5gHnDDf8NOyGCbKQnriS489SHAS13rsGUP8HM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WsNBnkfp/JnhDX+r5m8enhiFn7tq0geGbjdhegkiSUEivRqeJQKWj+AlBWu8mPz/N
	 Z4GtTFe1HUePm6BGaO9zls1C7yi2jPFNCUjoXSgc2jE6ifzW3ATBuYnwPMrtxnEPlF
	 NDowwRAKst7Itr/uEDJYlAaMtchSY/nPuextG/f4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C1CDF801DB;
	Mon, 10 Aug 2020 04:17:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00E99F8022B; Mon, 10 Aug 2020 04:17:25 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 496A7F80085
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 04:17:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 496A7F80085
Received: from [114.253.245.60] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1k4xND-0004kJ-HA; Mon, 10 Aug 2020 02:17:16 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda - fix the micmute led status for Lenovo ThinkCentre
 AIO
Date: Mon, 10 Aug 2020 10:16:59 +0800
Message-Id: <20200810021659.7429-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: stable@vger.kernel.org
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

After installing the Ubuntu Linux, the micmute led status is not
correct. Users expect that the led is on if the capture is disabled,
but with the current kernel, the led is off with the capture disabled.

We tried the old linux kernel like linux-4.15, there is no this issue.
It looks like we introduced this issue when switching to the led_cdev.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index daedcc0adc21..09d93dd88713 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4414,6 +4414,7 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 
+	spec->micmute_led_polarity = 1;
 	alc_fixup_hp_gpio_led(codec, action, 0, 0x04);
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->init_amp = ALC_INIT_DEFAULT;
-- 
2.17.1


Return-Path: <SRS0=QmEo=5X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC5FC2BA16
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:46:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E4320730
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hp9DVZA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E4320730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AF891662;
	Tue,  7 Apr 2020 10:45:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AF891662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586249202;
	bh=hj+ubEkaSw6ANRUBahXu9D7oKx/2/7lCAc9vkA85K8U=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hp9DVZA+3yZtKYR3AoKcMi1LnkQm6G5hyKFFRIbF72C/DWXMSw7MtSn7gqjCfbU69
	 whX2K+26Tr05ZPrbtV3u81Z3VTKUcGZoxoofnyWwVXT8q8pPoAGm+2mHBbB5QOTuym
	 NbsCUGPnvrSSKI4dn6i0qAdKPZhMwm4+FgMKkxMI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D08C0F80278;
	Tue,  7 Apr 2020 10:44:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBCD1F801D8; Tue,  7 Apr 2020 10:44:10 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D49AF801DA
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2020 10:44:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D49AF801DA
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 27E2FAEA4
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2020 08:44:03 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: ice1724: Fix invalid access for enumerated ctl items
Date: Tue,  7 Apr 2020 10:44:02 +0200
Message-Id: <20200407084402.25589-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200407084402.25589-1-tiwai@suse.de>
References: <20200407084402.25589-1-tiwai@suse.de>
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

The access to Analog Capture Source control value implemented in
prodigy_hifi.c is wrong, as caught by the recently introduced sanity
check; it should be accessing value.enumerated.item[] instead of
value.integer.value[].  This patch corrects the wrong access pattern.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207139
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ice1712/prodigy_hifi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index 91f83cef0e56..9aa12a67d370 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -536,7 +536,7 @@ static int wm_adc_mux_enum_get(struct snd_kcontrol *kcontrol,
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 
 	mutex_lock(&ice->gpio_mutex);
-	ucontrol->value.integer.value[0] = wm_get(ice, WM_ADC_MUX) & 0x1f;
+	ucontrol->value.enumerated.item[0] = wm_get(ice, WM_ADC_MUX) & 0x1f;
 	mutex_unlock(&ice->gpio_mutex);
 	return 0;
 }
@@ -550,7 +550,7 @@ static int wm_adc_mux_enum_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&ice->gpio_mutex);
 	oval = wm_get(ice, WM_ADC_MUX);
-	nval = (oval & 0xe0) | ucontrol->value.integer.value[0];
+	nval = (oval & 0xe0) | ucontrol->value.enumerated.item[0];
 	if (nval != oval) {
 		wm_put(ice, WM_ADC_MUX, nval);
 		change = 1;
-- 
2.25.0


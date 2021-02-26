Return-Path: <SRS0=9dS2=H4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE9C43381
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 14:41:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB85964F0E
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 14:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB85964F0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4436C1662;
	Fri, 26 Feb 2021 15:40:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4436C1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614350492;
	bh=8I1pZMLzT7g3uIi8Tdz7bHdKJDHI57Ne+G6Iy/kS98Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kibO1cPHRZ9flocREavuaPIgKtkubd6pjhngbEiphmW75OzSHa/mAzEK5XXUcA+4H
	 cY/njAW5tUZw/q/EBTuG9ZOUJVe7IwN+WgxDfUG6GIDGhPUTicRhdPMW58M3dIkunj
	 BHgmT692PJ5qpTcugog9fkE829BB5/UosvxCBLeA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C07FFF8032C;
	Fri, 26 Feb 2021 15:38:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07CF7F802E0; Fri, 26 Feb 2021 15:38:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA997F8016C
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2021 15:38:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA997F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="CkuLTh4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614350316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=db/O0GI+Fd2zObLf0mZVhSQcHXvdraAQssaAgMP0tbo=;
 b=CkuLTh4ULemBxyBN/O9riCyVKls1e2rvil9FQs7tSb39DKS3IReI+tW5Tl/bKBo0UzlOAI
 /NC2NVLFZ3AHnyTTJQgXt6mQXWofsj7SG4SGBW2X+9xYCKxgpXWWi9IxIaYe9F5bI+c2oe
 hOQfSjJwmV1tA0fsPYkfdLn55VFK+pU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-SXErfc-yPuefjIlvrPZsMQ-1; Fri, 26 Feb 2021 09:38:31 -0500
X-MC-Unique: SXErfc-yPuefjIlvrPZsMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 059B0107ACE6;
 Fri, 26 Feb 2021 14:38:30 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69B0D5D9D2;
 Fri, 26 Feb 2021 14:38:28 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] ASoC: rt5640: Rename 'Mono DAC Playback Volume' to 'DAC2
 Playback Volume'
Date: Fri, 26 Feb 2021 15:38:16 +0100
Message-Id: <20210226143817.84287-5-hdegoede@redhat.com>
In-Reply-To: <20210226143817.84287-1-hdegoede@redhat.com>
References: <20210226143817.84287-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Oder Chiou <oder_chiou@realtek.com>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org
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

Rename 'Mono DAC Playback Volume' to 'DAC2 Playback Volume' and move it
from rt5640_specific_snd_controls[] to rt5640_snd_controls[].

The RT5640_DAC2_DIG_VOL register controlled by this mixer-element has
nothing to do with the Mono (Amplified) output which is only available
on the ALC5640 chip and not on the ALC5642 chip.

The RT5640_DAC2_DIG_VOL volume-control is the main volume control for
audio coming from the I2S2 / AIF2 input of the chip and as such is also
available on the ALC5642.

This commit results in the following userspace visible changes:

1. On devices with an ACL5640 codec, the 'Mono DAC Playback Volume'
control is renamed to 'DAC2 Playback Volume' allowing the alsa-lib
mixer code to properly group it with the 'DAC2 Playback Switch' which
is controlling the mute bits in the RT5640_DAC2_DIG_VOL register.

Note the removal of the 'Mono DAC Playback Volume' is not an issue for
userspace because the UCM profiles do not use it (the UCM profiles are
shared betweent the 5640 and 5642 and only the 5640 had this control).

2. On devices with an ACL5642 codec, there now will be a new
'DAC2 Playback Volume', grouped with the 'DAC2 Playback Switch'

Having a complete 'DAC2 Playback Volume' / 'DAC2 Playback Switch' pair
on both variants will allow enabling hardware-volume control by
setting the UCM PlaybackMasterElem to "DAC2" on devices where the
I2S2/AIF2 interface of the codec is used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index c143ca174921..38cc3155bf25 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -450,6 +450,9 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 	/* DAC Digital Volume */
 	SOC_DOUBLE("DAC2 Playback Switch", RT5640_DAC2_CTRL,
 		RT5640_M_DAC_L2_VOL_SFT, RT5640_M_DAC_R2_VOL_SFT, 1, 1),
+	SOC_DOUBLE_TLV("DAC2 Playback Volume", RT5640_DAC2_DIG_VOL,
+			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
+			175, 0, dac_vol_tlv),
 	SOC_DOUBLE_EXT("DAC1 Playback Switch", SND_SOC_NOPM, 0, 1, 1, 0,
 			rt5640_dac1_playback_switch_get, rt5640_dac1_playback_switch_put),
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5640_DAC1_DIG_VOL,
@@ -495,9 +498,6 @@ static const struct snd_kcontrol_new rt5640_specific_snd_controls[] = {
 	/* MONO Output Control */
 	SOC_SINGLE("Mono Playback Switch", RT5640_MONO_OUT, RT5640_L_MUTE_SFT,
 		1, 1),
-
-	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5640_DAC2_DIG_VOL,
-		RT5640_L_VOL_SFT, RT5640_R_VOL_SFT, 175, 0, dac_vol_tlv),
 };
 
 /**
-- 
2.30.1


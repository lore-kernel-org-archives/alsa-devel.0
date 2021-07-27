Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDBC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:22:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B5561A0D
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2B5561A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F1B11F0F;
	Tue, 27 Jul 2021 15:21:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F1B11F0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627392159;
	bh=B9xYAL/8m8xchTS/11Noy/LV1czP1hU/TtmNdYqMCos=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zm213hJBFt4Ij1g8kd0Ra/1o/MdqY5fQ6nU5kn86ebUz1IAgap2WQMrrxHsMXV7Np
	 xc4DypC/NWY7Ah4M0Suy1zwX3eY3w0AEKJZ9fmM8hMPLpgz0kwvlbZhrXvaKxQhXcb
	 OjprQmj4RiHgbyCmDcP4WyszNL9hRmxXwl7Iua4U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8C95F804F1;
	Tue, 27 Jul 2021 15:19:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8C26F804F2; Tue, 27 Jul 2021 15:19:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F7D6F804EB
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 15:19:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F7D6F804EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UHgXEZHn"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 664BB61ACF;
 Tue, 27 Jul 2021 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627391989;
 bh=B9xYAL/8m8xchTS/11Noy/LV1czP1hU/TtmNdYqMCos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UHgXEZHnUf6zsxk6YafnlO8N1n4Z9JN2PewHMnDkr9ByTNnnSXxrowRMeHNM/YIkc
 9rYa7nQ+ygd5DEVl1KXiCm7/KUtdaXhkSelbgnJRAezKVky9Xj+HaS8EPry+5YGADC
 Oena2ZWQpwYsjg96dd3lBu6wKAx5lz7m4hmi5BqO8GxCW1c1nt3MhpK8CABQQ1wCYG
 RrdvmShvLKlrEsNEOipg2zi8Ep2Sm6HgsEka+I1y/Y502ev7/oJn39L1aXTps1DcFQ
 l7aCBclxQRJZjrReuFPpTk0/nWP1GkX/QDt3UJO9UA8vCW/WA3rvHDu3i4ErCFL5mZ
 6q4xCxZvkpZtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/17] ASoC: rt5682: Fix the issue of garbled
 recording after powerd_dbus_suspend
Date: Tue, 27 Jul 2021 09:19:29 -0400
Message-Id: <20210727131938.834920-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727131938.834920-1-sashal@kernel.org>
References: <20210727131938.834920-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

From: Oder Chiou <oder_chiou@realtek.com>

[ Upstream commit 6a503e1c455316fd0bfd8188c0a62cce7c5525ca ]

While using the DMIC recording, the garbled data will be captured by the
DMIC. It is caused by the critical power of PLL closed in the jack detect
function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Link: https://lore.kernel.org/r/20210716085853.20170-1-oder_chiou@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index d9878173ff89..2e41b8c169e5 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -971,10 +971,14 @@ int rt5682_headset_detect(struct snd_soc_component *component, int jack_insert)
 		rt5682_enable_push_button_irq(component, false);
 		snd_soc_component_update_bits(component, RT5682_CBJ_CTRL_1,
 			RT5682_TRIG_JD_MASK, RT5682_TRIG_JD_LOW);
-		if (!snd_soc_dapm_get_pin_status(dapm, "MICBIAS"))
+		if (!snd_soc_dapm_get_pin_status(dapm, "MICBIAS") &&
+			!snd_soc_dapm_get_pin_status(dapm, "PLL1") &&
+			!snd_soc_dapm_get_pin_status(dapm, "PLL2B"))
 			snd_soc_component_update_bits(component,
 				RT5682_PWR_ANLG_1, RT5682_PWR_MB, 0);
-		if (!snd_soc_dapm_get_pin_status(dapm, "Vref2"))
+		if (!snd_soc_dapm_get_pin_status(dapm, "Vref2") &&
+			!snd_soc_dapm_get_pin_status(dapm, "PLL1") &&
+			!snd_soc_dapm_get_pin_status(dapm, "PLL2B"))
 			snd_soc_component_update_bits(component,
 				RT5682_PWR_ANLG_1, RT5682_PWR_VREF2, 0);
 		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_3,
-- 
2.30.2


Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAD3C5479D
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jan 2023 09:25:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A4FA8E3D;
	Mon,  2 Jan 2023 10:24:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A4FA8E3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672651544;
	bh=xTMv5JUHicduEdQvWBtwgf9/9AHFhjep8wDmhHVNTUE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=W2fLdwUwKTq4RS9bdP5J/fhhr/dgGJo0NyL19mu5wXEVysVH/SQnJy10AN3NTUjc6
	 S0SQ8AX6RFHj3CDrlednBJZQ3DZ2qmD64WkMiXkqlwYIUlFMl8VYYR+44k6DSU1kOX
	 9QPghdyZnyx/umEKmd0iIL3iI+8A0HS33EcTGy+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDA03F8032D;
	Mon,  2 Jan 2023 10:24:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40131F804E4; Sat, 31 Dec 2022 07:15:55 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FCBCF80144
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2022 07:15:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FCBCF80144
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Nt1W8xTd
Received: by mail-pj1-x1036.google.com with SMTP id ge16so20706384pjb.5
 for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2022 22:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XTxSay/i9WQ4dxCAUT2dz6zIVT7ol76fefUCP0UN/RM=;
 b=Nt1W8xTdkGOYoPUijeeuX8s4YIjNS2wjWPGIyapdWzeqemIj3EnvavGfK5yJYT95i0
 q1Xb2UUL+WsnClwsFDvV/I3ww6sSYUid/tq0a8c4Z6jFPSvFDF3G8izJLvOTJumsio9R
 sdmxRR6yFMPHG+TwKlpBCuXpxbtw42seDida5Km+OW13zKdEYsXfd3PmlKEleJPTnfIz
 ga1fdyNStt2/EP2zhi+2CKsjxd9mLyMwrqIQH0IKDEvtosZ6EEji1Z8vHEp1GnBGBJNi
 MwIh80/BKyODFDtbBPp98hZrRpU2CRAcGSnpGmIlOJwmLjyu1PRC1o7Lvp3LlDxPVT7c
 rZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XTxSay/i9WQ4dxCAUT2dz6zIVT7ol76fefUCP0UN/RM=;
 b=gYw2Ps4zSrUxI9FY127tjcM1T+eCFB+12WXTHnN2w6SGG4NV2mE5yaObItai+7FKji
 H2abinev12tP+1nJncJxpgmXaJ5f21DL9nHw/zKrTRMunhefYKlS+vmm/Lu9mLLjt50a
 fPDL0dEqDmoB+mlw3H62oJgPHHEVjonW2Gp8xMaQ1T17kdD+ar2rOu1IXeKx9RtqFPez
 xFevYFagnZoooYFrp013oMidUtziiRdxO4dhAmnVhy4PaBmPnFYcJaabXkeCa5kDr7I3
 jKloZ77Z13PRRvboUwwhYkc34AQUsXqy6Cdp9+QkHxNCIFxivslZTUvxB9FU1g32Bkmn
 bulg==
X-Gm-Message-State: AFqh2kqSCf+3YMajkb5YsyXKWLH8mCdu17YbM3kKa8aYNCo2EFl0/MVr
 5huzgs8rCyqghN5pbh0PRVA=
X-Google-Smtp-Source: AMrXdXuuW8jn2iRfFI4TbEOIbR62mXJMnebxxJCl1+fnOSYBovjnIRVBN5Woet1CD1g0lWPR63lybQ==
X-Received: by 2002:a17:902:c382:b0:191:4378:ec06 with SMTP id
 g2-20020a170902c38200b001914378ec06mr40443201plg.61.1672467350329; 
 Fri, 30 Dec 2022 22:15:50 -0800 (PST)
Received: from localhost ([2600:1700:38c1:1d7f:f66d:4ff:fe3c:3ceb])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a170902e74400b00176dc67df44sm15977840plf.132.2022.12.30.22.15.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Dec 2022 22:15:49 -0800 (PST)
From: Brian Norris <computersforpeace@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: qcom: lpass-cpu: Fix fallback SD line index handling
Date: Fri, 30 Dec 2022 22:15:45 -0800
Message-Id: <20221231061545.2110253-1-computersforpeace@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Jan 2023 10:24:41 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, Brian Norris <computersforpeace@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

These indices should reference the ID placed within the dai_driver
array, not the indices of the array itself.

This fixes commit 4ff028f6c108 ("ASoC: qcom: lpass-cpu: Make I2S SD
lines configurable"), which among others, broke IPQ8064 audio
(sound/soc/qcom/lpass-ipq806x.c) because it uses ID 4 but we'd stop
initializing the mi2s_playback_sd_mode and mi2s_capture_sd_mode arrays
at ID 0.

Fixes: 4ff028f6c108 ("ASoC: qcom: lpass-cpu: Make I2S SD lines configurable")
Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 sound/soc/qcom/lpass-cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 54353842dc07..dbdaaa85ce48 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -1037,10 +1037,11 @@ static void of_lpass_cpu_parse_dai_data(struct device *dev,
 					struct lpass_data *data)
 {
 	struct device_node *node;
-	int ret, id;
+	int ret, i, id;
 
 	/* Allow all channels by default for backwards compatibility */
-	for (id = 0; id < data->variant->num_dai; id++) {
+	for (i = 0; i < data->variant->num_dai; i++) {
+		id = data->variant->dai_driver[i].id;
 		data->mi2s_playback_sd_mode[id] = LPAIF_I2SCTL_MODE_8CH;
 		data->mi2s_capture_sd_mode[id] = LPAIF_I2SCTL_MODE_8CH;
 	}
-- 
2.39.0


Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034B3C433FE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Nov 2022 12:07:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6ACA1632;
	Thu,  3 Nov 2022 13:06:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6ACA1632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667477241;
	bh=1rjwFSpaDExRWJhMUkqQ4qQ1XrWDpXGwBKv5ivPPQS8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bxg4mAldrFndaHjOMBCLJZ/fQ4/SPJ4/k6906BeTMp8LQrlEq+p923v1FtJ0HTGen
	 sXRfaZ2gojR93NGygAP0bqN8mkQbTqM1Lp321yp46WljS75P6FfhBhnksbbPgpvAsB
	 UlTjHO2jn4dD2lr6uCjiVUbkBu1XBwi8jN3pr994=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57061F80155;
	Thu,  3 Nov 2022 13:06:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6025BF8051E; Thu,  3 Nov 2022 13:06:30 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2937F80155
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2022 13:06:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2937F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lxJmCasm"
Received: by mail-wr1-x42b.google.com with SMTP id bk15so2393876wrb.13
 for <alsa-devel@alsa-project.org>; Thu, 03 Nov 2022 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DLUDsiw05g4Mq+tu60AP2NfJMNxrmmZZAuBLJdj/+ss=;
 b=lxJmCasm1+VP1Qubc/vAFKpv97dE0no8M/PO4B/C4PRfKcBMlc2+R434KHvfFOB3/1
 bOXTL6xQsVrDbSV7UWZIReaB+1spj/zPvxyu0nFm6y3Gah87o/5z+ACj9+jzjj3I+gxW
 HBv+eXtPWCkBJuoaPWtGQXgdaw6hgEn3lWCrg4BqGSba68rjTD2R2AT62cDh8qa2cRrl
 ZilBB1aOl8O7jEvXZ5trIHZLscqN9/EhHTx9BN5LpJnuomX9hBAGwihANJECLWeQjgPa
 ffezZ8VkmQNxJGuBMrN4D9PJkosrgUp4y4CZow+9WJX32YF7E1UevLQQHTwgsMp8tec/
 QGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DLUDsiw05g4Mq+tu60AP2NfJMNxrmmZZAuBLJdj/+ss=;
 b=H6FCx/yx9hlHDv2DwUVzRBjhySDohntck5BiYQUQVuIw5fcMTEzzByy8luGcdbbzmJ
 ifWDR1StFa2AhLh2bSL37HbW+3PY7ZkbBwiELCTQNhVASOvtb9IBnzQPjxsxKYMKZ50e
 TbabhovoQGRAAUn3bk7VXs1b/VxTAEC6j3Floiuyegs8bGCIfBAAwKBopJbCftWvv3RW
 xM+dQLqzkonDYLX9XxBrffNNK9QE2sGiQ3LN8KlbveQNZhN4WglsQCWixH7y9zFZv9g/
 dlThqyzvUAoNrdxLWfoqETImlNTI07QUgASf+luDnK2H2fzjKyk5qDjTfubJyQ1C5KvS
 lKow==
X-Gm-Message-State: ACrzQf2woHoiA4qhOPalsdNHsguYq9CNx+C6x5Hs70EU70FJ3s78pYCm
 qMwBsM02OPImPIiEP48YtI8=
X-Google-Smtp-Source: AMsMyM40p6IC3WQf7nsrHFzJRU6pEK8D3jpJ8vv4G0tC/JBAROZCtVy4eQQpaxeZHxSQE1bKB7AnAQ==
X-Received: by 2002:adf:feca:0:b0:236:b258:c19b with SMTP id
 q10-20020adffeca000000b00236b258c19bmr18014378wrs.57.1667477185703; 
 Thu, 03 Nov 2022 05:06:25 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net.
 [80.193.200.194]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b003b4935f04a4sm1537933wms.5.2022.11.03.05.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 05:06:25 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: cirrus-common: Make const array uid_strings
 static
Date: Thu,  3 Nov 2022 12:06:24 +0000
Message-Id: <20221103120624.72583-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

Don't populate the read-only const array uid_strings on the stack but
instead make it static. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/intel/boards/sof_cirrus_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
index 6e39eda77385..851c516c8f5b 100644
--- a/sound/soc/intel/boards/sof_cirrus_common.c
+++ b/sound/soc/intel/boards/sof_cirrus_common.c
@@ -155,7 +155,7 @@ static const char * const cs35l41_name_prefixes[] = { "WL", "WR", "TL", "TR" };
  */
 static int cs35l41_compute_codec_conf(void)
 {
-	const char * const uid_strings[] = { "0", "1", "2", "3" };
+	static const char * const uid_strings[] = { "0", "1", "2", "3" };
 	unsigned int uid, sz = 0;
 	struct acpi_device *adev;
 	struct device *physdev;
-- 
2.38.1


Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B82C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 02:53:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4D06103B
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 02:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C4D06103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuvoton.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EE0816D9;
	Wed, 27 Oct 2021 04:52:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EE0816D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635303179;
	bh=YvkaweQUfHKLRclE5qw70eYfiExJ6z1kBxOWc8XyJYI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvtLPhhVxlwfAkRtdJgRg1NX5RfjMRQ9+vty59lH1eH/8oYgIjp8+CS0eybU/5YEc
	 bUKYnymFP8Iluyaaa8430VeObA5opHlVfxVs5XV437cwgKeZFXhdWWif2DpXASgqYm
	 Laokk/OsEMoINrPhs973oKGSBmRD3YTpGjV9v0nA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B0E5F8025A;
	Wed, 27 Oct 2021 04:52:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3072F80271; Wed, 27 Oct 2021 04:52:03 +0200 (CEST)
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 72B93F8010A
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 04:51:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72B93F8010A
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
 by maillog.nuvoton.com (Postfix) with ESMTP id 674FA1C81054;
 Wed, 27 Oct 2021 10:51:53 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 27 Oct
 2021 10:51:53 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 27 Oct
 2021 10:51:52 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 27 Oct 2021 10:51:52 +0800
From: David Lin <CTLIN0@nuvoton.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: nau8825: add disable jack detection support
Date: Wed, 27 Oct 2021 10:51:42 +0800
Message-ID: <20211027025142.25898-3-CTLIN0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027025142.25898-1-CTLIN0@nuvoton.com>
References: <20211027025142.25898-1-CTLIN0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotRedirectTo-PP: TRUE
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, SJLIN0@nuvoton.com,
 KCHSU0@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com,
 mac.chiang@intel.com, CTLIN0@nuvoton.com
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

A feature for disabling jack detection support.

Co-developed-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: David Lin <CTLIN0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index c845f19b7c41..a356f26735bd 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1434,6 +1434,13 @@ int nau8825_enable_jack_detect(struct snd_soc_component *component,
 
 	nau8825->jack = jack;
 
+	if (!nau8825->jack) {
+		regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL,
+				   NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R |
+				   NAU8825_SPKR_DWN1L, 0);
+		return 0;
+	}
+
 	/* Ground HP Outputs[1:0], needed for headset auto detection
 	 * Enable Automatic Mic/Gnd switching reading on insert interrupt[6]
 	 */
-- 
2.25.1


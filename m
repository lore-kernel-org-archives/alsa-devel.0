Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E512C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 09:40:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF3861039
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 09:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABF3861039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuvoton.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 331ED16E5;
	Tue, 26 Oct 2021 11:39:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 331ED16E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635241239;
	bh=qS81v83asnbLzaqjg+GdaIrR0+g5O+l9QACk7m0W33Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3PK7/JCwfgYFqxCkvE91Rw5CExdkmN6FgsfiO4s2/w6byq2+bUh+BL+qOYwVwP2K
	 V/rH6EF7DYusIc+LJVLLIItfsUMlHh9ZhDQ0vVRQV8JeaPGWZJTpOuSvWH9kk73uih
	 hR3DBGMvBcsZyoMtZ8h0u1m7jyYO64/Kik0CQ2Fg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AC36F804ED;
	Tue, 26 Oct 2021 11:39:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4151FF804C2; Tue, 26 Oct 2021 11:38:59 +0200 (CEST)
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id C7F34F8014D
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 11:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7F34F8014D
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
 by maillog.nuvoton.com (Postfix) with ESMTP id DE3BD1C810D6;
 Tue, 26 Oct 2021 17:38:42 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 26
 Oct 2021 17:38:42 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 26 Oct 2021 17:38:42 +0800
From: David Lin <CTLIN0@nuvoton.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: nau8825: add disable jack detection support
Date: Tue, 26 Oct 2021 17:38:27 +0800
Message-ID: <20211026093828.4188145-3-CTLIN0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026093828.4188145-1-CTLIN0@nuvoton.com>
References: <20211026093828.4188145-1-CTLIN0@nuvoton.com>
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

Co-Developed-by: Mac Chiang <mac.chiang@intel.com>
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


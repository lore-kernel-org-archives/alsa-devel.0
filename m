Return-Path: <SRS0=S7Ib=7P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB5C433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:45:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2133C20738
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XKwXg9zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2133C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACBB91615;
	Tue,  2 Jun 2020 18:45:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACBB91615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591116353;
	bh=/5uM3r+dDntT8Q3e15Ccyj8Lq7rx//AD74F0XY0PEhU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XKwXg9ziWS1U2I8dyrp3YIy7k6zPYbWIwrS2dBtYUXn8bN+HJs2H1PcpPM9Mt4Ixu
	 qwKw/+xX3bKYrBmodpCzQCGy4G51lWFMqWCavFfzYoTuqnMjzlcjd5aUiPTVr3M7MF
	 fD8serqlgNTNxnVZAMEBGdkZOt5p/TKX2ZSKOCdk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD864F80260;
	Tue,  2 Jun 2020 18:45:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E362F8026F; Tue,  2 Jun 2020 18:45:01 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A344F800BC
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2020 18:44:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A344F800BC
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C70E1B02C;
 Tue,  2 Jun 2020 16:44:56 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: max98390: Fix incorrect printf qualifier
Date: Tue,  2 Jun 2020 18:44:53 +0200
Message-Id: <20200602164453.29925-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Steve Lee <steves.lee@maximintegrated.com>
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

This patch addresses a compile warning:
  sound/soc/codecs/max98390.c:781:3: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘size_t {aka const unsigned int}’ [-Wformat=]

Fixes: a6e3f4f34cdb ("ASoC: max98390: Added Amplifier Driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/max98390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index b9ce44dda886..be7cd0aeb6a6 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -778,7 +778,7 @@ static int max98390_dsm_init(struct snd_soc_component *component)
 	}
 
 	dev_dbg(component->dev,
-		"max98390: param fw size %ld\n",
+		"max98390: param fw size %zd\n",
 		fw->size);
 	dsm_param = (char *)fw->data;
 	dsm_param += MAX98390_DSM_PAYLOAD_OFFSET;
-- 
2.16.4


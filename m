Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5358BC433E1
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567002224D
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ARHqTYnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567002224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DF73166B;
	Thu,  6 Aug 2020 12:51:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DF73166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596711160;
	bh=uM3aWbn0l//3bOT4dbJ3msAvN7EMc3z8z7Vpj7iU3jI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ARHqTYnB1bJHhKqrMaP2LKDRKER1zmr/ljXLNg2F0kWychlYeX+vv4XwXluyYQ8bd
	 8rKS3sqMw2WC1P5d75TudH0D7u95e8ontv+EvHOjcXKIrkmNmsUJV9MRr5O+P4RbmO
	 aKGM96oDABuRJlC0upFyJ229fWg0CZzbANM1Wyn4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 086A9F80150;
	Thu,  6 Aug 2020 12:51:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44ACBF80159; Thu,  6 Aug 2020 12:51:48 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9AA2AF80086
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2020 12:51:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AA2AF80086
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1k3dUk-00067j-86; Thu, 06 Aug 2020 10:51:34 +0000
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb: fix spelling mistake "buss" -> "bus"
Date: Thu,  6 Aug 2020 11:51:34 +0100
Message-Id: <20200806105134.46447-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
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

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a usb_audio_dbg debug message. Also
replace "param" with "parameter".  Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 986145fd2ce0..a4d4d71db55b 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -329,7 +329,7 @@ static int snd_us16x08_bus_put(struct snd_kcontrol *kcontrol,
 		elem->cached |= 1;
 		elem->cache_val[0] = val;
 	} else {
-		usb_audio_dbg(chip, "Failed to set buss param, err:%d\n", err);
+		usb_audio_dbg(chip, "Failed to set bus parameter, err:%d\n", err);
 	}
 
 	return err > 0 ? 1 : 0;
-- 
2.27.0


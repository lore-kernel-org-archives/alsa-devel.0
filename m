Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FEBC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 20:16:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF46D613A6
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 20:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF46D613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC1B016E0;
	Wed, 29 Sep 2021 22:15:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC1B016E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632946575;
	bh=2KclBw50khSQkj6tyu4H9AfGqDlkoEqTFLZFaUw9J+8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qjqf5pQRydNGbCB9Rx14GBUumu9GLERsnI74O720WUUjHvGjv/sm4pdfpalNQCIc9
	 U1yQqdC6NbgKGAiJ/36Pb0xC+3ZegfCLGqe/Wd4zMz3NmQ8/XcaNnXeLFpbHTdwaxP
	 bVGZGAtC8WtEoid8NaqSs3sqhJAIyeuG+Z6lRoCs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AF58F80161;
	Wed, 29 Sep 2021 22:15:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6FFA2F80227; Wed, 29 Sep 2021 22:15:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7AF5F80161
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 22:15:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7AF5F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="fSOOYv+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632946519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c1ABNFoBo1LgtH8KX+kiNf5MSzSI0rhiaZugaCCGFME=;
 b=fSOOYv+VX4Nd3dFINuaSCqZK3r6J68v4Y3uHpP5SW7zAffzONSMnwGduEb+jxO1Jja5J2k
 UCQgs6lvQ0Y69F/snSQdzn3J4Ed+Ty/7APEJckedWVjf50TD4zSXu9vkO5ylMOixr7285l
 SPAGc2hFUVRb3Asnz8dAslv3cuaDXt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-OIOOsasNPbi_UcqAI0mVtg-1; Wed, 29 Sep 2021 16:15:17 -0400
X-MC-Unique: OIOOsasNPbi_UcqAI0mVtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B32981450F;
 Wed, 29 Sep 2021 20:15:15 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.194.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4E4618EC5;
 Wed, 29 Sep 2021 20:15:13 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH regression fix] ASoC: nau8824: Fix headphone vs headset,
 button-press detection no longer working
Date: Wed, 29 Sep 2021 22:15:12 +0200
Message-Id: <20210929201512.460360-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 stable@vger.kernel.org
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

Commit 1d25684e2251 ("ASoC: nau8824: Fix open coded prefix handling")
replaced the nau8824_dapm_enable_pin() helper with direct calls to
snd_soc_dapm_enable_pin(), but the helper was using
snd_soc_dapm_force_enable_pin() and not forcing the MICBIAS + SAR
supplies on breaks headphone vs headset and button-press detection.

Replace the snd_soc_dapm_enable_pin() calls with
snd_soc_dapm_force_enable_pin() to fix this.

Cc: stable@vger.kernel.org
Fixes: 1d25684e2251 ("ASoC: nau8824: Fix open coded prefix handling")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/nau8824.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index cea1d43e0cb8..77f647529354 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -874,8 +874,8 @@ static void nau8824_jdet_work(struct work_struct *work)
 	struct regmap *regmap = nau8824->regmap;
 	int adc_value, event = 0, event_mask = 0;
 
-	snd_soc_dapm_enable_pin(dapm, "MICBIAS");
-	snd_soc_dapm_enable_pin(dapm, "SAR");
+	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
+	snd_soc_dapm_force_enable_pin(dapm, "SAR");
 	snd_soc_dapm_sync(dapm);
 
 	msleep(100);
-- 
2.31.1


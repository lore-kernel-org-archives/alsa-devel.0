Return-Path: <SRS0=qF1Q=23=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5F1C33C8C
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:40:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9992071A
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tz9f+iSc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GE+tSq/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9992071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 482A317C0;
	Mon,  6 Jan 2020 12:39:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 482A317C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578310809;
	bh=vNyN7Wapxw12mvicvMa7O1bxzM36FhzNIqSp0fk16k8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tz9f+iScRayCcSiZpIgrRCCMYjF5fXUG5QwIKrGApREX/WE+yLiryYG54KxfEl3VJ
	 M158jJKcJmbemtjmgpJ+Wv5voragGjgrKUAOIhBIl4AAEF+MQj1Lp7twKm8jTq4V7C
	 rIUedwCnKgkUEJ86/xfsLbGBDLXKtOIKX2Lf0J9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7CAEF80149;
	Mon,  6 Jan 2020 12:39:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 821A8F80159; Mon,  6 Jan 2020 12:39:17 +0100 (CET)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B38EEF8010D
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2020 12:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B38EEF8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="GE+tSq/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578310752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7QnDS0wMpWsHdmbYrxKZ8IKh1lRAwVHzJpC+uPoDwz8=;
 b=GE+tSq/7alD9rIzPdAaGxJIhwDHNiM9LjZoAJuL09qe/G0YzTSDPjQMbJ4JL7lAnnDHIFl
 F0JxS0+Ts2s8Y1i0lmd0HuBzzS7golCJy2iuRVi/asRhj+N5liJBAPf7wE263/YrqVD2Sc
 ankfAUl0xneoHJNDtWcdP/HY2A//9Jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Z24N8wNUPDiyB4Y_xwyr8w-1; Mon, 06 Jan 2020 06:39:09 -0500
X-MC-Unique: Z24N8wNUPDiyB4Y_xwyr8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35429DB65;
 Mon,  6 Jan 2020 11:39:07 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-130.ams2.redhat.com
 [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C463F271BA;
 Mon,  6 Jan 2020 11:39:04 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Date: Mon,  6 Jan 2020 12:39:03 +0100
Message-Id: <20200106113903.279394-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 stable@vger.kernel.org, russianneuromancer@ya.ru
Subject: [alsa-devel] [PATCH] ASoC: Intel: bytcht_es8316: Fix Irbis NB41
	netbook quirk
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

When a quirk for the Irbis NB41 netbook was added, to override the defaults
for this device, I forgot to add/keep the BYT_CHT_ES8316_SSP0 part of the
defaults, completely breaking audio on this netbook.

This commit adds the BYT_CHT_ES8316_SSP0 flag to the Irbis NB41 netbook
quirk, making audio work again.

Cc: stable@vger.kernel.org
Cc: russianneuromancer@ya.ru
Fixes: aa2ba991c420 ("ASoC: Intel: bytcht_es8316: Add quirk for Irbis NB41 netbook")
Reported-and-tested-by: russianneuromancer@ya.ru
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 46612331f5ea..54e97455d7f6 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -442,7 +442,8 @@ static const struct dmi_system_id byt_cht_es8316_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "IRBIS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "NB41"),
 		},
-		.driver_data = (void *)(BYT_CHT_ES8316_INTMIC_IN2_MAP
+		.driver_data = (void *)(BYT_CHT_ES8316_SSP0
+					| BYT_CHT_ES8316_INTMIC_IN2_MAP
 					| BYT_CHT_ES8316_JD_INVERTED),
 	},
 	{	/* Teclast X98 Plus II */
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
